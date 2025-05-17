import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../api/ChatListPage.dart';
import '../doctor/pages/DoctorListPage.dart';
import 'Profile Page.dart';
import 'ProfilePagee.dart';

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

