import 'package:flutter/material.dart';
import 'package:house/model/posting_model.dart';

class PostingListingingTileUI extends StatefulWidget {
  
  PostingModel? posting;

  PostingListingingTileUI({super.key, this.posting});

  @override
  State<PostingListingingTileUI> createState() => _PostingListingingTileUIState();
}

class _PostingListingingTileUIState extends State<PostingListingingTileUI>
 {
  
  PostingModel? posting;

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}