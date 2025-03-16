import 'package:flutter/material.dart';

class PostingInfoTileUi extends StatefulWidget 
{

  IconData? iconData;
  String? category;
  String? categoryInfo;
   PostingInfoTileUi({super.key, this.iconData, this.category, this.categoryInfo});

  @override
  State<PostingInfoTileUi> createState() => _PostingInfoTileUiState();
}

class _PostingInfoTileUiState extends State<PostingInfoTileUi> 
{
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        widget.iconData,
        size: 30,
      ),
      title: Text(
        widget.category!,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 25,
        ),
      ),
    );
  }
}