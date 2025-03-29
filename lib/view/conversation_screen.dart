import 'package:flutter/material.dart';
import 'package:house/model/conversation_model.dart';

class ConversationScreen extends StatefulWidget {

  ConversationModel? conversation;
   ConversationScreen({super.key, this.conversation});

  @override
  State<ConversationScreen> createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {

  ConversationModel? conversation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    conversation = this.widget.conversation;

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.pinkAccent,
                Colors.amber,
              ],

              begin: FractionalOffset(0.0, 0.0),
              end: FractionalOffset(1.0, 0.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp,
            )
          ),
        ),

        backgroundColor: Colors.black,
        title: Text(conversation!.otherContact!.getFullNameofUser()),
      ),
      
      body: Column(
        children: [

          Expanded(child: 
          )
        ],
      ),
    
    );
  }
}