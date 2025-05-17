import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';

class Auth{
  final FirebaseAuth _firebaseAuth=FirebaseAuth.instance;
  User? get currentUser=>_firebaseAuth.currentUser;
  Stream<User?> get authStateChanges=>_firebaseAuth.authStateChanges();

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
})async{
    try{
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    }catch(e){
      log("Something went wrong" as num);
    }
  }
  Future<void> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      log("User registered successfully: $email" as num);
    } on FirebaseAuthException catch (e) {
      log("Registration failed: ${e.message}" as num);
      rethrow; // Rethrow the exception to handle it in the UI
    }
  }
  Future<void> signOut() async{
    try{
      await _firebaseAuth.signOut();
    }catch(e){
      log("Something went wrong" as num);
    }
  }
  }

