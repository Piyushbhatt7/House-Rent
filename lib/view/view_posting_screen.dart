import 'package:flutter/material.dart';
import 'package:house/model/posting_model.dart';

class ViewPostingScreen extends StatefulWidget {

  PostingModel? posting;
  ViewPostingScreen({super.key, this.posting});

  @override
  State<ViewPostingScreen> createState() => _ViewPostingScreenState();
}

class _ViewPostingScreenState extends State<ViewPostingScreen> 
{

  PostingModel? posting;

  getRequiredInfo() async
  {
    await posting!.getAllImagesFromStorage();

    await posting!.getHostFromFirestore();

    setState(() {
      
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

   posting = widget.posting;

   getRequiredInfo();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace:  Container(
        decoration: BoxDecoration(
        gradient: LinearGradient(
        colors: [
        Colors.pinkAccent,
        Colors.amberAccent
        ],
        begin: FractionalOffset(0, 0),
        end: FractionalOffset(1, 0),
        stops: [0, 1],
        tileMode: TileMode.clamp,
      )
    ),),
    title: const Text('Posting Information'),
    actions: [

      IconButton(
        onPressed: ()
      {

      },
       icon: Icon(Icons.save, color: Colors.white,),
       )
    ],
      ),
      
      body: SingleChildScrollView(
        child: Column(
          children: [


            // listing images
            AspectRatio(aspectRatio: 3 / 2,
            child: PageView.builder(
              itemCount: posting!.displayImages!.length,
              itemBuilder: (context, index)
              {
                MemoryImage currentImage = posting!.displayImages![index];
                return Image(
                  image: currentImage,
                  fit: BoxFit.fill,
                  );
              }
            
            ),
            ),

            // posting name button // book now button
            // description - profile pic
            // apartment - beds - bathrooms
            // amenities 
            // the location

            Padding(
              padding: const EdgeInsets.fromLTRB(14, 14, 14, 0)
            
            )



          ],
        ),
      ),
   
    );
  }
}