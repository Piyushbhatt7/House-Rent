import 'package:flutter/material.dart';
import 'package:house/model/posting_model.dart';
import 'package:house/view/widgets/posting_grid_tile_ui.dart';

class BookListingScreen extends StatefulWidget
 {
  PostingModel? posting;

  
   BookListingScreen({super.key, this.posting});

  @override
  State<BookListingScreen> createState() => _BookListingScreenState();
}

class _BookListingScreenState extends State<BookListingScreen> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}