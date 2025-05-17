import 'package:firebase_core/firebase_core.dart';
import 'package:fit_fusion/api/services/firebase_api.dart';
import 'package:fit_fusion/login/Login.dart';
import 'package:fit_fusion/navigationbar/Navbar.dart';
import 'package:fit_fusion/nutiton/Doctor.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login/DoctorLogin.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyALsL5HAa5qOU0M5vse4lM9tI5ZsA4m3g4",
      appId: "1:471653294026:android:43b60e2a6e2b6675197933",
      messagingSenderId: "471653294026",
      projectId: "fit-fusionfinal",
    ),
  );
  FirebaseApi().initNotifications();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

  runApp(MyApp(isLoggedIn: isLoggedIn));
}


class MyApp extends StatelessWidget {
  final bool isLoggedIn;

  const MyApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fit Fusion',
      debugShowCheckedModeBanner: false,
      home: isLoggedIn ? Navbar() : LoginPage(),
    );
  }
}


class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
          backgroundColor: Theme.of(context).colorScheme.primary,
        ),
        body: Container(

        )

    );
  }
}