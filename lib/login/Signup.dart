import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../navigationbar/Navbar.dart';
import 'package:fit_fusion/login/Login.dart';

class Signup extends StatelessWidget {
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _confirmPassword = TextEditingController();
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.grey[100], // Set the background color to gray
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Create Account text
                Text(
                  "Create an Account",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                    letterSpacing: 1.2,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 30),

                // Username input field with rounded corners and shadow
                _buildTextField(_name, 'Username', Icons.person),
                SizedBox(height: 16),

                // Email input field with rounded corners and shadow
                _buildTextField(_email, 'Email', Icons.email),
                SizedBox(height: 16),

                // Password input field with rounded corners and shadow
                _buildTextField(_password, 'Password', Icons.lock, obscureText: true),
                SizedBox(height: 16),

                // Confirm Password input field with rounded corners and shadow
                _buildTextField(_confirmPassword, 'Confirm Password', Icons.lock_outline, obscureText: true),
                SizedBox(height: 20),

                // Sign Up button with modern styling
                SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_password.text != _confirmPassword.text) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Passwords do not match')),
                        );
                        return;
                      }

                      try {
                        final _userCredential = await _auth.createUserWithEmailAndPassword(
                          email: _email.text.trim(),
                          password: _password.text.trim(),
                        );
                        if (_userCredential.user != null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('User Successfully Registered')),
                          );
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => Navbar()),
                          );
                        }
                      } on FirebaseAuthException catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(e.message ?? 'An error occurred')),
                        );
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Something went wrong')),
                        );
                      }
                    },
                    child: Text(
                      'Sign Up',
                      style: TextStyle(fontSize: 16),
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 14), backgroundColor: Colors.blueAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      shadowColor: Colors.black26,
                      elevation: 4,
                    ),
                  ),
                ),
                SizedBox(height: 20),

                // Row for navigating to login page
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have an account?"),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Login(email: _email.text.trim()),
                          ),
                        );
                      },
                      child: Text('Log In'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Function to build text fields with consistent styling
    Widget _buildTextField(TextEditingController controller, String label, IconData icon, {bool obscureText = false}) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: TextField(
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(
            labelText: label,
            prefixIcon: Icon(icon),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 16),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.blueAccent, width: 2),
            ),
          ),
        ),
      );
    }
