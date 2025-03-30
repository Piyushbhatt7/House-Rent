import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:house/global.dart';
import 'package:house/model/conversation_model.dart';
import 'package:house/view/conversation_screen.dart';
import 'package:house/view/widgets/conversation_list_tile_ui.dart';

class InboxScreen extends StatefulWidget {
  const InboxScreen({super.key});

  @override
  State<InboxScreen> createState() => _InboxScreenState();
}

class _InboxScreenState extends State<InboxScreen> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: inboxViewModel.getConversations(), 
      builder: (context, dataSnapshot)
      {
        if(dataSnapshot.connectionState == ConnectionState.waiting)
        {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        else{
          return ListView.builder(
            itemCount: dataSnapshot.data!.docs.length,
            itemBuilder: (context, index)
            {
              DocumentSnapshot snapshot = dataSnapshot.data!.docs[index];

              ConversationModel currentConversation = ConversationModel();
              currentConversation.getConversationInfoFomFirestore(snapshot); // 4:07 - 24

              return InkResponse(
                onTap: (){
                  Get.to(ConversationScreen(conversation: currentConversation,));
                },
                child: ConversationListTileUi(
                  conversation: currentConversation,
                ),
              );
            }
            );
        }
      }
      );
  }
}