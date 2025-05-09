import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fit_fusion/login/DoctorLogin.dart';
import 'package:fit_fusion/login/DoctorSignUp.dart';
import 'package:fit_fusion/navigationbar/Navbar.dart';
import 'package:fit_fusion/nutiton/Doctor.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Login.dart';

class SecondarySplashScreen extends StatefulWidget {
  @override
  State<SecondarySplashScreen> createState() => _SecondarySplashScreenState();
}

class _SecondarySplashScreenState extends State<SecondarySplashScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final DatabaseReference _database = FirebaseDatabase.instance.ref();

  @override
  void initState() {
    super.initState();
    // _checkAuthUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Color(0xff0064FA),
        child: Stack(
          children: [
            // Zoomed DNA image on left side
            Positioned(
              left: -10,
              top: MediaQuery.of(context).size.height * 0.2,
              child: Transform.scale(
                scale: 1,
                child: Image.asset(
                  'assets/images/DoctorSplash.png',
                  width: MediaQuery.of(context).size.width * 0.9,
                ),
              ),
            ),

            // Right-aligned text content
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0, right: 10.0),
                    child: Text(
                      'A+',
                      style: GoogleFonts.poppins(
                        fontSize: 48,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: Text(
                      textAlign: TextAlign.end,
                      'Diet Support\nNutrition solutions for your health journey',
                      style: GoogleFonts.poppins(
                        fontSize: 22,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Bottom text aligned to center
            Positioned(
              bottom: 60, // Adjust this value to change vertical position
              left: 0,
              right: 0,
              child: Center(
                child: Text(
                  'Your Personal Nutrition Guide\nPowered by Science, Tailored for You',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    color: Colors.white.withOpacity(0.9),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToLogin() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => Login()));
  }

  void _navigateToNavbar() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => Navbar()));
  }

  void _navigateToDoctorSignUp() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => DoctorLogin()));
  }
}