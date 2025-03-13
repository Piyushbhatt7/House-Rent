import 'package:flutter/material.dart';
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
     rating = 0; // 11  - 5:00; 
     
   }

   setImagesNames()
   {
    imageNames = [];

    for(int i = 0; i < displayImages!.length; i++)
    {
      imageNames!.add("image${i}.png");
    }
   }

  addImagesToFirebaseStorage() {}
}