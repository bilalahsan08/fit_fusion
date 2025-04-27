import 'dart:ui';

import 'package:flutter/material.dart';

class Yoga extends StatefulWidget{
  @override
  State<Yoga> createState() => _YogaState();
}

class _YogaState extends State<Yoga> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
          Image.asset(
          'assets/images/legrolling.png',
          width: double.infinity,
          height: 230,
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
                    'Yoga & Stretching',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28,color: Colors.white.withOpacity(0.7)),
                  ),
                  SizedBox(height: 10),

                  // Description
                  Text(
                    'Healthy body and mind. Lengthen your body and release any tension with easy to follow stretches.',
                    style: TextStyle(fontSize: 16,color: Colors.white.withOpacity(0.7)),
                  ),
                  SizedBox(height: 40),

                  buildCard(
                    title: 'Full Body Flexibility',
                    image: 'assets/images/flexibility.png',
                    onPressed: () {},
                  ),
                  SizedBox(height: 20),

                  buildCard(
                    title: 'For Runners',
                    image: 'assets/images/runner.png',
                    onPressed: () {},
                  ),Divider(height: 1, color: Colors.grey.withOpacity(0.2)),
                  buildCard(
                    title: 'Healthy Back',
                    image: 'assets/images/healthyback.png',
                    onPressed: () {},
                  ),Divider(height: 1, color: Colors.grey.withOpacity(0.2)),
                  buildCard(
                    title: 'Morning Yoga',
                    image: 'assets/images/morning.png',
                    onPressed: () {},
                  ),Divider(height: 1, color: Colors.grey.withOpacity(0.2)),
                  buildCard(
                    title: 'Yoga for Sleep',
                    image: 'assets/images/sleep.png',
                    onPressed: () {},
                  ),
                  SizedBox(height: 20),

                  Text(
                    'Stretching',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
                  ),
                  SizedBox(height: 10),
                  buildCard(
                    title: 'Full Body Stretching',
                    image: 'assets/images/fullstreching.png',
                    onPressed: () {},
                  ),Divider(height: 1, color: Colors.grey.withOpacity(0.2)),
                  buildCard(
                    title: 'Upper Body Stretching',
                    image: 'assets/images/upperstreching.png',
                    onPressed: () {},
                  ),Divider(height: 1, color: Colors.grey.withOpacity(0.2)),
                  buildCard(
                    title: 'Lower Body Stretching',
                    image: 'assets/images/lowerstreching.png',
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
      borderRadius: BorderRadius.circular(5), // Optional: Set to 0 for flush edges
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
