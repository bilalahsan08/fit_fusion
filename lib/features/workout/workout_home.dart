import 'package:fit_fusion/core/routes/app_routes.dart';
import 'package:fit_fusion/core/data/app_data.dart';
import 'package:fit_fusion/features/workout/pages/workout_program_screen.dart';
import 'package:get/get.dart';
import 'package:fit_fusion/features/chat/ai_chat_screen.dart';
import 'package:flutter/material.dart';

import 'package:fit_fusion/features/workout/legacy/strength/strength.dart';
import 'package:fit_fusion/features/workout/legacy/cardio/cardio.dart';
import 'package:fit_fusion/features/workout/legacy/yoga/yoga.dart';
import 'package:fit_fusion/features/workout/legacy/warmup/warmup.dart';
import 'package:fit_fusion/features/workout/legacy/lose_fat/supercardio.dart';
import 'package:fit_fusion/features/workout/legacy/lose_fat/weight_lose.dart';
import 'package:fit_fusion/features/workout/legacy/lose_fat/balancedfat.dart';
import 'package:fit_fusion/features/workout/legacy/lose_fat/endurance.dart';
import 'package:fit_fusion/features/workout/legacy/lose_fat/leantone.dart';
import 'package:fit_fusion/features/workout/custom_workout_screen.dart';

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
                onPressed: () => Get.to(() => Strength()),
              ),
              WorkoutCategoryCard(
                title: 'HIIT, Cardio',
                image: 'assets/images/cardio.png',
                onPressed: () => Get.to(() => Cardio()),
              ),
              WorkoutCategoryCard(
                title: 'Yoga, Stretching',
                image: 'assets/images/legrolling.png',
                onPressed: () => Get.to(() => Yoga()),
              ),
              WorkoutCategoryCard(
                title: 'Warmup, Recovery',
                image: 'assets/images/warmup.png',
                onPressed: () => Get.to(() => Warmup()),
              ),
              const SizedBox(height: 20),
              WorkoutPlanCard(
                title: 'Super Cardio Burner',
                imagePath: 'assets/images/up.png',
                duration: '10 Weeks',
                onPressed: () => Get.to(() => Supercardio()),
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
                      onPressed: () => Get.to(() => WeightLose()),
                    ),
                    FitnessCard(
                      title: "Balanced Fat",
                      duration: "5 weeks",
                      imagePath: 'assets/images/complexcore.png',
                      cardioLevel: 0.6,
                      strengthLevel: 0.4,
                      onPressed: () => Get.to(() => Balancedfat()),
                    ),
                    FitnessCard(
                      title: "Endurance Builder",
                      duration: "6 weeks",
                      imagePath: 'assets/images/tabata.png',
                      cardioLevel: 0.4,
                      strengthLevel: 0.7,
                      onPressed: () => Get.to(() => Endurance()),
                    ),
                    FitnessCard(
                      title: "Lean & Tone",
                      duration: "5 weeks",
                      imagePath: 'assets/images/upperbody.png',
                      cardioLevel: 0.5,
                      strengthLevel: 0.9,
                      onPressed: () => Get.to(() => leantone()),
                    ),
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => ChatScreen());
        },
        backgroundColor: Colors.white, // or transparent if you want only the image look
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: Image.asset(
            'assets/images/AICHAT.png',
            height: 35,
            width: 35,
            fit: BoxFit.cover,
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
        splashColor: Colors.grey.withValues(alpha: 0.2),
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
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.indigo.shade800, Colors.blue.shade700],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.blueAccent.withValues(alpha: 0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => Get.to(() => const CustomWorkoutScreen()),
          borderRadius: BorderRadius.circular(24),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: const Icon(
                        Icons.tune_rounded,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text(
                        '⚡ PRO BUILDER',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: Colors.amberAccent,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Text(
                  'Custom Workout Builder',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Design personalized routines with custom exercise selections & timers.',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.white.withValues(alpha: 0.9),
                    height: 1.3,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        _buildBadge('🎯 Custom Targets'),
                        const SizedBox(width: 8),
                        _buildBadge('⏱️ Timers'),
                      ],
                    ),
                    Row(
                      children: const [
                        Text(
                          'Build Now',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(width: 4),
                        Icon(
                          Icons.arrow_forward_rounded,
                          color: Colors.white,
                          size: 16,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBadge(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.bold,
          color: Colors.white,
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
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Material(
          color: Colors.white,
          child: InkWell(
            onTap: onPressed,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    SizedBox(
                      height: 180,
                      width: double.infinity,
                      child: Image.asset(
                        imagePath,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.black.withValues(alpha: 0.2),
                              Colors.black.withValues(alpha: 0.7),
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 16,
                      left: 16,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.orangeAccent,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Text(
                          '🔥 HIGH BURN',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 16,
                      left: 16,
                      child: Row(
                        children: [
                          const Icon(Icons.calendar_today_rounded, size: 16, color: Colors.white),
                          const SizedBox(width: 6),
                          Text(
                            duration,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        '10-Week structured fat burn & endurance plan with daily progress tracking.',
                        style: TextStyle(fontSize: 13, color: Colors.black54, height: 1.3),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              _iconWithText(Icons.directions_run_rounded, 'Cardio', Colors.orangeAccent.shade700),
                              const SizedBox(width: 16),
                              _iconWithText(Icons.fitness_center_rounded, 'Strength', Colors.deepPurpleAccent),
                            ],
                          ),
                          ElevatedButton(
                            onPressed: onPressed,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orangeAccent.shade700,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                            ),
                            child: const Text('Start Program', style: TextStyle(fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
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
