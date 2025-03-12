import 'package:flutter/material.dart';

class CreatePostingScreens extends StatefulWidget {
  const CreatePostingScreens({super.key});

  @override
  State<CreatePostingScreens> createState() => _CreatePostingScreensState();
}

class _CreatePostingScreensState extends State<CreatePostingScreens> {
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
          const EdgeInsets.fromLTRB(26, 26, 26, 0)
          ),
        ),
      ),
   
    );
}
}