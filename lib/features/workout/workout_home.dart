import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import 'package:fit_fusion/features/chat/ai_chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:fit_fusion/features/workout/legacy/strength/strength.dart';
import 'package:fit_fusion/features/workout/legacy/cardio/cardio.dart';
import 'package:fit_fusion/features/workout/legacy/yoga/yoga.dart';
import 'package:fit_fusion/features/workout/legacy/warmup/warmup.dart';
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
              const SizedBox(height: 10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Left Tall Column
                  Expanded(
                    flex: 5,
                    child: BentoTallCard(
                      title: 'Strength',
                      subtitle: 'Muscle & Power',
                      image: 'assets/images/strength.png',
                      color1: Colors.blue.shade900,
                      color2: Colors.blue.shade600,
                      onPressed: () => Get.to(() => Strength()),
                    ),
                  ),
                  const SizedBox(width: 15),
                  // Right Stacked Column
                  Expanded(
                    flex: 5,
                    child: Column(
                      children: [
                        BentoSmallCard(
                          title: 'Cardio',
                          subtitle: 'HIIT & Burn',
                          icon: Icons.local_fire_department_rounded,
                          color1: Colors.redAccent.shade700,
                          color2: Colors.orangeAccent.shade700,
                          onPressed: () => Get.to(() => Cardio()),
                        ),
                        const SizedBox(height: 15),
                        BentoSmallCard(
                          title: 'Yoga',
                          subtitle: 'Flexibility',
                          icon: Icons.self_improvement_rounded,
                          color1: Colors.teal.shade800,
                          color2: Colors.teal.shade500,
                          onPressed: () => Get.to(() => Yoga()),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              BentoWideCard(
                title: 'Warmup & Recovery',
                subtitle: 'Prepare & Heal your body',
                image: 'assets/images/warmup.png',
                color1: Colors.blueGrey.shade800,
                color2: Colors.blueGrey.shade600,
                onPressed: () => Get.to(() => Warmup()),
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

class BentoTallCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String image;
  final Color color1;
  final Color color2;
  final VoidCallback onPressed;

  const BentoTallCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.image,
    required this.color1,
    required this.color2,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 255, // Tall card height matches 2 stacked small cards (120 * 2 + 15)
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onPressed,
            borderRadius: BorderRadius.circular(24),
            child: Stack(
              children: [
              Positioned(
                right: -20,
                bottom: -10,
                child: Opacity(
                  opacity: 0.9,
                  child: Image.asset(
                    image,
                    height: 180,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: Colors.black87),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: TextStyle(fontSize: 13, color: Colors.grey.shade600, fontWeight: FontWeight.w600),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      )
    );
  }
}

class BentoSmallCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color1;
  final Color color2;
  final VoidCallback onPressed;

  const BentoSmallCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color1,
    required this.color2,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(24),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: color1.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(icon, color: color1, size: 20),
                    ),
                    const Icon(Icons.arrow_outward_rounded, color: Colors.black26, size: 18),
                  ],
                ),
                const Spacer(),
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black87),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade600, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BentoWideCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String image;
  final Color color1;
  final Color color2;
  final VoidCallback onPressed;

  const BentoWideCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.image,
    required this.color1,
    required this.color2,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(24),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: color1.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(Icons.spa_rounded, color: color1, size: 20),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black87),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: TextStyle(fontSize: 12, color: Colors.grey.shade600, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.arrow_forward_rounded, color: Colors.black26, size: 20),
              ],
            ),
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
