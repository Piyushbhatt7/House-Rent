import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel
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
    this.email = "",
    this.bio = "",
    this.city = "",
    this.country = "",
    });

    
}