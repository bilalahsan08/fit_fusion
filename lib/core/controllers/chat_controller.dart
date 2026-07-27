import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class ChatController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final DatabaseReference _chatListDatabase = FirebaseDatabase.instance.ref().child('ChatList');
  final DatabaseReference _chatDatabase = FirebaseDatabase.instance.ref().child('Chat');

  final TextEditingController messageController = TextEditingController();

  String? get currentUserId => _auth.currentUser?.uid;

  // Stream for chat messages
  Stream<DatabaseEvent> get chatStream => _chatDatabase.onValue;

  // Stream for chat list
  Stream<DatabaseEvent> getChatListStream(String uid) {
    return _chatListDatabase.child(uid).onValue;
  }

  void sendMessage({
    required String? doctorId,
    required String? patientId,
  }) {
    if (messageController.text.trim().isNotEmpty) {
      String message = messageController.text.trim();
      String chatId = _chatDatabase.push().key!;
      String timeStamp = DateTime.now().toIso8601String();

      // determine sender and receiver IDs based on the user's role
      bool isDoctor = currentUserId == doctorId;
      String senderUid;
      String receiverUid;

      if (isDoctor) {
        senderUid = currentUserId!;
        receiverUid = patientId!;
      } else {
        senderUid = currentUserId!;
        receiverUid = doctorId!;
      }

      // save message in Chat database
      _chatDatabase.child(chatId).set({
        'message': message,
        'receiver': receiverUid,
        'sender': senderUid,
        'timestamp': timeStamp,
      });

      // update chatList
      _chatListDatabase.child(senderUid).child(receiverUid).set({
        'id': receiverUid,
      });

      _chatListDatabase.child(receiverUid).child(senderUid).set({
        'id': senderUid,
      });

      // clear the message input
      messageController.clear();
    }
  }

  // Fetch list of patients for a doctor's chat list
  Future<List<dynamic>> fetchDoctorChatList() async {
    if (currentUserId == null) return [];
    
    try {
      final DatabaseEvent event = await _chatListDatabase.child(currentUserId!).once();
      DataSnapshot snapshot = event.snapshot;
      List<dynamic> tempChatList = [];

      if (snapshot.value != null) {
        Map<dynamic, dynamic> values = snapshot.value as Map<dynamic, dynamic>;
        final DatabaseReference patientsDb = FirebaseDatabase.instance.ref().child('User');

        for (var userId in values.keys) {
          final DatabaseEvent patientEvent = await patientsDb.child(userId).once();
          DataSnapshot patientSnapshot = patientEvent.snapshot;
          if (patientSnapshot.value != null) {
            Map<dynamic, dynamic> patientMap = patientSnapshot.value as Map<dynamic, dynamic>;
            // Return raw maps so the UI can convert to its own model, 
            // avoiding cyclic or deep module imports in the core controller
            tempChatList.add(patientMap); 
          }
        }
      }
      return tempChatList;
    } catch (error) {
      return [];
    }
  }

  @override
  void onClose() {
    messageController.dispose();
    super.onClose();
  }
}
