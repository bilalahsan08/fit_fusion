import 'package:fit_fusion/login/Login.dart';
import 'package:fit_fusion/login/Signup.dart';
import 'package:fit_fusion/navigationbar/Navbar.dart';
import 'package:fit_fusion/nutiton/Nutrition%20Home.dart';
import 'package:fit_fusion/profile/Profile%20Page.dart';
import 'package:fit_fusion/profile/Profile%20Screen.dart';
import 'package:fit_fusion/utility/Bmical.dart';
import 'package:fit_fusion/utility/Utility%20Home.dart';
import 'package:fit_fusion/workout/Workout%20Home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fit fusion',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: Navbar(),
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
