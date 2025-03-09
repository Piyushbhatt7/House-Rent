import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:house/model/app_constants.dart';

class UserViewModel 
{

  signUp(email, password, firstName, lastName, city, country, bio, imageFileofUser) async
  {
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
         .whenComplete(()
         {
            saveAndUploadImageToFirebase(imageFileofUser);
         });
        
      });
      
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

saveAndUploadImageToFirebase(imageFileofUser)
{

}

}