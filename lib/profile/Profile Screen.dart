import 'package:fit_fusion/profile/ProfleRow.dart';
import 'package:flutter/material.dart';

import 'package:fit_fusion/login/Login.dart';

import '../login/Signup.dart';


void main() => runApp(MaterialApp(


  initialRoute: '/login',
  routes: {
    '/signup': (context) => Signup(),
    '/login': (context) => Login(),
    '/profile': (context) => ProfileScreen(),
  },
));


class ProfileScreen extends StatefulWidget{
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon:Icon(Icons.arrow_back_ios,)),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Edit Profile',style: Theme.of(context).textTheme.headlineSmall),
            TextButton(onPressed: (){},
            child: const Text('SAVE',style:
            TextStyle(fontSize: 18,color: Colors.grey),)
                
            )
          ],
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
        children: [
          Center(
            child: Image.asset('assets/images/profilephoto.png',
            width: 100,
            height: 100,
            fit: BoxFit.cover),
          ),
          SizedBox(height: 30),
          ProfileRow(
            title: 'Name',
            value: 'B',
            onPressed: (){}),
          ProfileRow(
              title: 'Gender',
              value: 'Male',
              onPressed: (){}),
          ProfileRow(
              title: 'Birthday',
              value: 'Male',
              onPressed: (){}),
          ProfileRow(
              title: 'Units',
              value: 'cm/kg',
              onPressed: (){}),
          ProfileRow(
              title: 'Height',
              value: '52 cm',
              onPressed: (){}),
          ProfileRow(
              title: 'Weight',
              value: '75.0 kg',
              onPressed: (){}),
          ProfileRow(
              title: 'Goal',
              value: 'Lose weight',
              onPressed: (){}),
          ProfileRow(
              title: 'Knee Pain',
              value: 'No problems',
              onPressed: (){}),
          ProfileRow(
              title: 'Newsletter',
              value: 'Yes',
              onPressed: (){}),
          SizedBox(height: 30,),
          Center(child:  Text('Delete Account',
            style: TextStyle(fontSize: 18,) ,))
        ],
      ),
    );
  }
}