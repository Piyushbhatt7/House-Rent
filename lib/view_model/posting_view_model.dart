import 'package:house/model/posting_model.dart';

class PostingViewModel {

  addListingInfoToFirestore () async
  {
    PostingModel posting  = PostingModel();

    Map<String, dynamic> dataMap = 
    {
      "address": posting.address,
      
    };
  }
}