import 'package:flutter/material.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/route_manager.dart';
import 'package:house/model/app_constants.dart';
import 'package:house/model/posting_model.dart';
import 'package:house/view/guestScreens/book_listing_screen.dart';
import 'package:house/view/widgets/posting_info_tile_ui.dart';

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
    title: const Text('Posting Information', style: TextStyle(
      color: Colors.white
    ),) ,
    actions: [

      IconButton(
        onPressed: ()
      {
        AppConstants.currentUser.addSavedPosting(posting!);
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
                          Get.to(BookListingScreen(posting: posting, hostID: posting!.host!.id!));
                        },
                         child: const Text(
                          'Book Now',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),),
                      ),

                      Text(
                        '₹${posting!.price} / month',
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
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        SizedBox(
                          width: MediaQuery.of(context).size.width / 1.75,
                          child: Text(
                            posting!.description!,
                            textAlign: TextAlign.justify,
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                            maxLines: 5,
                          ),
                        ),

                        Column(

                          children: [

                            GestureDetector(
                              onTap: () {
                                
                              },
                              child: CircleAvatar(
                                radius: MediaQuery.of(context).size.width / 12.5,
                                backgroundColor: Colors.black,
                                child: CircleAvatar(
                                  backgroundImage: posting!.host!.displayImage,
                                  radius: MediaQuery.of(context).size.width / 13,
                                ),
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.only(top: 10.0),
                              child: Text(
                                posting!.host!.getFullNameofUser()
                              ),
                              )
                          ],


                        )
                      ],
                    ),
                  ),
                
                  
                  // aprtment - beds - bathrooms

                  Padding(
                    padding: const EdgeInsets.only(bottom: 25.0),
                    child: ListView(
                      shrinkWrap: true,
                      children: [

                        PostingInfoTileUi(
                          iconData: Icons.home,
                          category: posting!.type!,
                          categoryInfo: '${posting!.getGuestsNumber()} guests',
                        ),

                        PostingInfoTileUi( 
                          iconData: Icons.hotel, 
                          category: 'Beds', 
                          categoryInfo: posting!.getBedroomText(),
                        ),

                        PostingInfoTileUi(
                          iconData: Icons.wc,
                          category: 'Bathrooms',
                          categoryInfo: posting!.getBathroomText(),
                        ),
                      ],
                    ),
                     ),
                
                 // amenities

                 Padding(
                  padding: const EdgeInsets.only(top: 5.0, bottom: 25),
                  child: GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    childAspectRatio: 3.6,
                    children: List.generate(
                      posting!.amenities!.length,
                      (index) {
                        String currentAmenity = posting!.amenities![index];
                        return Chip(
                          label: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Text(
                              currentAmenity,
                              style: const TextStyle(
                                color: Colors.black45,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          backgroundColor: Colors.white10,
                        );
                      }
                      
                      
                      )
                    )
                  ),
               
               
                 // location

                 const Text(
                  'The Location',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                 ),

                 Padding(padding: const EdgeInsets.only(top: 2.0, bottom: 8.0),
                 child: Text(
                  posting!.getFullAddress(),
                  style: const TextStyle(
                    fontSize: 15,
                  ),
                 ),
                 )
                ],
              ),
            ),



          ],
        ),
      ),
   
    );
  }
}