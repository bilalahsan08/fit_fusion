import 'dart:ui';

import 'package:flutter/material.dart';

class Warmup extends StatefulWidget{
  @override
  State<Warmup> createState() => _WarmupState();
}

class _WarmupState extends State<Warmup> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SingleChildScrollView(
        child: Stack(
          children: [
          Image.asset(
          'assets/images/warmup.png',
          width: double.infinity,
          height: 250,
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
                    'Warm Up & Recovery',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28,color: Colors.white.withOpacity(0.7)),
                  ),
                  SizedBox(height: 10),

                  // Description
                  Text(
                    'A well-rounded workout should be paired with a proper warm up and cool down to reduce risk of muscle injury and improve fitness performance.',
                    style: TextStyle(fontSize: 16,color: Colors.white.withOpacity(0.7)),
                  ),
                  SizedBox(height: 40),

                  buildCard(
                    title: 'Warm Up',
                    image: 'assets/images/up.png',
                    onPressed: () {},
                  ),Divider(height: 1, color: Colors.grey.withOpacity(0.2)),
                  buildCard(
                    title: 'Cool Down',
                    image: 'assets/images/cooldown.png',
                    onPressed: () {},
                  ),
                  SizedBox(height: 20),

                  Text(
                    'Myofascial Release',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
                  ),
                  SizedBox(height: 10),

                  buildCard(
                    title: 'Full Body Rolling',
                    image: 'assets/images/bodyrollng.png',
                    onPressed: () {},
                  ),Divider(height: 1, color: Colors.grey.withOpacity(0.2)),
                  buildCard(
                    title: 'Legs Rolling',
                    image: 'assets/images/legrolling.png',
                    onPressed: () {},
                  ),Divider(height: 1, color: Colors.grey.withOpacity(0.2)),
                  buildCard(
                    title: 'Back Rolling',
                    image: 'assets/images/backrolling.png',
                    onPressed: () {},
                  ),Divider(height: 1, color: Colors.grey.withOpacity(0.2)),
                  buildCard(
                    title: 'Neck Release',
                    image: 'assets/images/neck.png',
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
