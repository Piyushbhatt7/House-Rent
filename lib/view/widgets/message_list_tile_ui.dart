import 'package:flutter/material.dart';
import 'package:house/model/app_constants.dart';
import 'package:house/model/message_model.dart';

class MessageListTileUi extends StatelessWidget {

  MessageModel? message;
  MessageListTileUi({super.key, this.message});

  @override
  Widget build(BuildContext context) {
    if(message!.sender!.firstName == AppConstants.currentUser.firstName) 
    {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 36, 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [

          Flexible(
            child: Padding(
              padding: const EdgeInsets.only(left: 11),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Colors.pinkAccent,
                      Colors.amber,
                    ],
                    begin: FractionalOffset(0.0, 0.0),
                    end: FractionalOffset(1.0, 0.0),
                    stops: [0.0, 1.0],
                    tileMode: TileMode.clamp
                    ),
                    borderRadius: BorderRadius.circular(10) // 11:17 - 25
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: Text(
                        message!.text!,
                        style: TextStyle(
                          fontSize: 20.0,
                        ),
                        textWidthBasis: TextWidthBasis.parent,
                      ),
                    
                    ),

                    Align(
                      alignment: Alignment.bottomRight,
                      child: Text(
                        message!.getMessageDateTime(),
                        style: const TextStyle(
                          fontSize: 15.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
               )
          )
        ],
      ),
      );
 
  }
  else {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 36, 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [

          GestureDetector(
            onTap: () {
              
            },
            child: CircleAvatar(
              backgroundImage: message!.sender!.displayImage,
              radius: MediaQuery.of(context).size.width / 20,
            ),
          ),

          Flexible(
            child: Padding(
              padding: const EdgeInsets.only(left: 11),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Colors.lightGreenAccent,
                      Colors.purpleAccent,
                    ],
                    begin: FractionalOffset(0.0, 0.0),
                    end: FractionalOffset(1.0, 0.0),
                    stops: [0.0, 1.0],
                    tileMode: TileMode.clamp
                    ),
                    borderRadius: BorderRadius.circular(10) // 11:17 - 25
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: Text(
                        message!.text!,
                        style: TextStyle(
                          fontSize: 20.0,
                        ),
                        textWidthBasis: TextWidthBasis.parent,
                      ),
                    
                    ),

                    Align(
                      alignment: Alignment.bottomRight,
                      child: Text(
                        message!.getMessageDateTime(),
                        style: const TextStyle(
                          fontSize: 15.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
               )
          )
        ],
      ),
      );
 
  }
  }
}