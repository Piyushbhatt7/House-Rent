import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:house/model/contact_model.dart';

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
      
    }

    
}