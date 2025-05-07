import 'package:fit_fusion/workout/cardio/Cardio.dart';
import 'package:fit_fusion/workout/loseFat/Balancedfat.dart';
import 'package:fit_fusion/workout/loseFat/Endurance.dart';
import 'package:fit_fusion/workout/loseFat/Supercardio.dart';
import 'package:fit_fusion/workout/loseFat/WeightLose.dart';
import 'package:fit_fusion/workout/loseFat/leantone.dart';
import 'package:fit_fusion/workout/strength/Strength.dart';
import 'package:fit_fusion/workout/warmup/Warmup.dart';
import 'package:fit_fusion/workout/yoga/Yoga.dart';
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
              WorkoutPlanCard(
                title: 'Super Cardio Burner',
                imagePath: 'assets/images/up.png',
                duration: '10 Weeks',
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => Supercardio())),
              ),
              const SizedBox(height: 20),
              CustomWorkoutCard(),
              const SizedBox(height: 20),
              Text('Lose fat', style: TextStyle(fontSize: 20,fontWeight: FontWeight.w900),),
              const SizedBox(height: 2),
              Text('You need to get your heart rate up to burn calories, and that what these plan are for',
                style: TextStyle(fontSize: 17,color: Colors.grey),),
              const SizedBox(height: 20),
              SizedBox(
                height: 350,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    FitnessCard(
                      title: "Weight Loss",
                      duration: "5 weeks",
                      imagePath: 'assets/images/powerjump.png',
                      cardioLevel: 0.8,
                      strengthLevel: 0.4,
                      onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => WeightLose())),
                    ),
                    FitnessCard(
                      title: "Balanced Fat",
                      duration: "5 weeks",
                      imagePath: 'assets/images/complexcore.png',
                      cardioLevel: 0.6,
                      strengthLevel: 0.4,
                      onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => Balancedfat())),
                    ),
                    FitnessCard(
                      title: "Endurance Builder",
                      duration: "6 weeks",
                      imagePath: 'assets/images/tabata.png',
                      cardioLevel: 0.4,
                      strengthLevel: 0.7,
                      onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => Endurance())),
                    ),
                    FitnessCard(
                      title: "Lean & Tone",
                      duration: "5 weeks",
                      imagePath: 'assets/images/upperbody.png',
                      cardioLevel: 0.5,
                      strengthLevel: 0.9,
                      onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => leantone())),
                    ),
                  ],
                ),
              ),

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
  final String title;
  final String imagePath;
  final String duration;
  final VoidCallback onPressed;

  const WorkoutPlanCard({
    super.key,
    required this.title,
    required this.imagePath,
    required this.duration,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(20),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          children: [
            SizedBox(
              height: 300,
              width: double.infinity,
              child: Image.asset(
                imagePath,
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
                  _tagLabel(duration, Colors.white70),
                ],
              ),
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
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        _iconWithText(Icons.signal_cellular_alt, 'Cardio', Colors.green),
                        const SizedBox(width: 20),
                        _iconWithText(Icons.signal_cellular_alt, 'Strength', Colors.green),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
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


class FitnessCard extends StatelessWidget {
  final String title;
  final String duration;
  final String imagePath;
  final double cardioLevel;
  final double strengthLevel;
  final VoidCallback onPressed;

  const FitnessCard({
    Key? key,
    required this.title,
    required this.duration,
    required this.imagePath,
    required this.cardioLevel,
    required this.strengthLevel,
    required this.onPressed,
  }) : super(key: key);

  Widget _buildProgressIndicator(double level, Color color) {
    return Row(
      children: [
        Icon(Icons.fiber_manual_record, color: color, size: 10),
        SizedBox(width: 4),
        Expanded(
          child: LinearProgressIndicator(
            value: level,
            backgroundColor: Colors.grey.shade300,
            valueColor: AlwaysStoppedAnimation<Color>(color),
            minHeight: 4,
            borderRadius: BorderRadius.circular(5),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onPressed,
        child: Container(
            width: 200,
            margin: EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.white,
              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8)],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                      child: Image.asset(imagePath, height: 160, width: double.infinity, fit: BoxFit.cover),
                    ),
                    Positioned(
                      top: 10,
                      left: 10,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.white70,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          duration,
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      SizedBox(height: 12),
                      _buildProgressIndicator(cardioLevel, Colors.green),
                      SizedBox(height: 4),
                      Text("Cardio", style: TextStyle(color: Colors.grey[700])),
                      SizedBox(height: 8),
                      _buildProgressIndicator(strengthLevel, Colors.green.shade200),
                      SizedBox(height: 4),
                      Text("Strength", style: TextStyle(color: Colors.grey[700])),
                    ],
                  ),
                ),
              ],
            ),
            ),
        );
    }
}