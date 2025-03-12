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
        title: Text(
          "Create / Update a Posting"
        ),
        actions: [
          IconButton(onPressed: ()
          {

          }, icon: const Icon(Icons.upload)
          ),
        ],
      ),
    );
}
}