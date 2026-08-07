import 'package:fit_fusion/core/routes/app_routes.dart';
import 'package:fit_fusion/core/routes/app_pages.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fit_fusion/core/api/services/firebase_api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:fit_fusion/core/controllers/user_stats_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    if (Firebase.apps.isEmpty) {
      await Firebase.initializeApp(
        options: const FirebaseOptions(
          apiKey: "AIzaSyALsL5HAa5qOU0M5vse4lM9tI5ZsA4m3g4",
          appId: "1:471653294026:android:43b60e2a6e2b6675197933",
          messagingSenderId: "471653294026",
          projectId: "fit-fusionfinal",
        ),
      );
    }
    FirebaseApi().initNotifications();
  } catch (e) {
    debugPrint("Firebase init skipped/handled: $e");
  }
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

  Get.put(UserStatsController(), permanent: true);
  
  runApp(MyApp(isLoggedIn: isLoggedIn));
}





class MyApp extends StatelessWidget {
  final bool isLoggedIn;

  const MyApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Fit Fusion',
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.splash,
      getPages: AppPages.pages,
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

