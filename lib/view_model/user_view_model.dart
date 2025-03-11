import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:get/get_core/get_core.dart';
import 'package:house/model/app_constants.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:house/model/user_model.dart';
import 'package:house/view/guestScreens/account_screen.dart';
import 'package:house/view/guest_home_screen.dart';


class UserViewModel 
{

    UserModel userModel = UserModel();

signUp(email, password, firstName, lastName, city, country, bio, imageFileofUser) async
  {

    Get.snackbar("Please wait", "we are creating your account.");

     try {
      
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email, 
      password: password
      ).then((result) async
      {
         String currentUserID = result.user!.uid;

          AppConstants.currentUser.id = currentUserID;
          AppConstants.currentUser.firstName = firstName;
          AppConstants.currentUser.lastName = lastName;
          AppConstants.currentUser.city = city;
          AppConstants.currentUser.country = country;
          AppConstants.currentUser.bio = bio;
          AppConstants.currentUser.email = email;
          AppConstants.currentUser.password = password;

         await saveUserToFirestore(bio, city, country, email, firstName, lastName, currentUserID)
         .whenComplete(() async
         {
            await addImageToFirebaseStorage(imageFileofUser, currentUserID);
         });
         
         Get.to(AccountScreen());
         Get.snackbar("Congrulation", "your account has been created.");
        
      });
     }

     catch(e)
     {
      Get.snackbar("Error", e.toString());
     }
      
  }
  
Future<void> saveUserToFirestore(bio, city, country, email, firstName, lastName, id) async
  {
    Map<String, dynamic> dataMap = 
    {
      "bio": bio,
      "city": city,
      "country": country,
      "email": email,
      "firstName": firstName,
      "lastName": lastName,
      "isHost": false,
      "myPostingIDs": [],
      "savedPostingIDs": [],
      "earnings": 0,
    };

    await FirebaseFirestore.instance.collection("users").doc(id).set(dataMap);
  }

Future<void> addImageToFirebaseStorage(File imageFileofUser, String currentUserID) async {
  try {
    Reference referenceStorage = FirebaseStorage.instance.ref()
        .child("userImages") // Ensure folder name is correct
        .child(currentUserID)
        .child("$currentUserID.png");

    UploadTask uploadTask = referenceStorage.putFile(imageFileofUser);

    TaskSnapshot snapshot = await uploadTask;
    String imageUrl = await snapshot.ref.getDownloadURL();
    
    print("Image uploaded successfully. URL: $imageUrl");
  } catch (e) {
    print("Error uploading image: $e");
  }
}


login(email, password) async 
{
   Get.snackbar("Please wait", "checking your credentials....");

  try
  {
    FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email, 
      password: password
      ).then((result) async
      {
        String currentUserID = result.user!.uid;
        AppConstants.currentUser.id = currentUserID;

        await getUserInfoFromFirestore(currentUserID);
        await getImageStorage(currentUserID);
        
        Get.snackbar("Logged-In", "you are loggen-in successufully.");
        Get.to(GuestHomeScreen());
        
      });
      
  }

  catch(e)
  {
    Get.snackbar("Error", e.toString());
  }
}

getUserInfoFromFirestore (userID) async
{
  DocumentSnapshot snapshot = await FirebaseFirestore.instance.collection('users').doc(userID).get();

  AppConstants.currentUser.snapshot = snapshot;
  AppConstants.currentUser.firstName = snapshot['firstName'] ?? "";
  AppConstants.currentUser.lastName = snapshot['lastName'] ?? "";
  AppConstants.currentUser.email = snapshot['email'] ?? "";
  AppConstants.currentUser.bio = snapshot['bio'] ?? "";
  AppConstants.currentUser.city = snapshot['city'] ?? "";
  AppConstants.currentUser.country = snapshot['country'] ?? "";
  AppConstants.currentUser.isHost = snapshot['isHost'] ?? false;
  //AppConstants.currentUser.displayImage = snapshot['displayImage'] ?? "";
}

getImageStorage(String userID) async {
  try {
    final ref = FirebaseStorage.instance.ref()
        .child("userImages")
        .child(userID)
        .child("$userID.png");

    final imageDataInBytes = await ref.getData(1024 * 1024);

    if (imageDataInBytes != null) {
      AppConstants.currentUser.displayImage = MemoryImage(imageDataInBytes);
      print("Image successfully fetched for user: $userID");
    } else {
      print("Image is null, might not exist in Firebase Storage.");
    }
  } catch (e) {
    print("Error fetching image: $e");
  }
}

becomeHost (String userID) async
{

  userModel.isHost = true;

  Map<String, dynamic> dataMap = 
  {
    "isHost" : true,
  };

  await FirebaseFirestore.instance.collection("users").doc(userID).update(dataMap);

}

 modifyCurrentlyHosting(bool isHosting)
 {
   userModel.isCurrentlyHosting = isHosting;
   
 }
}