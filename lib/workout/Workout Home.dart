import 'package:fit_fusion/workout/cardio/Cardio.dart';
import 'package:fit_fusion/workout/strength/Strength.dart';
import 'package:fit_fusion/workout/warmup/Warmup.dart';
import 'package:fit_fusion/workout/yoga/Yoga.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class WorkoutHome extends StatefulWidget {
  @override
  State<WorkoutHome> createState() => _WorkoutHomeState();
}

class _WorkoutHomeState extends State<WorkoutHome> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Container(
          color: Colors.grey[100],
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Workouts',
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey[200],
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.list, color: Colors.black),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              WorkoutCategoryCard(
                title: 'Strength',
                image: 'assets/images/strength.png',
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => Strength())),
              ),
              WorkoutCategoryCard(
                title: 'HIIT, Cardio',
                image: 'assets/images/cardio.png',
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => Cardio())),
              ),
              WorkoutCategoryCard(
                title: 'Yoga, Stretching',
                image: 'assets/images/legrolling.png',
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => Yoga())),
              ),
              WorkoutCategoryCard(
                title: 'Warmup, Recovery',
                image: 'assets/images/warmup.png',
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => Warmup())),
              ),
              const SizedBox(height: 20),
              const WorkoutPlanCard(),
              const SizedBox(height: 20),
              CustomWorkoutCard(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class WorkoutCategoryCard extends StatelessWidget {
  final String title;
  final String image;
  final VoidCallback onPressed;

  const WorkoutCategoryCard({
    super.key,
    required this.title,
    required this.image,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 15),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(15),
        splashColor: Colors.grey.withOpacity(0.2),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  image,
                  height: 80,
                  width: 80,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomWorkoutCard extends StatelessWidget {
  const CustomWorkoutCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(15),
        splashColor: Colors.grey.withOpacity(0.2),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Custom Workouts',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
              ),
              const SizedBox(height: 5),
              const Text(
                'Create your own with our workout builder!',
                style: TextStyle(fontSize: 14, color: Colors.black54),
              ),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.centerRight,
                child: Icon(Icons.arrow_forward_ios, size: 18, color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class WorkoutPlanCard extends StatelessWidget {
  const WorkoutPlanCard({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Stack(
        children: [
          SizedBox(
            height: 300,
            width: double.infinity,
            child: Image.asset(
              'assets/images/up.png',
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 16,
            left: 16,
            right: 16,
            child: Row(
              children: [
                _tagLabel('Your Personal Plan', Colors.limeAccent),
                const SizedBox(width: 8),
                _tagLabel('12 weeks', Colors.white70),
              ],
            ),
          ),
          Positioned(
            top: 70,
            left: 16,
            child: _smallInfoLabel('87% Reported Weight Loss'),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              width: MediaQuery.of(context).size.width - 30,
              padding: const EdgeInsets.all(20),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Super Cardio Burner',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      _iconWithText(Icons.signal_cellular_alt, 'Cardio', Colors.green),
                      const SizedBox(width: 20),
                      _iconWithText(Icons.signal_cellular_alt, 'Strength', Colors.grey),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _tagLabel(String text, Color background) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.black),
      ),
    );
  }

  Widget _smallInfoLabel(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.black26),
      ),
      child: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
      ),
    );
  }

  Widget _iconWithText(IconData icon, String label, Color color) {
    return Row(
      children: [
        Icon(icon, color: color, size: 20),
        const SizedBox(width: 4),
        Text(
          label,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: color),
        ),
      ],
    );
  }
}