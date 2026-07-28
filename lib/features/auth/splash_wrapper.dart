import 'package:fit_fusion/core/routes/app_routes.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'package:fit_fusion/features/doctor/pages/doctor_home_page.dart';
import 'package:fit_fusion/core/widgets/custom_navbar.dart';

import 'package:fit_fusion/features/auth/login.dart';

class SplashWrapper extends StatefulWidget {
  const SplashWrapper({super.key});

  @override
  State<SplashWrapper> createState() => _SplashWrapperState();
}

class _SplashWrapperState extends State<SplashWrapper> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final DatabaseReference _database = FirebaseDatabase.instance.ref();

  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    User? user = _auth.currentUser;

    if (user != null) {
      // Check if user is a doctor or patient
      final doctorSnapshot = await _database.child('Dietition').child(user.uid).get();

      if (doctorSnapshot.exists) {
        Get.offNamed(AppRoutes.doctorHome);
        return;
      }

      final patientSnapshot = await _database.child('User').child(user.uid).get();

      if (patientSnapshot.exists) {
        Get.offNamed(AppRoutes.navbar);
        return;
      }

      // if user exists but no role found, logout and go to login
      await _auth.signOut();
      Get.offNamed(AppRoutes.login);
    } else {
      // No user logged in — go to login
      Get.offNamed(AppRoutes.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Simple splash while checking
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

