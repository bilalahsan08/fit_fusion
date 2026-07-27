import 'dart:io';
import 'package:get/get.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:fit_fusion/core/routes/app_routes.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final DatabaseReference _database = FirebaseDatabase.instance.ref();

  // Observable state for loading spinners
  var isLoading = false.obs;

  // Sign In method handles both Dietitions and Users
  Future<void> login(String email, String password) async {
    isLoading.value = true;
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = userCredential.user;

      if (user != null) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isLoggedIn', true);

        // Check if user is a Dietition
        DatabaseReference userRef = _database.child('Dietition').child(user.uid);
        DataSnapshot snapshot = await userRef.get();

        if (snapshot.exists) {
          Get.offNamed(AppRoutes.doctorHome);
        } else {
          // Check if user is a regular User
          userRef = _database.child('User').child(user.uid);
          snapshot = await userRef.get();
          if (snapshot.exists) {
            Get.offNamed(AppRoutes.navbar);
          } else {
            // Default fallback if not found in RTDB (e.g. from old signup)
            Get.offNamed(AppRoutes.navbar); 
          }
        }
      }
    } on FirebaseAuthException catch (e) {
      Get.snackbar(
        'Login Error',
        e.message ?? 'An error occurred during login',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Register a standard User (Patient)
  Future<void> registerPatient(String email, String password, String name) async {
    isLoading.value = true;
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = userCredential.user;

      if (user != null) {
        // Save user info to RTDB
        await _database.child('User').child(user.uid).set({
          'name': name,
          'email': email,
          'createdAt': DateTime.now().toIso8601String(),
        });

        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isLoggedIn', true);

        Get.snackbar(
          'Success',
          'Account created successfully!',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );

        Get.offNamed(AppRoutes.navbar);
      }
    } on FirebaseAuthException catch (e) {
      Get.snackbar(
        'Registration Error',
        e.message ?? 'An error occurred',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar('Error', 'Something went wrong');
    } finally {
      isLoading.value = false;
    }
  }

  // Register a Dietition (Doctor) or complex User
  Future<void> registerComplexUser({
    required String email,
    required String password,
    required String userType,
    required Map<String, dynamic> userData,
    dynamic imageFile, // File? from dart:io
  }) async {
    isLoading.value = true;
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = userCredential.user;

      if (user != null) {
        String userTypePath = userType == 'Dietition' ? 'Dietition' : 'User';
        userData['uid'] = user.uid;

        await _database.child(userTypePath).child(user.uid).set(userData);

        if (imageFile != null) {
          Reference storageReference = FirebaseStorage.instance
              .ref()
              .child('\$userTypePath/\${user.uid}/profile.jpg');
          UploadTask uploadTask =
              storageReference.putFile(imageFile); // Assuming imageFile is File
          TaskSnapshot taskSnapshot = await uploadTask;
  
          String downloadUrl = await taskSnapshot.ref.getDownloadURL();
          await _database.child(userTypePath).child(user.uid).update({
            'profileImageUrl': downloadUrl,
          });
        }

        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isLoggedIn', true);

        Get.snackbar(
          'Success',
          'Registered successfully!',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );

        Get.offNamed(userType == 'Dietition' ? AppRoutes.doctorHome : AppRoutes.navbar);
      }
    } on FirebaseAuthException catch (e) {
      Get.snackbar(
        'Registration Error',
        e.message ?? 'An error occurred',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  // Reset Password
  Future<void> resetPassword(String email) async {
    if (email.isEmpty) {
      Get.snackbar('Error', 'Please enter an email address');
      return;
    }
    isLoading.value = true;
    try {
      await _auth.sendPasswordResetEmail(email: email.trim());
      Get.snackbar(
        'Success',
        'Password reset email sent. Please check your inbox.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      Get.back(); // go back after sending
    } on FirebaseAuthException catch (e) {
      Get.snackbar(
        'Error',
        e.message ?? 'An error occurred',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);
    Get.offAllNamed(AppRoutes.login);
  }
}
