import 'package:fit_fusion/core/controllers/chat_controller.dart';
import 'package:get/get.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatScreen extends StatelessWidget {
  final String? doctorId;
  final String? doctorName;
  final String? patientId;
  final String? patientName;

  ChatScreen({
    this.doctorId,
    this.doctorName,
    this.patientId,
    this.patientName,
  });

  @override
  Widget build(BuildContext context) {
    final chatController = Get.put(ChatController());
    bool isDoctor = chatController.currentUserId == doctorId;
    String? chatPartnerName = isDoctor ? patientName : doctorName;



    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            '$chatPartnerName',
            style: GoogleFonts.poppins(fontSize: 18),
          ),
        ),
        body: Column(
          children: [
            Expanded(
                child: StreamBuilder(
                    stream: chatController.chatStream,
                    builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
                      if (!snapshot.hasData ||
                          snapshot.data?.snapshot.value == null) {
                        return Center(child: Text('No message yet.'));
                      }
                      Map<dynamic, dynamic> messagesMap = snapshot
                          .data!.snapshot.value as Map<dynamic, dynamic>;
                      List<Map<String, dynamic>> messagesList = [];

                      messagesMap.forEach((key, value) {
                        if ((value['sender'] == chatController.currentUserId &&
                            value['receiver'] == doctorId) ||
                            (value['sender'] == doctorId &&
                                value['receiver'] == chatController.currentUserId) ||
                            (value['sender'] == chatController.currentUserId &&
                                value['receiver'] == patientId) ||
                            (value['sender'] == patientId &&
                                value['receiver'] == chatController.currentUserId)) {
                          messagesList.add({
                            'message': value['message'],
                            'sender': value['sender'],
                            'timestamp': value['timestamp'],
                          });
                        }
                      });
                      messagesList.sort(
                              (a, b) => a['timestamp'].compareTo(b['timestamp']));

                      return ListView.builder(
                          itemCount: messagesList.length,
                          itemBuilder: (context, index) {
                            bool isMe =
                                messagesList[index]['sender'] == chatController.currentUserId;
                            return Align(
                              alignment: isMe
                                  ? Alignment.centerRight
                                  : Alignment.centerLeft,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 16),
                                margin: EdgeInsets.symmetric(
                                    vertical: 4, horizontal: 8),
                                decoration: BoxDecoration(
                                  color: isMe
                                      ? Color(0xffC8C4FF)
                                      : Color(0xffE3E3E3),
                                  borderRadius: isMe
                                      ? BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                      bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.zero)
                                      : BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10),
                                      bottomLeft: Radius.zero,
                                      bottomRight: Radius.circular(10)),
                                ),
                                child: Text(messagesList[index]['message']),
                              ),
                            );
                          });
                    })),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 45,
                      child: TextField(
                        keyboardType: TextInputType.multiline,
                        style: GoogleFonts.poppins(
                            fontSize: 14, fontWeight: FontWeight.normal
                        ),
                        controller: chatController.messageController,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Color(0xffF0EFFF),
                            hintText: 'Enter your message..',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide:
                                BorderSide(color: Color(0xffC8C4FF)))),
                      ),
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        chatController.sendMessage(
                          doctorId: doctorId,
                          patientId: patientId,
                        );
                      },

                      icon: Icon(
                        Icons.send,
                        size: 30,
                        color: Color(0xff0064FA),
                      ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

