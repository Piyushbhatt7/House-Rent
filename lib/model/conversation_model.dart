import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:house/model/app_constants.dart';
import 'package:house/model/contact_model.dart';
import 'package:house/model/message_model.dart';

class ConversationModel {

  String? id;
  ContactModel? otherContact;
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

  addMessageToFirestore(String messageText) async
  {
    Map<String, dynamic> messgeData = {
      'dateTime': DateTime.now(),
      'senderID': AppConstants.currentUser.id,
      'text': messageText,
    };

    await FirebaseFirestore.instance.collection('conversation/${id}/messages').add(messgeData);
    Map<String, dynamic> conversationData = {
      'lastMessageDateTime': DateTime.now(),
      'lastMessageText': messageText
    };

    await FirebaseFirestore.instance.doc('conversations/${id}').update(conversationData);
  }

  getConversationInfoFomFirestore(DocumentSnapshot snapshot)
  {
    id = snapshot.id;

    String lastMessageText = snapshot['lastMessageText'] ?? "";
    Timestamp lastMessageDateTimestamp = snapshot['lastMessageDateTime'] ?? Timestamp.now();
    DateTime lastMessageDateTime = lastMessageDateTimestamp.toDate();

    lastMessage = MessageModel();
    lastMessage!.dateTime = lastMessageDateTime;
    lastMessage!.text = lastMessageText;

    List<String> userIDs = List<String>.from(snapshot['userIDs']) ?? [];
    List<String> userNames = List<String>.from(snapshot['userNames']) ?? [];
    otherContact = ContactModel();

    for(String userID in userIDs)
    {
      if(userID != AppConstants.currentUser.id)
      {
        otherContact!.id = userID;
        break;
      }
    }

    for(String name in userNames)
    {
      if(name != AppConstants.currentUser.getFullNameofUser())
      {
        otherContact!.firstName = name.split(" ")[0];
        otherContact!.lastName = name.split(" ")[1];
      }
    }
  }

  

}