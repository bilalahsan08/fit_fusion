import 'package:fit_fusion/core/routes/app_routes.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkLoginStatus();
    });
  }

  Future<void> _checkLoginStatus() async {
    await Future.delayed(const Duration(milliseconds: 500));
    try {
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
      }
    } catch (e) {
      debugPrint("Firebase check skipped/handled: $e");
    }
    // Default directly to User Mode (Navbar) for UI development
    Get.offNamed(AppRoutes.navbar);
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

