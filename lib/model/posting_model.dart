import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:get/utils.dart';
import 'package:house/global.dart';
import 'package:house/model/app_constants.dart';
import 'package:house/model/booking_model.dart';
import 'package:house/model/contact_model.dart';
import 'package:house/model/review_model.dart';

class PostingModel 
{
   String? id;
   String? name;
   String? type;
   double? price;
   String? description;
   String? address;
   String? city;
   String? country;
   double? rating;
   

   ContactModel? host;

   List<String>? imageNames;
   List<MemoryImage>? displayImages;
   List<String>? amenities;

   Map<String, int>? beds;
   Map<String, int>? bathrooms;

   List<BookingModel>? bookings;
   List<ReviewModel>? review;

   PostingModel({this.id = "", this.name = "", this.type = "", this.price = 0, this.description = "", this.address = "", this.city = "", this.country = "", this.host})
   {
     displayImages = [];
     amenities = [];

     beds = {};
     bathrooms = {};
     rating = 0; 

     bookings = [];
     review = [];
       // 14 - 11:58
   }

   setImagesNames()
   {
    imageNames = [];

    for(int i = 0; i < displayImages!.length; i++)
    {
      imageNames!.add("image${i}.png"); // changed to s
    } 
   }

  getMyPostingsFromFirestore() async {
  try {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance.collection('postings').doc(id).get();
    getPostingInfoFromSnapshot(snapshot);
  } catch (e) {
    print("Error fetching document: $e");
  }
}


  getPostingInfoFromSnapshot(DocumentSnapshot snapshot) {
  Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;

  if (data != null) {
    address = data['address'] ?? "";
    amenities = data.containsKey('amenities') ? List<String>.from(data['amenities']) : [];
    bathrooms = data.containsKey('bathrooms') ? Map<String, int>.from(data['bathrooms']) : {};
    beds = data.containsKey('beds') ? Map<String, int>.from(data['beds']) : {};
    city = data['city'] ?? "";
    country = data['country'] ?? "";
    description = data['description'] ?? "";

    String hostID = data['hostID'] ?? "";
    host = ContactModel(id: hostID);

    imageNames = data.containsKey('imageNames') ? List<String>.from(data['imageNames']) : []; // removed the
    name = data['name'] ?? "";
    price = data.containsKey('price') ? data['price'].toDouble() : 0.0;
    rating = data.containsKey('rating') ? data['rating'].toDouble() : 2.5;
    type = data['type'] ?? "";
  }
}


 Future<List<MemoryImage>> getAllImagesFromStorage() async {
  displayImages ??= [];
  displayImages!.clear();

  for (String imageName in imageNames ?? []) {
    try {
      final imageData = await FirebaseStorage.instance
          .ref()
          .child("postingImages/$id/$imageName")
          .getData(2 * 1024 * 1024); // Increased size to 2MB

      if (imageData != null) {
        displayImages!.add(MemoryImage(imageData));
        print("Image loaded: $imageName");
      }
    } catch (e) {
      print("Error loading image $imageName: $e");
    }
  }
  return displayImages!;
}


 Future<MemoryImage?> getFirstImageFromStorage() async {
  if (displayImages != null && displayImages!.isNotEmpty) {
    return displayImages!.first;  // ✅ If already loaded, return the first image
  }

  if (imageNames == null || imageNames!.isEmpty) {
    print("No images found in imageNames list.");
    return null;
  }

  try {
    String imagePath = "postingImages/$id/${imageNames!.first}";
    print("Fetching from path: $imagePath"); // Debugging

    final imageData = await FirebaseStorage.instance
        .ref()
        .child("postingImages")
        .child(id!)
        .child(imageNames!.first)
        .getData(1024 * 1024);

    if (imageData != null) {
      MemoryImage image = MemoryImage(imageData);
      displayImages ??= [];  // ✅ Ensure the list is initialized
      displayImages!.add(image);
      return image;  // ✅ Return the fetched image
    }
  } catch (e) {
    print("Error fetching image: $e");
  }

  return null;  // ✅ Return null if image fetching fails
}




  getAmenitiesString ()
  {
    if(amenities!.isEmpty)
    {
      return "";
    }

    String amenitiesString = amenities.toString();

    return amenitiesString.substring(1, amenitiesString.length - 1);
  }

  double getCurrentRating()
  {
    if(review!.length == 0)
    {
      return 4;
    }

    double rating = 0;

    review!.forEach((review)
    {
      rating += review.rating!;
    });

    rating /= review!.length;

    return rating;
  }

  getHostFromFirestore() async
  {
    await host!.getContactInfoFromFirestore();
    await host!.getImageFromStorage();
  }

  int getGuestsNumber() 
  {
    int? numGuests = 0;

    numGuests + numGuests + beds!['small']!; 
    numGuests = numGuests + beds!['medium']! * 2;
    numGuests = numGuests + beds!['large']! * 2;
    

    return numGuests;
  }

  String getBedroomText()
  {
    String text = "";

    if(beds!["small"] != 0)
    {
      text = text + beds!["small"].toString() + "single";
    }

     if(beds!["medium"] != 0)
    {
      text = text + beds!["medium"].toString() + "double";
    }

     if(beds!["large"] != 0)
    {
      text = text + beds!["large"].toString() + "queen / king";
    }

    return text;
  }

  String getBathroomText()
  {

    String text = "";

    if(bathrooms!['full'] !=0 )
    {
      text = text + bathrooms!["full"].toString() + " full ";
    }

    if(bathrooms!["half"] != 0)
    {
      text = text + bathrooms!["half"].toString() + " half ";
    }

    return text; // 14:13 - 15
  }

  String getFullAddress ()
  {
    return address! + ", " + city! + ", " + country!;
  }

  getAllBookingsFromFirestore() async
  {
    QuerySnapshot snapshots = await FirebaseFirestore.instance.collection('postings')
    .doc(id).collection('bookings')
    .get();

    for(var snapshot in snapshots.docs)
    {
       BookingModel newBooking = BookingModel();

       await newBooking.getBookingInfoFromFirestoreFromPosting(this, snapshot);

       bookings!.add(newBooking); // 21:02 - 17
    }
  }

  List<DateTime> getAllBookedDates()
  {
    List<DateTime> dates = [];

    bookings!.forEach((booking)
    {
      dates.addAll(booking.dates!);
    });

    return dates;
  }

  Future<void> makeNewBooking(List<DateTime> dates, context, hostID) async
  {
    Map<String, dynamic> bookingData = {
      'dates': dates,
      'name': AppConstants.currentUser.getFullNameofUser(),
      'userID': AppConstants.currentUser.id,
      'payment': bookingPrice,
    };

    DocumentReference reference = await FirebaseFirestore.instance.collection('postings')
    .doc(id)
    .collection('bookings').add(bookingData);

    BookingModel newBooking = BookingModel();

    newBooking.createBooking(this, AppConstants.currentUser.createUserFromContact(), dates);
    newBooking.id = reference.id;

    bookings!.add(newBooking);
    await AppConstants.currentUser.addBookingToFirestore(newBooking, bookingPrice!, hostID);

    Get.snackbar("", "Booked successfully"); // 18 :24 
  }

  
}