import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {

  TextEditingController controllerSearch = TextEditingController();
  Stream stream = FirebaseFirestore.instance.collection('postings').snapshots();
  String searhType = "";

  bool isNameButtonSelected = false;
  bool isCityButtonSelected = false;
  bool isTypeButtonSelected = false;

  searchByField()
  {
   
  }

  pressSerachByButton(String searchTypeStr, bool isNameButtonSelectedB, bool isCityButtonSelectedB, bool isTypeButtonSelectedB)
  {
    searhType = searchTypeStr;
    isNameButtonSelected = isNameButtonSelectedB;
    isCityButtonSelected = isCityButtonSelectedB;
    isTypeButtonSelected = isTypeButtonSelectedB;
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(25, 15, 20, 0),
      child: SingleChildScrollView(
        child: Column(
          children: [

            // searchBar

            Padding(
              padding: EdgeInsets.only(top: 0, bottom: 0),
              child: TextField(
                decoration: const InputDecoration(
                  hintText: 'Search',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey,
                      width: 20.0,
                    ),
                  ),

                  contentPadding: EdgeInsets.all(5.0)
                ),
                style: const TextStyle(
                  fontSize: 20.0,
                  color: Colors.black,
                ),
                controller: controllerSearch,
                onEditingComplete: searchByField,
              ),
            ),

            // name - city - type - clear button

            SizedBox(
              height: 48,
              width: MediaQuery.of(context).size.width / .5,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                children: [

                  MaterialButton(onPressed: ()
                  {
                    pressSerachByButton("name", true, false, false);
                  },
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  color: isNameButtonSelected ? Colors.pinkAccent : Colors.white,
                  child: const Text("Name"),
                  ),

                  const SizedBox(width: 6.0,),

                  MaterialButton(onPressed: ()
                  {
                    pressSerachByButton("city", false, true, false);
                  },
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  color: isNameButtonSelected ? Colors.pinkAccent : Colors.white,
                  child: const Text("City"),
                  ),

                   const SizedBox(width: 6.0,),

                  MaterialButton(onPressed: ()
                  {
                    pressSerachByButton("type", false, false, true);
                  },
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  color: isNameButtonSelected ? Colors.pinkAccent : Colors.white,
                  child: const Text("Type"),
                  ),

                   const SizedBox(width: 6.0,),

                  MaterialButton(onPressed: ()
                  {
                    pressSerachByButton("", false, false, false);
                  },
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  color: isNameButtonSelected ? Colors.pinkAccent : Colors.white,
                  child: const Text("Clear"),
                  ),
                  
                ],
              ),
            ),
         
          // display listing

          StreamBuilder(
            stream: stream, 
            builder: (context, snapShots)
            {
              if(snapShots.hasData)
              {
                return GridView.builder(
                  gridDelegate: gridDelegate, 
                  itemBuilder: itemBuilder
                  );
              }

              else{
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }
            )
         
          ],
        ),
      ),
      );
  }
}