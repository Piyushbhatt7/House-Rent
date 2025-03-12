import 'package:flutter/material.dart';

class MyPostingScreen extends StatefulWidget {
  const MyPostingScreen({super.key});

  @override
  State<MyPostingScreen> createState() => _MyPostingScreenState();
}

class _MyPostingScreenState extends State<MyPostingScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 25.0),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(26.0, 0, 26, 26),
        child: InkResponse(
          onTap: () {
            
          },
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
                width: 1.2,
              ),
            ),
            
            child: ,
         
          ),
        ),
      
      ),
    );
  }
}