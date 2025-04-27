import 'dart:ui';

import 'package:fit_fusion/workout/strength/Fullbody.dart';
import 'package:fit_fusion/workout/strength/Sixpack.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Strength extends StatefulWidget{
  @override
  State<Strength> createState() => _StrengthState();
}

class _StrengthState extends State<Strength> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SingleChildScrollView(
        child: Stack(
          children: [
          Image.asset(
          'assets/images/strength.png',
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
                    'Strength',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28,color: Colors.white.withOpacity(0.7)),
                  ),
                  SizedBox(height: 10),

                  // Description
                  Text(
                    'Improve strength and endurance. Choose a muscle group you want to target and see results shortly!',
                    style: TextStyle(fontSize: 16,color: Colors.white.withOpacity(0.7)),
                  ),
                  SizedBox(height: 40),

                  buildCard(
                    title: 'Full Body',
                    image: 'assets/images/fullbody.png',
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder:(context) => Fullbody()));
                    },
                  ),
                  SizedBox(height: 20),

                  Text(
                    'Abs & Core',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
                  ),
                  SizedBox(height: 10),
                  buildCard(
                    title: 'Insane Six Pack',
                    image: 'assets/images/sixpack.png',
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder:(context) => Sixpack()));
                    },
                  ),Divider(height: 1, color: Colors.grey.withOpacity(0.2)),
                  buildCard(
                    title: 'Complex Core',
                    image: 'assets/images/complexcore.png',
                    onPressed: () {},
                  ),Divider(height: 1, color: Colors.grey.withOpacity(0.2)),
                  buildCard(
                    title: 'Strong Back',
                    image: 'assets/images/strongback.png',
                    onPressed: () {},
                  ),
                  SizedBox(height: 20),

                  // Lower Body
                  Text(
                    'Lower Body',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
                  ),
                  SizedBox(height: 10),
                  buildCard(
                    title: 'Complex Lower Body',
                    image: 'assets/images/lowerbody.png',
                    onPressed: () {},
                  ),Divider(height: 1, color: Colors.grey.withOpacity(0.2)),
                  buildCard(
                    title: 'Explosive Power Jumps',
                    image: 'assets/images/powerjump.png',
                    onPressed: () {},
                  ),
                  SizedBox(height: 20),

                  // Upper Body
                  Text(
                    'Upper Body',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
                  ),
                  SizedBox(height: 10),
                  buildCard(
                    title: 'Complex Upper Body',
                    image: 'assets/images/upperbody.png',
                    onPressed: () {},
                  ),Divider(height: 1, color: Colors.grey.withOpacity(0.2)),
                  buildCard(
                    title: 'Chest & Arms',
                    image: 'assets/images/chestarm.png',
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
      color: Colors.white.withOpacity(0.6),
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
