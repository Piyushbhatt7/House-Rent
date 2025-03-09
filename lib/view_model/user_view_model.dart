import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserViewModel 
{

  signUp(email, password, firstName, lastName, city, country, bio, imageFileofUser) async
  {
     await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email, 
      password: password
      ).then((result)
      {
        String currentUserID = result.user!.uid;
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

}