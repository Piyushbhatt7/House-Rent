import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:house/global.dart';
import 'package:house/model/app_constants.dart';
import 'package:house/model/posting_model.dart';
import 'package:house/view/guest_home_screen.dart';
import 'package:house/view/host_home_screen.dart';
import 'package:house/view/widgets/amenities_ui.dart';
import 'package:image_picker/image_picker.dart';

class CreatePostingScreens extends StatefulWidget 
{
  PostingModel? posting;
   CreatePostingScreens({super.key, this.posting});

  @override
  State<CreatePostingScreens> createState() => _CreatePostingScreensState();
}

class _CreatePostingScreensState extends State<CreatePostingScreens> {

  final formKey = GlobalKey<FormState>();
  TextEditingController _nameTextEditingController = TextEditingController();
  TextEditingController _priceTextEditingController = TextEditingController();
  TextEditingController _descriptionTextEditingController = TextEditingController();
  TextEditingController _addressTextEditingController = TextEditingController();
  TextEditingController _cityTextEditingController = TextEditingController();
  TextEditingController _countryTextEditingController = TextEditingController();
  TextEditingController _amenitiesTextEditingController = TextEditingController();

  final List<String> residenceTypes = [

    'Detached House',
    'Villa',
    'Apartment',
    'Room',
    'Flat',
    'Town House',
    'Studio',
    
  ];

  Map<String, int>? _beds;
  Map<String, int>? _bathrooms;
  List<MemoryImage>? _imageList;
  

  String residenceTypeSelected = "";

  _selectImageFromGallery(int index) async {
    var imageFilePickedFromGalery =
    await ImagePicker().pickImage(source: ImageSource.gallery);

    if (imageFilePickedFromGalery != null) {

      MemoryImage imageFileInBytesForm = MemoryImage(
      (File(imageFilePickedFromGalery.path)).readAsBytesSync());

      if (index < 0) {
        _imageList!.add(imageFileInBytesForm);
      } else {
        _imageList![index] = imageFileInBytesForm;
      }

      setState(() {});
    }
  }

  initializeValues()
  {

    if(widget.posting == null)
    {

    _nameTextEditingController = TextEditingController(text: "");
    _priceTextEditingController = TextEditingController(text: "");
    _descriptionTextEditingController = TextEditingController(text: "");
    _addressTextEditingController = TextEditingController(text: "");
    _cityTextEditingController = TextEditingController(text: "");
    _countryTextEditingController = TextEditingController(text: "");
    _amenitiesTextEditingController = TextEditingController(text: "");
    residenceTypeSelected = residenceTypes.first;

    _beds = {
      'small': 0,
      'medium': 0,
      'large': 0,
    };

    _bathrooms = {
      'full': 0,
      'half': 0,
    };

    _imageList = [];
    }
    else
    {
      _nameTextEditingController = TextEditingController(text: widget.posting!.name);
      _priceTextEditingController = TextEditingController(text: widget.posting!.price.toString());
      _descriptionTextEditingController = TextEditingController(text: widget.posting!.description);
      _addressTextEditingController = TextEditingController(text: widget.posting!.address);
      _cityTextEditingController = TextEditingController(text: widget.posting!.city);
      _countryTextEditingController = TextEditingController(text: widget.posting!.country);
      _amenitiesTextEditingController = TextEditingController(text: widget.posting!.getAmenitiesString());
      _beds = widget.posting!.beds;
      _bathrooms = widget.posting!.bathrooms;
      _imageList = widget.posting!.displayImages;
      residenceTypeSelected = widget.posting!.type!;
    }

    setState(() {
      
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    initializeValues();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
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
    ),
        ),
        title: Text(
          "Create / Update a Posting",
          style: TextStyle(
            fontSize: 21 
          ),
        ),
        actions: [
          IconButton(onPressed: () async
          {
            if(!formKey.currentState!.validate())
            {
              return;
            }

            if(residenceTypeSelected == "")
            {
              return;
            }

            if(_imageList!.isEmpty)
            {
              return;
            }
            
            

            postingModel.name = _nameTextEditingController.text;
            postingModel.price = double.parse(_priceTextEditingController.text);
            postingModel.description = _descriptionTextEditingController.text;
            postingModel.address = _addressTextEditingController.text;
            postingModel.city = _cityTextEditingController.text;
            postingModel.country = _countryTextEditingController.text;
            postingModel.amenities = _amenitiesTextEditingController.text.split(",");
            postingModel.type = residenceTypeSelected;
            postingModel.beds = _beds;
            postingModel.bathrooms = _bathrooms;
            postingModel.displayImages = _imageList;

            postingModel.host = AppConstants.currentUser.createUserFromContact();

            postingModel.setImagesNames();


            // if this is new listing or old post to update // 11:06

            if(widget.posting == null)
            {
              postingModel.rating = 3.5;
              postingModel.bookings = [];
              postingModel.review = [];
            
              await postingViewModel.addListingInfoToFirestore();

              await postingViewModel.addImagesToFirebaseStorage();

              Get.snackbar("New Listing", "your listing is uploded successufully.");
            }

            else
            {
              postingModel.rating = widget.posting!.rating;
              postingModel.bookings = widget.posting!.bookings;
              postingModel.review = widget.posting!.review;
              postingModel.id = widget.posting!.id;

              for(int i = 0; i < AppConstants.currentUser.myPostings!.length; i++)
              {
                if(AppConstants.currentUser.myPostings![i].id == postingModel.id)
                {
                  AppConstants.currentUser.myPostings![i] = postingModel;
                  break;
                }
              }
           
              await postingViewModel.updatePostingInfoToFirestore();

               Get.snackbar("Update Listing", "your is updated successufully.");
            }
          
          // clear posting model
          postingModel = PostingModel();

          Get.to(HostHomeScreen()); 

          },  
          icon: const Icon(Icons.upload)
          ),
        ],                               
      ),
      
