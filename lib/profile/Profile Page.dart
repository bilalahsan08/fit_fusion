import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_fusion/login/DoctorSplash.dart';
import 'package:fit_fusion/login/Login.dart';
import 'package:fit_fusion/profile/Profile%20Screen.dart';
import 'package:fit_fusion/nutiton/Doctor.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // Logout function with confirmation dialog
  void logoutUser(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('isLoggedIn'); // or set to false if you prefer

    await FirebaseAuth.instance.signOut(); // optional if you're using FirebaseAuth

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Login()),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.grey[100],
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Profile',
          style: Theme.of(context).textTheme.headlineLarge?.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 26,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        children: [
          sectionTitle('Settings'),
          const SizedBox(height: 16),
          buildSettingRow(
            title: 'Edit Profile',
            icon: 'assets/images/edit.png',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfileScreen()),
              );
            },
          ),
          const SizedBox(height: 10),
          buildSettingRow(
            title: 'Exercise Packs',
            icon: 'assets/images/packs.png',
            onPressed: () {},
          ),
          const SizedBox(height: 10),
          buildSettingRow(
            title: 'Food',
            icon: 'assets/images/food.png',
            onPressed: () {},
          ),
          const SizedBox(height: 10),
          buildSettingRow(
            title: 'Notification',
            icon: 'assets/images/alarm.png',
            onPressed: () {},
          ),
          const SizedBox(height: 10),
          buildSettingRow(
            title: 'Level',
            icon: 'assets/images/level.png',
            onPressed: () {},
          ),
          const SizedBox(height: 10),
          buildSettingRow(
            title: 'Fitness Record',
            icon: 'assets/images/fitness.png',
            onPressed: () {},
          ),
          const SizedBox(height: 30),

          sectionTitle('Instructions'),
          const SizedBox(height: 16),
          buildSettingRow(
            title: 'Exercise List',
            icon: 'assets/images/list.png',
            onPressed: () {},
          ),
          const SizedBox(height: 30),

          sectionTitle('We Love Feedback!'),
          const SizedBox(height: 16),
          buildSettingRow(
            title: 'Rate the App',
            icon: 'assets/images/rate.png',
            onPressed: () {},
          ),
          const SizedBox(height: 10),
          buildSettingRow(
            title: 'Send Feedback',
            icon: 'assets/images/feedback.png',
            onPressed: () {},
          ),
          const SizedBox(height: 30),

          sectionTitle('Follow Us'),
          const SizedBox(height: 16),
          buildSettingRow(
            title: 'Instagram',
            icon: 'assets/images/instagram.png',
            onPressed: () {},
          ),
          const SizedBox(height: 10),
          buildSettingRow(
            title: 'Facebook',
            icon: 'assets/images/facebook.png',
            onPressed: () {},
          ),
          const SizedBox(height: 10),
          buildSettingRow(
            title: 'X',
            icon: 'assets/images/X.png',
            onPressed: () {},
          ),
          const SizedBox(height: 30),

          // Dual buttons section
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              children: [
                // Dietitian Mode Button
                Expanded(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green[600],
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 3,
                    ),
                    onPressed: () {
                      Navigator.push(

                        context,
                        MaterialPageRoute(builder: (context) => SecondarySplashScreen()),
                      );
                    },
                    icon: const Icon(Icons.medical_services, color: Colors.white),
                    label: const Text(
                      'Dietitian Mode',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),

                // Log Out Button
                Expanded(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red[600],
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 3,
                    ),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Confirm Logout'),
                            content: const Text('Are you sure you want to log out?'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop(); // Close dialog
                                },
                                child: const Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop(); // Close dialog first
                                  logoutUser(context); // Then perform logout
                                },
                                child: const Text('Logout'),
                                style: TextButton.styleFrom(
                                  foregroundColor: Colors.red,
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },

                    icon: const Icon(Icons.logout, color: Colors.white),
                    label: const Text(
                      'Log Out',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  // Helper widget for section titles
  Widget sectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
    );
  }

  // Helper widget for settings rows
  Widget buildSettingRow({
    required String title,
    required String icon,
    required VoidCallback onPressed,
    bool isLogout = false,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: onPressed,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
            BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: const Offset(0, 2),
            ),
            ],
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  icon,
                  width: 26,
                  height: 26,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: isLogout ? Colors.redAccent : Colors.black,
                  ),
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 18,
                color: Colors.grey,
              ),
            ],
          ),
        ),
      ),
    );
  }
}