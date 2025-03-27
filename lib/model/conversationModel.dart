import 'package:house/model/contact_model.dart';
import 'package:house/model/message_model.dart';

class ConversationModel {

  String? id;
  ContactModel? contact;
  List<MessageModel>? message;
  MessageModel? lastMessage;

  Conversation() 
  {
    message = [];
  }

}