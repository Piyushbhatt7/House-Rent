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
  void initState() {
    // TODO: implement initState
    super.initState();

    posting = widget.posting;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ListTile(
        leading: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(
            posting!.name!,
            maxLines: 2,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold
            ),
          ),
          
        ),
        trailing: AspectRatio(
          aspectRatio: 3 / 2,
          child: Image(
            image: posting!.displayImages!.first,
            fit: BoxFit.fitWidth,
          
          ),
          ),    
      
      ),
    
    
    );
  }
}