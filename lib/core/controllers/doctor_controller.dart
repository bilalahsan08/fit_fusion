import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class DoctorController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final DatabaseReference _requestDatabase = FirebaseDatabase.instance.ref().child('Requests');
  final DatabaseReference _dietitionDatabase = FirebaseDatabase.instance.ref().child('Dietition');
  
  var isLoading = false.obs;

  String? get currentUserId => _auth.currentUser?.uid;

  // Fetch requests for the currently logged-in doctor
  Future<List<dynamic>> fetchRequests() async {
    if (currentUserId == null) return [];
    
    try {
      final DatabaseEvent event = await _requestDatabase
          .orderByChild('receiver')
          .equalTo(currentUserId)
          .once();

      List<dynamic> requests = [];
      if (event.snapshot.value != null) {
        Map<dynamic, dynamic> requestMap = event.snapshot.value as Map<dynamic, dynamic>;
        requestMap.forEach((key, value) {
          requests.add(value);
        });
      }
      return requests;
    } catch (e) {
      return [];
    }
  }

  // Update the status of a request
  Future<void> updateRequestStatus(String requestId, String status) async {
    try {
      await _requestDatabase.child(requestId).update({
        'status': status,
      });
    } catch (e) {
      Get.snackbar('Error', 'Failed to update request status');
    }
  }

  // Fetch all doctors (dietitions)
  Future<List<dynamic>> fetchAllDoctors() async {
    try {
      final DatabaseEvent event = await _dietitionDatabase.once();
      List<dynamic> doctors = [];
      if (event.snapshot.value != null) {
        Map<dynamic, dynamic> map = event.snapshot.value as Map<dynamic, dynamic>;
        map.forEach((key, value) {
          doctors.add(value);
        });
      }
      return doctors;
    } catch (e) {
      return [];
    }
  }

  // Book an appointment
  Future<void> bookAppointment({
    required String date,
    required String time,
    required String description,
    required String receiverId,
  }) async {
    if (currentUserId == null) return;
    
    String requestId = _requestDatabase.push().key!;
    String status = 'pending';

    await _requestDatabase.child(requestId).set({
      'date': date,
      'time': time,
      'description': description,
      'id': requestId,
      'receiver': receiverId,
      'sender': currentUserId,
      'status': status,
    });
  }
}
