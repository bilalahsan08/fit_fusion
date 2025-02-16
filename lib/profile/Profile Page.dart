import 'package:fit_fusion/login/Login.dart';
import 'package:fit_fusion/profile/Profile%20Screen.dart';
import 'package:fit_fusion/profile/SettingRow.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget{
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile',style: Theme.of(context).textTheme.headlineLarge),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
        children: [
          Text('Settings',style:
          TextStyle(fontSize: 17,fontWeight:FontWeight.w500 ),),
          SizedBox(height: 10,),
          SettingRow(
              title: 'Edit Profile',
              icon: 'assets/images/edit.png',
              onPressed: (){
                Navigator.push(context,
                    MaterialPageRoute(builder:(context) => Login()));
              }),
          SettingRow(
              title: 'Exercise Packs',
              icon: 'assets/images/packs.png',
              onPressed: (){}),
          SettingRow(
              title: 'Food',
              icon: 'assets/images/food.png',
              onPressed: (){}),
          SettingRow(
              title: 'Notification',
              icon: 'assets/images/alarm.png',
              onPressed: (){}),
          SettingRow(
              title: 'Level',
              icon: 'assets/images/level.png',
              onPressed: (){}),
          SettingRow(
              title: 'Fitness Record',
              icon: 'assets/images/fitness.png',
              onPressed: (){}),
          SizedBox(height: 25,),
          Text('Instructions',
          style: TextStyle(fontSize: 17,fontWeight: FontWeight.w500)
          ),
          SizedBox(height: 10,),
          SettingRow(
              title: 'Exercise List',
              icon: 'assets/images/list.png',
              onPressed: (){}
          ),
          SizedBox(height: 25,),
          Text('We Love Feedback!',
              style: TextStyle(fontSize: 17,fontWeight: FontWeight.w500)
          ),
          SizedBox(height: 10,),
          SettingRow(
              title: 'Rate the App',
              icon: 'assets/images/rate.png',
              onPressed: (){}
          ),
          SettingRow(
              title: 'Send Feedback',
              icon: 'assets/images/feedback.png',
              onPressed: (){}
          ),
          SizedBox(height: 25,),
          Text('Follow Us',
              style: TextStyle(fontSize: 17,fontWeight: FontWeight.w500)
          ),
          SizedBox(height: 10,),
          SettingRow(
              title: 'Instagram',
              icon: 'assets/images/instagram.png',
              onPressed: (){}
          ), SettingRow(
              title: 'Facebook',
              icon: 'assets/images/facebook.png',
              onPressed: (){}
          ), SettingRow(
              title: 'X',
              icon: 'assets/images/X.png',
              onPressed: (){}
          ),
          SizedBox(height: 20),
        SettingRow(
          title: 'Log Out',
          icon: 'assets/images/logout.png',
          onPressed: () {
            // Navigate back to login when logging out
            Navigator.pushNamedAndRemoveUntil(
              context,
              '/login',
                  (route) => false, // Clear all previous routes
            );
          },
        )
        ],

      )
    );
  }
}