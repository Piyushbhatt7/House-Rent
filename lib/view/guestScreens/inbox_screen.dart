import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:house/global.dart';
import 'package:house/model/conversationModel.dart';

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
              DataSnapshot snapshot = dataSnapshot.data!.docs[index];

              ConversationModel currentConversation = ConversationModel();
            }
            );
        }
      }
      );
  }
}