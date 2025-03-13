import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:house/global.dart';
import 'package:house/model/app_constants.dart';
import 'package:house/model/posting_model.dart';

class PostingViewModel {

  addListingInfoToFirestore () async
  {
    

    postingModel.setImagesNames();

    Map<String, dynamic> dataMap = 
    {
      "address": postingModel.address,
      "amenities": postingModel.amenities,
      "bathrooms": postingModel.bathrooms,
      "description": postingModel.description,
      "beds": postingModel.beds,
      "city": postingModel.city,
      "country": postingModel.country,
      "hostID": AppConstants.currentUser.id,
      "imageNames": postingModel.imageNames,
      "name": postingModel.name,
      "price": postingModel.price,
      "rating": 3.5,
      "type": postingModel.type,
    };

    DocumentReference ref = await FirebaseFirestore.instance.collection("postings").add(dataMap);
    postingModel.id = ref.id;

    await AppConstants.currentUser.addPostingToMyPostings(postingModel);
  }

  addImagesToFirebaseStorage()async
  {
    

    for(int i = 0; i < postingModel.displayImages!.length; i++)
    {
      Reference ref = FirebaseStorage.instance.ref()
      .child("postingImages")
      .child(postingModel.id!)
      .child(postingModel.imageNames![i]);

      await ref.putData(postingModel.displayImages![i].bytes).whenComplete(() {});
    }
  }
}