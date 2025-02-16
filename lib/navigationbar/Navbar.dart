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
      body: Center(
        child: IndexedStack(
          children: widgetlist,
          index: myindex,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: (index){
          setState(() {
            myindex = index;
          });
        },
        currentIndex: myindex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
          items: const[
           BottomNavigationBarItem(
               icon: Icon(Icons.widgets),
             label: 'Workouts'
           ),
            BottomNavigationBarItem(
                icon: Icon(Icons.local_activity),
                label: 'Nutrition'
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.spa),
                label: 'Utility'
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.account_circle),
                label: 'Profile'
            ),
          ],
      ),
    );
  }
}