import 'package:flutter/material.dart';
import 'package:house/global.dart';

class InboxScreen extends StatefulWidget {
  const InboxScreen({super.key});

  @override
  State<InboxScreen> createState() => _InboxScreenState();
}

class _InboxScreenState extends State<InboxScreen> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: inboxViewModel.getConversations(), 
      builder: (context, dataSnapshot)
      {
        if(dataSnapshot.connectionState == ConnectionState.waiting)
      }
      );
  }
}