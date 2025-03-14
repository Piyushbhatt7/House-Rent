import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:house/model/booking_model.dart';
import 'package:house/model/contact_model.dart';
import 'package:house/model/posting_model.dart';
import 'package:house/model/review_model.dart';

class UserModel extends ContactModel
{
  String? email;
  String? password;
  String? bio;
  String? city;
  String? country;
  bool? isHost;
  bool? isCurrentlyHosting;
  DocumentSnapshot? snapshot;
  

  List<BookingModel>? bookings;
  List<ReviewModel>? review;

  List<PostingModel>? myPostings;

  UserModel({
    String id = "",
    String firstName = "",
    String lastName = "",
    MemoryImage? displayImage,
    this.email = "",
    this.bio = "",
    this.city = "",
    this.country = "",
    }) : super (id: id, firstName: firstName, lastName: lastName, displayImage: displayImage)
    {
      isHost = false;
      isCurrentlyHosting = false;

      bookings = [];
      review = [];

      myPostings = [];
    }

    Future<void> saveUserToFirestore (bio, city, country, email, firstName, lastName, id) async
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
        "earnings": 0

      };

      await FirebaseFirestore.instance.collection("users").doc(id).set(dataMap);
    }

    addPostingToMyPostings(PostingModel posting) async
    {
      myPostings!.add(posting);

      List<String> myPostingIDsList = [];

      myPostings!.forEach((element)  // 12 - 0:00
      {
        myPostingIDsList.add(element.id!);
      } 
      );

      await FirebaseFirestore.instance.collection("users").doc(id).update(
        {
          'myPostingsIDs' : myPostingIDsList,
      });
    }

    getMyPostingsFromFirstore() async
    {
      
    }
}