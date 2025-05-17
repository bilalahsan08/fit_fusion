import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fit_fusion/navigationbar/Navbar.dart';
import 'package:fit_fusion/nutiton/Doctor.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../doctor/pages/DoctorHomePage.dart';
import 'DoctorSignUp.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final DatabaseReference _database = FirebaseDatabase.instance.ref();

  final _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  bool _isLoading = false;
  bool _isNavigation = false;
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: _isLoading
            ? CircularProgressIndicator()
            : Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 48,),
                    Image.asset('assets/images/fitfusion2.png'),
                    SizedBox(height: 10,),
                    Text('Welcome!', style: GoogleFonts.poppins(fontSize: 32, fontWeight: FontWeight.w600),),
                    Text('Login first', style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.w400),),
                    SizedBox(height: 60,),
                    SizedBox(
                      height: 44,
                      child: TextFormField(
                        style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w500),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Color(0xffF0EFFF),
                          contentPadding: EdgeInsets.only(left: 10, right: 10),
                          labelText: 'Email',
                          labelStyle: GoogleFonts.poppins(fontSize: 13, color: Colors.grey.shade400),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0), // Rounded corners
                            borderSide: BorderSide(
                              color: Color(0xff0064FA), // Blue border color
                              width: 1.0, // Border width
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(
                              color: Color(0xff0064FA), // Blue border color when focused
                              width: 1.0, // Border width
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(
                              color: Color(0xff0064FA), // Blue border color when not focused
                              width: 1.0, // Border width
                            ),
                          ),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (val) => email = val,
                        validator: (val) => val!.isEmpty ? 'Enter an email' : null,
                      ),
                    ),
                    SizedBox(height: 10,),
                    SizedBox(
                      height: 44,
                      child: TextFormField(
                        style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w500),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Color(0xffF0EFFF),
                          contentPadding: EdgeInsets.symmetric(horizontal: 10),
                          labelText: 'Password',
                          labelStyle: GoogleFonts.poppins(fontSize: 13, color: Colors.grey.shade400),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(
                              color: Color(0xff0064FA),
                              width: 1.0,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(
                              color: Color(0xff0064FA),
                              width: 1.0,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(
                              color: Color(0xff0064FA),
                              width: 1.0,
                            ),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscureText ? Icons.visibility_off : Icons.visibility,
                              color: Colors.grey.shade400,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscureText = !_obscureText;
                              });
                            },
                          ),
                        ),
                        obscureText: _obscureText,
                        keyboardType: TextInputType.text,
                        onChanged: (val) => password = val,
                        validator: (val) => val!.length < 6
                            ? 'Password must be at least 6 characters'
                            : null,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ForgotPassword()),
                          );
                        },
                        child: Text('Forgot Password?'),
                      ),
                    ),
                    SizedBox(height: 10),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                        onPressed: _login,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xff0064FA), // Blue background color
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0), // Rounded corners
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12), // Optional: Padding inside the button
                        ),
                        child: Text(
                          'Login',
                          style: GoogleFonts.poppins(fontSize: 17, color: Colors.white, fontWeight: FontWeight.w600, letterSpacing: 0.4), // Text color
                        ),
                      ),
                    ),

                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: TextButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => RegisterPage()));
                        },
                        child: Text('Don’t have an account? Register', style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w400),),
                      ),

                    ),
                    Align(
                      alignment: Alignment.center,
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Navbar()),
                          );
                        },
                        child: Text('Login as Guest'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      try {
        UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        User? user = userCredential.user;

        if (user != null) {
          DatabaseReference userRef = _database.child('Dietition').child(user.uid);
          DataSnapshot snapshot = await userRef.get();

          if (snapshot.exists) {
            _navigateToDoctorHome();
          } else {
            userRef = _database.child('User').child(user.uid);
            snapshot = await userRef.get();
            if (snapshot.exists) {
              _navigateToPatientHome();
            } else {
              _showErrorDialog('User not found');
            }
          }
        }
      } catch (e) {
        _showErrorDialog(e.toString());
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _navigateToDoctorHome() {
    if(!_isNavigation){
      _isNavigation = true;
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => DoctorHomePage()));
    }
  }

  void _navigateToPatientHome() {
    if(!_isNavigation){
      _isNavigation = true;
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => Navbar()));
    }
  }


}
class ForgotPassword extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Reset Password')),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Enter your email to reset your password',
                textAlign: TextAlign.center),
            SizedBox(height: 16),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.email),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                try {
                  await _auth.sendPasswordResetEmail(
                      email: _emailController.text.trim());
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Password reset email sent!')),
                  );
                  Navigator.pop(context);
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error: ${e.toString()}')),
                  );
                }
              },
              child: Text('Reset Password'),
            ),
          ],
        ),
      ),
    );
  }
}