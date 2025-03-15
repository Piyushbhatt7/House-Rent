import 'package:flutter/material.dart';
import 'package:house/model/posting_model.dart';

class PostingGridTileUi extends StatefulWidget {

  PostingModel? posting;
   PostingGridTileUi({super.key, this.posting});

  @override
  State<PostingGridTileUi> createState() => _PostingGridTileUiState();
}

class _PostingGridTileUiState extends State<PostingGridTileUi> 
{
  
  PostingModel? posting;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    posting =  widget.posting;

    

  }
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}