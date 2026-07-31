import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
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
                children: [
                  Text(
                    'Workouts',
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      fontWeight: FontWeight.bold,
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
                height: 295,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    FitnessCard(
                      title: "Weight Loss",
                      duration: "5 weeks",
                      imagePath: 'assets/images/powerjump.png',
                      cardioLevel: 0.8,
                      strengthLevel: 0.4,
                      storageKey: 'weight_loss_progress',
                      onPressed: () => Get.to(() => const WeightLose())?.then((_) => setState(() {})),
                    ),
                    FitnessCard(
                      title: "Balanced Fat",
                      duration: "5 weeks",
                      imagePath: 'assets/images/complexcore.png',
                      cardioLevel: 0.6,
                      strengthLevel: 0.4,
                      storageKey: 'balanced_fat_progress',
                      onPressed: () => Get.to(() => const Balancedfat())?.then((_) => setState(() {})),
                    ),
                    FitnessCard(
                      title: "Endurance Builder",
                      duration: "6 weeks",
                      imagePath: 'assets/images/tabata.png',
                      cardioLevel: 0.4,
                      strengthLevel: 0.7,
                      storageKey: 'endurance_progress',
                      onPressed: () => Get.to(() => const Endurance())?.then((_) => setState(() {})),
                    ),
                    FitnessCard(
                      title: "Lean & Tone",
                      duration: "5 weeks",
                      imagePath: 'assets/images/upperbody.png',
                      cardioLevel: 0.5,
                      strengthLevel: 0.9,
                      storageKey: 'lean_tone_progress',
                      onPressed: () => Get.to(() => const leantone())?.then((_) => setState(() {})),
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


class FitnessCard extends StatefulWidget {
  final String title;
  final String duration;
  final String imagePath;
  final double cardioLevel;
  final double strengthLevel;
  final String storageKey;
  final VoidCallback onPressed;

  const FitnessCard({
    super.key,
    required this.title,
    required this.duration,
    required this.imagePath,
    required this.cardioLevel,
    required this.strengthLevel,
    required this.storageKey,
    required this.onPressed,
  });

  @override
  State<FitnessCard> createState() => _FitnessCardState();
}

class _FitnessCardState extends State<FitnessCard> {
  int _completedCount = 0;

  int get _planTotalTasks {
    if (widget.title.contains('Endurance')) return 18; // 6 weeks * 3
    return 15; // 5 weeks * 3
  }

  @override
  void initState() {
    super.initState();
    _loadProgress();
  }

  @override
  void didUpdateWidget(covariant FitnessCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    _loadProgress();
  }

  Future<void> _loadProgress() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? jsonStr = prefs.getString(widget.storageKey);
      if (jsonStr != null && jsonStr.isNotEmpty) {
        final Map<String, dynamic> rawMap = jsonDecode(jsonStr);
        final done = rawMap.values.where((v) => v == true).length;
        if (mounted) {
          setState(() {
            _completedCount = done;
          });
        }
      }
    } catch (e) {
      // Fallback
    }
  }

  String get _tagText {
    if (widget.title.contains('Loss')) return '🔥 FAT BURN';
    if (widget.title.contains('Balanced')) return '⚖️ RECOMP';
    if (widget.title.contains('Endurance')) return '🫁 STAMINA';
    return '✨ TONING';
  }

  Color get _tagColor {
    if (widget.title.contains('Loss')) return Colors.orangeAccent.shade700;
    if (widget.title.contains('Balanced')) return Colors.purpleAccent.shade700;
    if (widget.title.contains('Endurance')) return Colors.teal.shade700;
    return Colors.pinkAccent.shade400;
  }

  double get _overallProgressRatio => _planTotalTasks > 0 ? (_completedCount / _planTotalTasks).clamp(0.0, 1.0) : 0.0;
  int get _progressPercent => (_overallProgressRatio * 100).round();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      margin: const EdgeInsets.only(right: 16, top: 4, bottom: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Material(
          color: Colors.white,
          child: InkWell(
            onTap: widget.onPressed,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Image.asset(
                      widget.imagePath,
                      height: 130,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.transparent,
                              Colors.black.withValues(alpha: 0.6),
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 10,
                      left: 10,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: _tagColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          _tagText,
                          style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 10,
                      right: 10,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.6),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          widget.duration,
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 10),

                      // Overall Progress Line
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Overall Progress', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.grey.shade700)),
                              Text('$_progressPercent%', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: _tagColor)),
                            ],
                          ),
                          const SizedBox(height: 3),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: LinearProgressIndicator(
                              value: _overallProgressRatio,
                              minHeight: 5,
                              backgroundColor: Colors.grey[200],
                              valueColor: AlwaysStoppedAnimation<Color>(_tagColor),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),

                      // Dual Ratio Lines (Cardio & Strength)
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text('Cardio', style: TextStyle(fontSize: 10, color: Colors.grey)),
                                    Text('${(widget.cardioLevel * 100).round()}%', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.orangeAccent.shade700)),
                                  ],
                                ),
                                const SizedBox(height: 3),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(4),
                                  child: LinearProgressIndicator(
                                    value: widget.cardioLevel,
                                    minHeight: 4,
                                    backgroundColor: Colors.grey[200],
                                    valueColor: AlwaysStoppedAnimation<Color>(Colors.orangeAccent.shade700),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text('Strength', style: TextStyle(fontSize: 10, color: Colors.grey)),
                                    Text('${(widget.strengthLevel * 100).round()}%', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.deepPurpleAccent)),
                                  ],
                                ),
                                const SizedBox(height: 3),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(4),
                                  child: LinearProgressIndicator(
                                    value: widget.strengthLevel,
                                    minHeight: 4,
                                    backgroundColor: Colors.grey[200],
                                    valueColor: const AlwaysStoppedAnimation<Color>(Colors.deepPurpleAccent),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            _completedCount > 0 ? 'Continue ➔' : 'Start Plan ➔',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: _tagColor,
                            ),
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
}
