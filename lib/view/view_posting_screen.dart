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
              padding: const EdgeInsets.fromLTRB(14, 14, 14, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                    // posting name and price - book now button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [


                      SizedBox(
                        width: MediaQuery.of(context).size.width / 1.55,
                        child: Text(
                          posting!.name!.toUpperCase(),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                          maxLines: 3,
                        ),
                      ),
                    
                    // 9:26 - 15

                  // book now button - price
                  Column(
                    children: <Widget>[

                      Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.pinkAccent,
                              Colors.amber,
                            ],
                            begin: FractionalOffset(0.0, 0.0),
                            end: FractionalOffset(1.0, 0.0),
                            stops: [0.0, 1.0],
                            tileMode: TileMode.clamp,
                            )
                        ),
                        child: MaterialButton(onPressed: ()
                        {
                          
                        },
                         child: const Text(
                          'Book Now',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),),
                      ),

                      Text(
                        '₹${posting!.price} / night',
                        style: const TextStyle(
                          fontSize: 14.0,
                        ),
                      )
                    ],
                  ),
                    ],
                  ),
                
                  
                  // description - profile pic
                  Padding(
                    padding: const EdgeInsets.only(top: 25.0, bottom: 25.0),
                    child: ,
                  )
                
                ],
              ),
            )



          ],
        ),
      ),
   
    );
  }
}