      body: Center(
        child: SingleChildScrollView(
          child: Padding(padding: 
          const EdgeInsets.fromLTRB(26, 26, 26, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                   
                   // Listing name
                    Padding(padding: 
                    const EdgeInsets.only(top: 1.0),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: "Listing name"
                      ),
                      style: const TextStyle(
                        fontSize: 25.0
                      ),
                      controller: _nameTextEditingController,
                      validator: (textInput) {
                        if(textInput!.isEmpty)
                        {
                          return "please enter a valid name";
                        } 
                        return null;
                      },
                    ),
                    ),
                 
                    // Slect property type       

                    Padding(padding: 
                    const EdgeInsets.only(top: 28.0),
                    child: DropdownButton(
                      items: residenceTypes.map((item)
                      {
                          return DropdownMenuItem(
                            value: item,
                            child: Text(
                              item,
                              style: TextStyle(
                                fontSize: 20.0,
                              ),
                            )
                            );
                      }).toList(),
                      onChanged: (valueItem)
                      {
                        setState(() {
                          residenceTypeSelected = valueItem.toString();
                        });
                      },
                      isExpanded: true,
                      value: residenceTypeSelected,
                      hint: const Text(
                        "Select property type",
                        style: TextStyle(                 
                          fontSize: 20.0                
                        ), 
                      ),        
                      ),
                    ), 
                                           
                    // Price  
                  
                  Padding(padding: 
                  const EdgeInsets.only(top: 21.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
 
                       Expanded(
                        child: TextFormField(
                          decoration: const InputDecoration(
                            labelText: "Price"
                          ),
                          style: TextStyle(
                            fontSize: 25.0,
                          ),
                          keyboardType: TextInputType.number,
                          controller: _priceTextEditingController,
                          validator: (text) {
                            if(text!.isEmpty)
                            {
                              return "please enter a valid price";
                            }
                            return null;
                          },
                        )
                       ),

                       const Padding(padding: 
                        EdgeInsets.only(
                        left: 10.0, bottom: 10.0,
                       ),
                       child: Text(
                        "\₹ / month",
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                       ),
                       )
                   
                   
                    ],
                  ),
                  ),
                
                  // description

                  Padding(padding: 
                  const EdgeInsets.only(top: 21.0),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: "Description"
                    ),
                    style: const TextStyle(
                      fontSize: 25.0,
                    ),
                    controller: _descriptionTextEditingController,
                    maxLines: 3,
                    minLines: 1,
                    validator: (text) {
                      if(text!.isEmpty)
                      {
                        return "please enter a valid description";

                      }
                      return null;
                    },
                  ),
                  ),
                  
                 
                  // address

                  Padding(padding: 
                  const EdgeInsets.all(21.0),
                  child: TextFormField(
                    enabled: true,
                    decoration: const InputDecoration(
                      labelText: "Address",
                    ),
                    maxLines: 3,
                    style: TextStyle(
                      fontSize: 25.0
                    ),
                    controller: _addressTextEditingController,
                    validator: (text) {
                      if(text!.isEmpty)
                      {
                        return "please enter a valid address";

                      }
                      return null;
                    },
                  ),
                  ),
                 
                  // beds
                  const Padding(padding: 
                     EdgeInsets.only(top: 30.0),
                     child: Text(
                      'Beds',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                     ),
                  ),

                 Padding(padding: 
                 const EdgeInsets.only(top: 21.0, left: 15.0, right: 15.0),
                 child: Column(
                  children: <Widget>[
                  // for single beds

                  AmenitiesUi(
                    type: 'Single', 
                    startValue: _beds!['small']!, 
                    decreaseValue: ()
                    {
                      _beds!['small'] = _beds!['small']! - 1; // 14:21

                      if(_beds!['small']! < 0)
                      {
                        _beds!['small'] = 0;
                      }
                    }, 
                    increasesValue: ()
                    {
                       _beds!['small'] = _beds!['small']! + 1;
                    }
                    ),

                    // for double bed
                    AmenitiesUi(
                    type: 'Double', 
                    startValue: _beds!['medium']!, 
                    decreaseValue: ()
                    {
                      _beds!['medium'] = _beds!['medium']! - 1; // 14:21

                      if(_beds!['medium']! < 0)
                      {
                        _beds!['medium'] = 0;
                      }
                    }, 
                    increasesValue: ()
                    {
                       _beds!['medium'] = _beds!['medium']! + 1;
                    }
                    ),

                    // king size bed 
                    AmenitiesUi(
                    type: 'King', 
                    startValue: _beds!['large']!, 
                    decreaseValue: ()
                    {
                      _beds!['large'] = _beds!['large']! - 1; // 14:21

                      if(_beds!['large']! < 0)
                      {
                        _beds!['large'] = 0;
                      }
                    }, 
                    increasesValue: ()
                    {
                       _beds!['large'] = _beds!['large']! + 1;
                    }
                    ),
                    
                   
                  ],
                 ),
                 ),
                 
                // Bathroomm
                const Padding(padding: 
                EdgeInsets.only(top: 20.0),
                child: Text(
                  'Bathrooms',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ),


                Padding(padding: 
                const EdgeInsets.fromLTRB(15, 25, 15, 0),
                child: Column(
                  children: <Widget>[
                   
                   // full bathroom
                    AmenitiesUi(
                      type: 'Full', 
                      startValue: _bathrooms!['full']!, 
                      decreaseValue: ()
                      {
                        _bathrooms!['full'] = _bathrooms!['full']! - 1;

                        if(_bathrooms!['full']! < 0)
                        {
                          _bathrooms!['full'] = 0;
                        }
                      }, 
                      increasesValue: ()
                      {
                        _bathrooms!['full'] = _bathrooms!['full']! + 1;
                      }
                      
                      ),


                      // half bathroom
                       AmenitiesUi(
                      type: 'Half', 
                      startValue: _bathrooms!['half']!, 
                      decreaseValue: ()
                      {
                        _bathrooms!['half'] = _bathrooms!['half']! - 1;

                        if(_bathrooms!['half']! < 0)
                        {
                          _bathrooms!['half'] = 0;
                        }
                      }, 
                      increasesValue: ()
                      {
                        _bathrooms!['half'] = _bathrooms!['half']! + 1;
                      }
                      
                      )
                  
                  
                  
                  
                  
                  ],
                ),
                ),

                
                // extra amenities

                Padding(padding: 
                const EdgeInsets.only(top: 21.0),
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: "Amenities"
                  ),
                  style: const TextStyle(
                    fontSize: 25.0,
                  ),
                  controller: _amenitiesTextEditingController,
                  validator: (text) {
                    if(text!.isEmpty)
                    {
                      return "please enter valid amenities";
                    }
                    return null;
                  },
                  maxLines: 3,
                  minLines: 1,

                ),
                ),

                // photos of residencee
                const Padding(padding: 
                EdgeInsets.only(top: 20.0),
                child: Text(
                  'Photos',
                  style: TextStyle(
                    fontSize: 20.0,              // 18:02 - 10
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ),


                Padding(padding: 
                const EdgeInsets.only(top: 20.0, bottom: 25.0),
                child: GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 25,
                    crossAxisSpacing: 25,
                    childAspectRatio: 3 / 2
                    ), 
                  itemCount: _imageList!.length + 1,
                  itemBuilder: (context, index)
                  {
                    if(index == _imageList!.length)
                    {
                      return IconButton(
                        onPressed: ()
                        {
                          _selectImageFromGallery(-1);
                        }, 
                      icon: const Icon(Icons.add),
                      
                      );
                    }
                    return MaterialButton(onPressed: ()
                    {

                    },
                    child: Image(
                      image: _imageList![index],
                      fit: BoxFit.fill,
                      ),
                    );
                  }
                  ),
                ),



                  ],
                ),
                
                ),
            ],
          ),
          ),
        ),
      ),
   
    );
}
}