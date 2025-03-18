import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:house/model/contact_model.dart';
import 'package:house/model/posting_model.dart';

class BookingModel 
{
  String id = "";
  PostingModel? posting;
  ContactModel? contact;
  List<DateTime>? dates;

  BookingModel();

  getBookingInfoFromFirestoreFromPosting(PostingModel posting, DocumentSnapshot snapshot) async
  {

  }
}