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
    posting = posting;
    List<Timestamp> timestamps = List<Timestamp>.from(snapshot['dates']) ?? [];

    dates = [];
    timestamps.forEach((timestamps)
    {
      dates!.add((timestamps.toDate()));
    });

    String contactID = snapshot['userID'] ?? "";
    String fullName = snapshot['name'] ?? "";

    _loadContactInfo(id, fullName);

    contact = ContactModel(id: contactID);
  }

  _loadContactInfo(String id, String fullName)
  {
    String firstName = "";
    String lastName = "";
    firstName = fullName.split(" ")[0];
    lastName = fullName.split(" ")[1];
  }
}