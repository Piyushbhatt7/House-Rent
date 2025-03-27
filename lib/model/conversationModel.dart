import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:house/model/app_constants.dart';
import 'package:house/model/contact_model.dart';
import 'package:house/model/message_model.dart';

class ConversationModel {

  String? id;
  ContactModel? contact;
  List<MessageModel>? messages;
  MessageModel? lastMessage;

  ConversationModel() 
  {
    messages = [];
  }

  addConversationToFirestore(ContactModel otherContact) async
  {
    List<String> userName = [
      AppConstants.currentUser.getFullNameofUser(),
      otherContact.getFullNameofUser()
    ];

    List<String> userIDs = [
      AppConstants.currentUser.id!,
      otherContact.id!,
    ];

    Map<String, dynamic> conversationDataMap = {

      'lastMessageDateTime': DateTime.now(),
      'lastMessageText': "",
      'userNames': userName,
      'userIDs': userIDs,
    };

    DocumentReference reference = await FirebaseFirestore.instance.collection('conversation').add(conversationDataMap);
    id = reference.id;
  }

}