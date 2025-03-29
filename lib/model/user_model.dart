import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:house/global.dart';
import 'package:house/model/app_constants.dart';
import 'package:house/model/booking_model.dart';
import 'package:house/model/contact_model.dart';
import 'package:house/model/conversation_model.dart';
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
  
  List<PostingModel>? savedPostings;
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

      savedPostings = [];

      myPostings = [];
    }

    createContactFromUser()
    {
      return ContactModel(
        id: id,
        firstName: firstName,
        lastName: lastName,
        displayImage: displayImage,
      );
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
      List<String> myPostingIDs = List<String>.from(snapshot!["myPostingIDs"]) ?? [];

      for(String postingIDs in myPostingIDs)
      {
        PostingModel posting = PostingModel(id: postingIDs);
        await posting.getAllImagesFromStorage();
        await posting.getAllBookingsFromFirestore();
        await posting.getAllImagesFromStorage();

        myPostings!.add(posting);
      }
    }

    addSavedPosting(PostingModel posting) async
    {
      for(var savedPosting in savedPostings!)
      {
        if(savedPosting.id == posting.id)
        {
          return;
        }
      }

       savedPostings!.add(posting);

        List<String> savedPostingIDs = [];

        savedPostings!.forEach((savedPosting)
        {
          savedPostingIDs.add(savedPosting.id!);
        });

        await FirebaseFirestore.instance.collection("users").doc(id).update(
          {
            'savedPostingIDs' : savedPostingIDs,
          }
        );

        Get.snackbar("Marked as Favorite", "Saved to your Favorite List");
    }

    removeSavedPosting(PostingModel posting) async
    {
      for(int i = 0; i < savedPostings!.length; i++)
      {
        if(savedPostings![i].id == posting.id)
        {
          savedPostings!.removeAt(i);
          break;
        }
      }

        List<String> savedPostingIDs = [];

         savedPostings!.forEach((savedPosting)
        {
          savedPostingIDs.add(savedPosting.id!);
        });

        await FirebaseFirestore.instance.collection("users").doc(id).update(
          {
            'savedPostingIDs' : savedPostingIDs,
          }   
        );         
 
        Get.snackbar("Listing Removed", "Listing removed from favorite list");
    }            

   Future<void> addBookingToFirestore(BookingModel booking, double totalPriceForAllNights, String hostID) async
   {
     

     Map<String, dynamic> data = 
     {
      'dates': booking.dates,
      'postingID': booking.posting!.id,
     };

     await FirebaseFirestore.instance.doc('users/${id}/bookings/${booking.id}').set(data);

     String earningsOld = "";
          
     await FirebaseFirestore.instance.collection("users").doc(id).get().then((dataSnap)
     {
      earningsOld = dataSnap["earnings"].toString();
     });                 
                      
     await FirebaseFirestore.instance.collection("users")
     .doc(hostID)  
     .update(
      {
        "earnings": totalPriceForAllNights + int.parse(earningsOld), // 7:03 19
      }
     );
        bookings!.add(booking);

        await addBookingConversation(booking);
     }


    addBookingConversation(BookingModel booking) async
    {
      ConversationModel conversation = ConversationModel();
      conversation.addConversationToFirestore(booking.posting!.host!);

      String textMessage = "Hi my name is ${AppConstants.currentUser.firstName} and I have "
      "just booked ${booking.posting!.name} from ${booking.dates!.first} to "
      "${booking.dates!.last} if you have any questions contact me. Enjoy your "
      "stay!";

      await conversation.addMessageToFirestore(textMessage);
    } // 24 - start video

   

   List<DateTime> getAllBookedDates()
   {
     List<DateTime> getAllBookedDates = [];

     myPostings!.forEach((posting)
     {
      posting.bookings!.forEach((booking)
      {
        getAllBookedDates.addAll(booking.dates!);
      });
     });

     return getAllBookedDates;
   }

} 