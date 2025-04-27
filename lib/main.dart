import 'package:firebase_core/firebase_core.dart';
import 'package:fit_fusion/login/Login.dart';
import 'package:fit_fusion/login/Splashscreen.dart';
import 'package:fit_fusion/navigationbar/Navbar.dart';
import 'package:flutter/material.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(options: FirebaseOptions(
        apiKey: "AIzaSyD9kEgnU4ko4otNMVT9wkqPXSkXGWurKDE",
        appId: "1:661975016783:android:29a79068cac4492014d13a",
        messagingSenderId: "661975016783",
        projectId: "fitproj-54096"));
    print("🔥 Firebase initialized successfully!");
    runApp(const MyApp());
  } catch (e) {
    print("Firebase Initialization Error: $e");
  }

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
      home: Splashscreen(),
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