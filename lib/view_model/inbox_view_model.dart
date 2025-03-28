import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:house/model/app_constants.dart';

class InboxViewModel {

  getConversations()
  {
    return FirebaseFirestore.instance
    .collection('conversations')
    .where('userIDs', arrayContains: AppConstants.currentUser.id)
    .snapshots()
  }
}