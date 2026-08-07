import 'package:fit_fusion/core/controllers/chat_controller.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:fit_fusion/features/chat/doctor_chat_screen.dart';
import '../models/patient.dart';

class DoctorChatlistPage extends StatefulWidget {
  const DoctorChatlistPage({super.key});

  @override
  State<DoctorChatlistPage> createState() => _DoctorChatlistPageState();
}

class _DoctorChatlistPageState extends State<DoctorChatlistPage> {
  
  
  
  List<Patient> _chatList = [];
  bool _isLoading =  true;
  late String doctorId;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final chatController = Get.put(ChatController());
    doctorId = chatController.currentUserId ?? '';
    _fetchChatList();
  }


    Future<void> _fetchChatList() async {
    final chatController = Get.put(ChatController());
    List<dynamic> rawPatients = await chatController.fetchDoctorChatList();
    
    if (mounted) {
      setState(() {
        _chatList = rawPatients.map((e) => Patient.fromMap(Map<String, dynamic>.from(e))).toList();
        _isLoading = false;
      });
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Chat with'),),
      body: _isLoading ? Center(child: CircularProgressIndicator())
          : _chatList.isEmpty
          ? Center(child: Text('No chats available'))
          : ListView.builder(
          itemCount: _chatList.length,
          itemBuilder: (context, index){
            final patient = _chatList[index];
            return Card(
              elevation: 2.0,
              margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: ListTile(
                title: Text('Chat with ${patient.firstName} ${patient.lastName}'),
                onTap: (){
                  Get.to(() => ChatScreen(
                            doctorId:  doctorId,
                            patientId: patient.uid,
                            patientName: '${patient.firstName} ${patient.lastName}',
                          ));
                },
              ),
            );
          }),
    );
  }
}

