import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_fusion/auth.dart';
import 'package:fit_fusion/login/Signup.dart';
import 'package:fit_fusion/profile/Profile%20Screen.dart';
import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  final String? email; // Optional email parameter

  Login({this.email}); // Constructor to accept email

  final _email = TextEditingController();
  final _password = TextEditingController();
  final _auth = Auth();

  @override
  Widget build(BuildContext context) {
    // Pre-fill the email field if an email is provided
    if (email != null) {
      _email.text = email!;
    }

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _email,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _password,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                try {
                  await _auth.signInWithEmailAndPassword(
                    email: _email.text,
                    password: _password.text,
                  );
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProfileScreen()),
                  );
                } on FirebaseAuthException catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(e.message ?? 'An error occurred')),
                  );
                }
              },
              child: Text('Log In'),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Signup()),
                );
              },
              child: Text('Don’t have an account? Sign Up'),
            ),
          ],
        ),
      ),
    );
  }
}