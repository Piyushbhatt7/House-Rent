import 'package:flutter/material.dart';

class CreatePostingScreens extends StatefulWidget {
  const CreatePostingScreens({super.key});

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
    'Condo',
    'Flat',
    'Town House',
    'Studio',
  ];

  String residenceTypeSelected = "";

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
          IconButton(onPressed: ()
          {

          }, icon: const Icon(Icons.upload)
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
                      }
                      ),
                    )
                  ],
                )
                
                )
            ],
          ),
          ),
        ),
      ),
   
    );
}
}