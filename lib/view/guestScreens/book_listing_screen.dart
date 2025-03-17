import 'package:flutter/material.dart';
import 'package:house/model/posting_model.dart';


class BookListingScreen extends StatefulWidget
 {
  PostingModel? posting;

  
   BookListingScreen({super.key, this.posting});

  @override
  State<BookListingScreen> createState() => _BookListingScreenState();
}

class _BookListingScreenState extends State<BookListingScreen> {

  PostingModel? posting;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}