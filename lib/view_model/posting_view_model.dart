import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:house/model/app_constants.dart';
import 'package:house/model/posting_model.dart';

class PostingViewModel {

  addListingInfoToFirestore () async
  {
    PostingModel posting  = PostingModel();

    Map<String, dynamic> dataMap = 
    {
      "address": posting.address,
      "amenities": posting.amenities,
      "bathrooms": posting.bathrooms,
      "description": posting.description,
      "beds": posting.beds,
      "city": posting.city,
      "country": posting.country,
      "hostID": AppConstants.currentUser.id,
      "imageNames": posting.imageNames,
      "name": posting.name,
      "price": posting.price,
      "rating": 3.5,
      "type": posting.type,
    };

    DocumentReference ref = await FirebaseFirestore.instance.collection("postings").add(dataMap);
    posting.id = ref.id;

    await AppConstants.currentUser
  }
}