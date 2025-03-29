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
    return Container();
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
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  
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