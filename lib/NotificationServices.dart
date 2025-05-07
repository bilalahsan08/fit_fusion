import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class NotificationServices extends StatefulWidget {
  @override
  _NotificationServicesState createState() => _NotificationServicesState();
}

class _NotificationServicesState extends State<NotificationServices> {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  AuthorizationStatus? _permissionStatus;

  @override
  void initState() {
    super.initState();
    requestNotificationPermission();
  }

  void requestNotificationPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      sound: true,
    );
    setState(() {
      _permissionStatus = settings.authorizationStatus;
    });
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print("✅ User granted permissions");
    } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
      print("ℹ️ User granted provisional permission");
    } else {
      print("❌ User declined or has not accepted permission");
    }
  }
  String getPermissionStatusText() {
    switch (_permissionStatus) {
      case AuthorizationStatus.authorized:
        return "✅ Notifications are enabled";
      case AuthorizationStatus.provisional:
        return "ℹ️ Notifications are provisionally enabled";
      case AuthorizationStatus.denied:
        return "❌ Notifications are disabled";
      default:
        return "🔄 Checking permission status...";
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Notifications")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("This is the Notifications Page",
                style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
            Text(
              getPermissionStatusText(),
              style: TextStyle(fontSize: 16, color: Colors.blueAccent),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
