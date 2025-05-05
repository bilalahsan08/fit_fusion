import 'package:firebase_core/firebase_core.dart';
import 'package:fit_fusion/api/firebase_api.dart';
import 'package:fit_fusion/login/Login.dart';
import 'package:flutter/material.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(options: FirebaseOptions(
        apiKey: "AIzaSyALsL5HAa5qOU0M5vse4lM9tI5ZsA4m3g4",
        appId: "1:471653294026:android:43b60e2a6e2b6675197933",
        messagingSenderId: "471653294026",
        projectId: "fit-fusionfinal"));
    print("🔥 Firebase initialized successfully!");
    await FirebaseApi().initNotifications();
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
      home: Login(),
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