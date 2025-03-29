import 'package:flutter/material.dart';
import 'package:house/model/conversation_model.dart';

class ConversationScreen extends StatefulWidget {

  ConversationModel? conversation;
  const ConversationScreen({super.key});

  @override
  State<ConversationScreen> createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}