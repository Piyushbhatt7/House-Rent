import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:get/get_core/get_core.dart';
import 'package:house/model/app_constants.dart';
import 'package:firebase_storage/firebase_storage.dart';


class UserViewModel 
{

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

addImageToFirebaseStorage(File imageFileofUser, currentUserID) async
{
  Reference referenceStorage = FirebaseStorage.instance.ref()
  .child("useImages")
  .child(currentUserID)
  .child(currentUserID + ".png");

  await referenceStorage.putFile(imageFileofUser).whenComplete((){});

  AppConstants.currentUser.displayImage = MemoryImage(imageFileofUser.readAsBytesSync()); // 26:14
}

login() async 
{
  try{
    
  }
}

}