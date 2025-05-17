import 'package:fit_fusion/navigationbar/Navbar.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double _opacity = 0.0;

  @override
  void initState() {
    super.initState();

    // Start the fade-in animation
    Timer(Duration(milliseconds: 500), () {
      setState(() {
        _opacity = 1.0;
      });
    });

    // Move to home after delay
    Timer(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => Navbar()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade900,
      body: Center(
        child: AnimatedOpacity(
          duration: Duration(seconds: 2),
          opacity: _opacity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/fitfusion2.png', width: 150),
              SizedBox(height: 20),
              Text(
                "FitFusion",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
