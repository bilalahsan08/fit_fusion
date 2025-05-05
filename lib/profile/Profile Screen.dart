import 'package:flutter/material.dart';

import 'package:fit_fusion/login/Login.dart';

import '../login/Signup.dart';


void main() => runApp(MaterialApp(


  initialRoute: '/login',
  routes: {
    '/sig nup': (context) => Signup(),
    '/login': (context) => Login(),
    '/profile': (context) => ProfileScreen(),
  },
));


class ProfileScreen extends StatefulWidget{
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: const Text(
          'Edit Profile',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text(
              'SAVE',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
          ),
        ],
      ),
      body: Container(
        color: Colors.grey[200],
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          children: [
            Center(
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: ClipOval(
                  child: Image.asset(
                    'assets/images/profilephoto.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            ProfileRow(title: 'Name', value: 'B', onPressed: () {}),
            const SizedBox(height: 12),
            ProfileRow(title: 'Gender', value: 'Male', onPressed: () {}),
            const SizedBox(height: 12),
            ProfileRow(title: 'Birthday', value: '01 Jan 1990', onPressed: () {}),
            const SizedBox(height: 12),
            ProfileRow(title: 'Units', value: 'cm/kg', onPressed: () {}),
            const SizedBox(height: 12),
            ProfileRow(title: 'Height', value: '175 cm', onPressed: () {}),
            const SizedBox(height: 12),
            ProfileRow(title: 'Weight', value: '75.0 kg', onPressed: () {}),
            const SizedBox(height: 12),
            ProfileRow(title: 'Goal', value: 'Lose weight', onPressed: () {}),
            const SizedBox(height: 12),
            ProfileRow(title: 'Knee Pain', value: 'No problems', onPressed: () {}),
            const SizedBox(height: 12),
            ProfileRow(title: 'Newsletter', value: 'Yes', onPressed: () {}),
            const SizedBox(height: 30),
            Center(
              child: Text(
                'Delete Account',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.redAccent,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
    class ProfileRow extends StatelessWidget {
    final String title;
    final String value;
    final VoidCallback onPressed;

    const ProfileRow({
    Key? key,
    required this.title,
    required this.value,
    required this.onPressed,
    }) : super(key: key);

    @override
    Widget build(BuildContext context) {
    return Material(
    color: Colors.transparent,
    child: InkWell(
    borderRadius: BorderRadius.circular(15),
    onTap: onPressed,
    splashColor: Colors.grey.withOpacity(0.2),
    child: Container(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
    decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(15),
    boxShadow: [
    BoxShadow(
    color: Colors.black12,
    blurRadius: 6,
    offset: Offset(0, 3),
    ),
    ],
    ),
    child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
    Text(
    title,
    style: const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: Colors.black,
    ),
    ),
    Text(
    value,
    style: TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: Colors.grey[600],
    ),
    ),
    ],
    ),
    ),
    ),
    );
    }
    }
