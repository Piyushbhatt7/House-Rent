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

  updateUI() async
  {
    await posting!.getFirstImageFromStorage();
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    posting =  widget.posting;

    updateUI();

  }
  @override
  Widget build(BuildContext context) 
  {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        AspectRatio(
          aspectRatio: 3 / 2,
          child: (posting!.displayImages!.isEmpty) 
          ? Container() 
          : Container(decoration: BoxDecoration(image: DecorationImage(image: posting!.displayImages!.first, fit: BoxFit.fill)),),
          ),

          Text(
            "${posting!.type} - ${posting!.city}, ${posting!.country}",
            maxLines: 2,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),

          Text(
            posting!.name!,
            maxLines: 1,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w200,
            ),
          ),

          Text(
            ' / month',
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          )
      ],
    );
  }
}