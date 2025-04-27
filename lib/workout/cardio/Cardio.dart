import 'dart:ui';

import 'package:flutter/material.dart';

class Cardio extends StatefulWidget{
  @override
  State<Cardio> createState() => _CardioState();
}

class _CardioState extends State<Cardio> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
          Image.asset(
          'assets/images/cardio.png',
          width: double.infinity,
          height: 220,
          fit: BoxFit.cover,
        ),
        Positioned.fill(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5), // Blur strength
            child: Container(
              color: Colors.black.withOpacity(0.1), // Optional tint
            ),
          ),
        ),
        SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Back Button
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  SizedBox(height: 10),

                  // Title
                  Text(
                    'HIIT & Cardio',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
                  ),
                  SizedBox(height: 10),

                  Text(
                    'High intensity sessions that will give your heart, lungs and circulatory system a good workout.',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 20),

                  buildCard(
                    title: 'HIIT',
                    image: 'assets/images/hiit.png',
                    onPressed: () {},
                  ),Divider(height: 1, color: Colors.grey.withOpacity(0.2)),
                  buildCard(
                    title: 'Light Cardio',
                    image: 'assets/images/lightcardio.png',
                    onPressed: () {},
                  ),Divider(height: 1, color: Colors.grey.withOpacity(0.2)),
                  buildCard(
                    title: 'Tabata',
                    image: 'assets/images/tabata.png',
                    onPressed: () {},
                  ),
                  SizedBox(height: 20),

                  Text(
                    'Special',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
                  ),
                  SizedBox(height: 10),
                  buildCard(
                    title: 'Plyometrics',
                    image: 'assets/images/polymetric.png',
                    onPressed: () {},
                  ),Divider(height: 1, color: Colors.grey.withOpacity(0.2)),
                  buildCard(
                    title: 'Join Friendly',
                    image: 'assets/images/join.png',
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),
          ]
        ),
      )
    );
  }
}
Widget buildCard({
  required String title,
  required String image,
  required VoidCallback onPressed,
}) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white.withOpacity(0.5),
      borderRadius: BorderRadius.circular(5),
    ),
    child: InkWell(
      onTap: onPressed,
      splashColor: Colors.grey.withOpacity(0.2),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        height: 100,
        width: double.infinity,
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                image,
                height: 80,
                width: 80,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 15,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
