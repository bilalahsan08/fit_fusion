import 'package:fit_fusion/core/controllers/doctor_controller.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../models/booking.dart';


class DoctorRequestsPage extends StatefulWidget {
  const DoctorRequestsPage({super.key});

  @override
  State<DoctorRequestsPage> createState() => _DoctorRequestsPageState();
}

class _DoctorRequestsPageState extends State<DoctorRequestsPage> {
  
  final DatabaseReference _requestDatabase =
  FirebaseDatabase.instance.ref().child('Requests');
  List<Booking> _bookings = [];
  bool _isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchBookings();
  }

    Future<void> _fetchBookings() async {
    final doctorController = Get.put(DoctorController());
    List<dynamic> rawRequests = await doctorController.fetchRequests();
    
    if (mounted) {
      setState(() {
        _bookings.clear();
        for (var req in rawRequests) {
          _bookings.add(Booking.fromMap(Map<String, dynamic>.from(req)));
        }
        _isLoading = false;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Doctor Requests'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _bookings.isEmpty
          ? Center(child: Text('No booking available'))
          : ListView.builder(
          itemCount: _bookings.length,
          itemBuilder: (context, index) {
            final booking = _bookings[index];
            return ListTile(
              title: Text(booking.description),
              subtitle:
              Text('Date: ${booking.date} Time: ${booking.time}'),
              trailing: Text(booking.status),
              onTap: () =>
                  _showStatusDialog(booking.id, booking.status),
            );
          }),
    );
  }

  void _showStatusDialog(String requestId, String currentStatus) {
    List<String> statuses = ['Accepted', 'Rejected', 'Completed'];
    String selectedStatus = currentStatus;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text('Update Request Status'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Please select the status for this request.'),
                  SizedBox(height: 16.0),
                  Column(
                    children: List.generate(statuses.length, (index) {
                      return RadioListTile<String>(
                        title: Text(statuses[index]),
                        value: statuses[index],
                        groupValue: selectedStatus,
                        onChanged: (value) {
                          setState(() {
                            selectedStatus = value!;
                          });
                        },
                      );
                    }),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: Text('Cancel'),
                ),
                TextButton(
                  onPressed: () async {
                    await _updateRequestStatus(requestId, selectedStatus);
                    Get.back();
                  },
                  child: Text('Update Status'),
                ),
              ],
            );
          },
        );
      },
    );
  }

    Future<void> _updateRequestStatus(String requestId, String status) async {
    final doctorController = Get.find<DoctorController>();
    await doctorController.updateRequestStatus(requestId, status);
    await _fetchBookings();
  }

}

