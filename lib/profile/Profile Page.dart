import 'package:fit_fusion/login/DoctorLogin.dart';
import 'package:fit_fusion/login/Login.dart';
import 'package:fit_fusion/profile/Profile%20Screen.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget{
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
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
              Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileScreen()));
            },
          ),
          const SizedBox(height: 10),
          buildSettingRow(title: 'Exercise Packs', icon: 'assets/images/packs.png', onPressed: () {}),
          const SizedBox(height: 10),
          buildSettingRow(title: 'Food', icon: 'assets/images/food.png', onPressed: () {}),
          const SizedBox(height: 10),
          buildSettingRow(title: 'Notification', icon: 'assets/images/alarm.png', onPressed: () {}),
          const SizedBox(height: 10),
          buildSettingRow(title: 'Level', icon: 'assets/images/level.png', onPressed: () {}),
          const SizedBox(height: 10),
          buildSettingRow(title: 'Fitness Record', icon: 'assets/images/fitness.png', onPressed: () {}),
          const SizedBox(height: 30),

          sectionTitle('Instructions'),
          const SizedBox(height: 16),
          buildSettingRow(title: 'Exercise List', icon: 'assets/images/list.png', onPressed: () {}),
          const SizedBox(height: 30),

          sectionTitle('We Love Feedback!'),
          const SizedBox(height: 16),
          buildSettingRow(title: 'Rate the App', icon: 'assets/images/rate.png', onPressed: () {}),
          const SizedBox(height: 10),
          buildSettingRow(title: 'Send Feedback', icon: 'assets/images/feedback.png', onPressed: () {}),
          const SizedBox(height: 30),

          sectionTitle('Follow Us'),
          const SizedBox(height: 16),
          buildSettingRow(title: 'Instagram', icon: 'assets/images/instagram.png', onPressed: () {}),
          const SizedBox(height: 10),
          buildSettingRow(title: 'Facebook', icon: 'assets/images/facebook.png', onPressed: () {}),
          const SizedBox(height: 10),
          buildSettingRow(title: 'X', icon: 'assets/images/X.png', onPressed: () {}),
          const SizedBox(height: 30),

          buildSettingRow(
            title: 'Log Out',
            icon: 'assets/images/logout.png',
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => DoctorLogin()));
            },
            isLogout: true,
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

// Helper widgets
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

    Widget buildSettingRow({
      required String title,
      required String icon,
      required VoidCallback onPressed,
      bool isLogout = false,
    }) {
      return SettingRow(
        title: title,
        icon: icon,
        onPressed: onPressed,
        isLogout: isLogout,
      );
    }

    class SettingRow extends StatelessWidget {
    final String title;
    final String icon;
    final bool isLogout;
    final VoidCallback onPressed;

    const SettingRow({
    Key? key,
    required this.title,
    required this.icon,
    required this.onPressed,
    this.isLogout = false,
    }) : super(key: key);

    @override
    Widget build(BuildContext context) {
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
