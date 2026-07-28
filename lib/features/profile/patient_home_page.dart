import 'package:flutter/material.dart';


import 'package:fit_fusion/features/chat/pages/chat_list_page.dart';
import '../doctor/pages/doctor_list_page.dart';
import 'patient_bookings_screen.dart';

class PatientHomePage extends StatefulWidget {
  const PatientHomePage({super.key});

  @override
  State<PatientHomePage> createState() => _PatientHomePageState();
}

class _PatientHomePageState extends State<PatientHomePage> {
  int _selectedIndex = 0;

  final List<Widget> _children = [
    DoctorListPage(),
    ChatListPage(),
    ProfilePagee(),
  ];

  void _onItmTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
    Widget build(BuildContext context) {
      return Scaffold(
        body: _children.elementAt(_selectedIndex),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Color(0xff0064FA),
          unselectedItemColor: Color(0xffBEBEBE),
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home_filled),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.chat),
              label: 'Chat',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.white,
          onTap: _onItmTapped,
        ),
      );
    }
  }


