import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fit_fusion/features/workout/legacy/strength/start_exercise.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Supercardio extends StatefulWidget {
  const Supercardio({super.key});

  @override
  State<Supercardio> createState() => _SupercardioState();
}

class _SupercardioState extends State<Supercardio> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref();

  int _selectedWeek = 1;
  Map<String, bool> _completedMap = {};
  bool _isLoading = true;

  final Map<int, List<String>> _weeksData = {
    1: [
      "20-min Brisk Walk",
      "15-min HIIT (Low Impact)",
      "Jump Rope (5 min x 2)",
      "Core: Plank & Crunches",
      "Rest or Stretch",
    ],
    2: [
      "25-min Jog/Walk",
      "20-min Bodyweight HIIT",
      "Jump Rope (5 min x 3)",
      "Lower Body Cardio",
      "Active Recovery",
    ],
    3: [
      "30-min Steady Jog",
      "25-min HIIT",
      "Tabata (4x4 min)",
      "8-min Core Finisher",
      "Walk + Stretch",
    ],
    4: [
      "35-min Jog",
      "30-min Full Body HIIT",
      "10-min Jump Rope",
      "EMOM Workout",
      "Foam Rolling",
    ],
    5: [
      "40-min Cardio Dance",
      "25-min Hill Sprints",
      "Plyo HIIT",
      "Total Body Sweat",
      "Mobility Work",
    ],
    6: [
      "45-min Steady Cardio",
      "30-min Intense HIIT",
      "Jump Rope Tabata",
      "Core + Glute Burn",
      "Rest Walk",
    ],
    7: [
      "50-min Cardio Kickboxing",
      "20-min Sprints",
      "Resistance HIIT",
      "15-min Core Burn",
      "Yoga Recovery",
    ],
    8: [
      "60-min Mixed Cardio",
      "35-min Bodyweight Blast",
      "10-min AMRAP",
      "Cardio + Core Hybrid",
      "Long Walk",
    ],
    9: [
      "30-min Fast Run",
      "Tabata HIIT (5 rounds)",
      "Jump Rope + Core",
      "Ladder Workout",
      "Deep Stretch",
    ],
    10: [
      "75-min Cardio Challenge",
      "30-min HIIT + Abs",
      "EMOM & AMRAP Combo",
      "Reflection & Goal Setting",
      "Celebration Walk",
    ],
  };

  @override
  void initState() {
    super.initState();
    _loadProgress();
  }

  Future<void> _loadProgress() async {
    setState(() => _isLoading = true);
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? jsonStr = prefs.getString('supercardio_progress');

      if (jsonStr != null && jsonStr.isNotEmpty) {
        final Map<String, dynamic> rawMap = jsonDecode(jsonStr);
        _completedMap = rawMap.map((key, val) => MapEntry(key, val as bool));
      }
    } catch (e) {
      // Fallback
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _toggleTask(int week, int taskIndex) async {
    final key = 'w${week}_t$taskIndex';
    final newValue = !(_completedMap[key] ?? false);

    setState(() {
      _completedMap[key] = newValue;
    });

    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('supercardio_progress', jsonEncode(_completedMap));

      final user = _auth.currentUser;
      if (user != null) {
        await _dbRef.child('User').child(user.uid).child('supercardio_progress').set(_completedMap);
      }
    } catch (e) {
      // Error saving
    }

    if (newValue) {
      Get.snackbar(
        'Task Completed! 🎉',
        'Great job keeping up with your cardio goal!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.orangeAccent,
        colorText: Colors.white,
      );
    }
  }

  int get _completedCount => _completedMap.values.where((val) => val == true).length;
  int get _totalTasks => 50; // 10 weeks * 5 tasks
  double get _progressRatio => _totalTasks > 0 ? _completedCount / _totalTasks : 0.0;

  void _startWorkoutTimer(String taskTitle) {
    // Maps task title to exercise routine for StartExercise timer
    List<Map<String, String>> customDrills = [
      {'title': 'Crunches', 'gif': 'assets/gifs/crunches.gif'},
      {'title': 'Side Plank Raises', 'gif': 'assets/gifs/sideplank.gif'},
      {'title': 'Leg Raises', 'gif': 'assets/gifs/LegRaises.gif'},
      {'title': 'Toe Touches', 'gif': 'assets/gifs/ToeTouches.gif'},
    ];

    Get.to(() => StartExercise(customExercises: customDrills));
  }

  @override
  Widget build(BuildContext context) {
    final weekTasks = _weeksData[_selectedWeek] ?? [];

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: CustomScrollView(
        slivers: [
          // Collapsible Header Sliver
          SliverAppBar(
            expandedHeight: 260.0,
            pinned: true,
            backgroundColor: Colors.orange.shade800,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                'Super Cardio Burner',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    'assets/images/up.png',
                    fit: BoxFit.cover,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.black.withValues(alpha: 0.7),
                          Colors.orange.shade900.withValues(alpha: 0.8),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 60,
                    left: 20,
                    right: 20,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.orangeAccent,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Text(
                            '🔥 HIGH INTENSITY CARDIO',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '10-Week Fat Loss Program',
                          style: GoogleFonts.poppins(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Main Content
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Progress Card
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Overall Progress',
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            Text(
                              '${(_progressRatio * 100).round()}%',
                              style: GoogleFonts.poppins(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.orangeAccent.shade700,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: LinearProgressIndicator(
                            value: _progressRatio,
                            minHeight: 10,
                            backgroundColor: Colors.grey[200],
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.orangeAccent.shade700),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '$_completedCount of $_totalTasks tasks completed',
                          style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Week Selector Dropdown / Chips
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Select Week Plan:',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: Colors.orangeAccent.withValues(alpha: 0.5)),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<int>(
                            value: _selectedWeek,
                            icon: const Icon(Icons.keyboard_arrow_down_rounded, color: Colors.orangeAccent),
                            items: List.generate(10, (i) => i + 1).map((w) {
                              return DropdownMenuItem<int>(
                                value: w,
                                child: Text(
                                  'Week $w',
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.orangeAccent.shade700,
                                  ),
                                ),
                              );
                            }).toList(),
                            onChanged: (newWeek) {
                              if (newWeek != null) {
                                setState(() => _selectedWeek = newWeek);
                              }
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Current Selected Week Header Card
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.orange.shade700, Colors.deepOrange.shade600],
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.calendar_today_rounded, color: Colors.white, size: 24),
                        const SizedBox(width: 12),
                        Text(
                          'Week $_selectedWeek Workouts',
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 14),

                  // Week Tasks List
                  if (_isLoading)
                    const Center(child: CircularProgressIndicator())
                  else
                    Column(
                      children: weekTasks.asMap().entries.map((entry) {
                        final taskIndex = entry.key;
                        final taskTitle = entry.value;
                        final taskKey = 'w${_selectedWeek}_t$taskIndex';
                        final isDone = _completedMap[taskKey] ?? false;

                        return Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.03),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: ListTile(
                            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            leading: Checkbox(
                              activeColor: Colors.orangeAccent.shade700,
                              value: isDone,
                              onChanged: (_) => _toggleTask(_selectedWeek, taskIndex),
                            ),
                            title: Text(
                              taskTitle,
                              style: GoogleFonts.poppins(
                                fontSize: 15,
                                fontWeight: isDone ? FontWeight.bold : FontWeight.w500,
                                color: isDone ? Colors.grey[500] : Colors.black87,
                                decoration: isDone ? TextDecoration.lineThrough : TextDecoration.none,
                              ),
                            ),
                            trailing: IconButton(
                              icon: const Icon(Icons.play_circle_fill_rounded, color: Colors.orangeAccent, size: 32),
                              onPressed: () => _startWorkoutTimer(taskTitle),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
