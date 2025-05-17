import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'DoctorChatlistPage.dart';
import 'DoctorProfile.dart';
import 'DoctorRequestsPage.dart';

class DoctorHomePage extends StatefulWidget {
  const DoctorHomePage({super.key});

  @override
  State<DoctorHomePage> createState() => _DoctorHomePageState();
}

class _DoctorHomePageState extends State<DoctorHomePage> {

  int _selectedIndex = 0;

  final List<Widget> _children = [
    DoctorRequestsPage(),
    DoctorChatlistPage(),
    DoctorProfile(),
  ];

  void _onItmTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
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
