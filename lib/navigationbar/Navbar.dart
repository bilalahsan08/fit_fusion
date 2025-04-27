import 'package:fit_fusion/nutiton/Nutrition%20Home.dart';
import 'package:fit_fusion/profile/Profile%20Page.dart';
import 'package:fit_fusion/utility/Utility%20Home.dart';
import 'package:fit_fusion/workout/Workout%20Home.dart';
import 'package:flutter/material.dart';

class Navbar extends StatefulWidget{
  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  int myindex = 0;
  List<Widget> widgetlist = [
   WorkoutHome(),
    NutritionHome(),
     UtilityHome(),
      ProfilePage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Center(
        child: IndexedStack(
          children: widgetlist,  // Your list of screens
          index: myindex,         // The current index to determine which screen to display
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.grey[100], // Bottom bar background same as page
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
            ),
          ],
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.grey[100], // Light grey background
          type: BottomNavigationBarType.fixed,
          onTap: (index) {
            setState(() {
              myindex = index; // Change to the selected index
            });
          },
          currentIndex: myindex, // Track the selected tab
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey,
          elevation: 0, // Remove extra shadow (we added our own)
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.widgets),
              label: 'Workouts',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.local_activity),
              label: 'Nutrition',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.spa),
              label: 'Utility',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}