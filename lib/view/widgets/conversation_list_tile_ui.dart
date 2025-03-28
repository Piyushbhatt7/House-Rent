import 'package:flutter/material.dart';
import 'package:house/model/conversationModel.dart';

class ConversationListTileUi extends StatefulWidget {

  ConversationModel? conversation;
   ConversationListTileUi({super.key, this.conversation});

  @override
  State<ConversationListTileUi> createState() => _ConversationListTileUiState();
}

class _ConversationListTileUiState extends State<ConversationListTileUi> {

  ConversationModel? conversation;

  getImageOfOtherContact()
  {
    
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    conversation = widget.conversation;

    conversation!.otherContact!.getImageFromStorage();

  }
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}