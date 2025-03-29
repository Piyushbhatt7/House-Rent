import 'package:house/model/contact_model.dart';
import 'package:timeago/timeago.dart' as timeago;

class  MessageModel 
{
  ContactModel? sender;
  String? text;
  DateTime? dateTime;

  MessageModel();

  String getMessageDateTime()
  {
    return timeago.format(dateTime!);
  }

  getMessageInfoFromFirestore(DocumentSnapshot snapshot)
  {
    Timestamp lastMessageTimeStamp
  }
}