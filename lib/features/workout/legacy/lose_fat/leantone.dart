import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fit_fusion/features/workout/legacy/strength/start_exercise.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class leantone extends StatefulWidget {
  const leantone({super.key});

  @override
  State<leantone> createState() => _leantoneState();
}

class _leantoneState extends State<leantone> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref();

  int _selectedWeek = 1;
  Map<String, bool> _completedMap = {};
  bool _isLoading = true;

  final Map<int, List<String>> _weeksData = {
    1: ["Upper Body Sculpting", "15-min Toning Circuit", "High Protein Nutrition"],
    2: ["Lower Body Sculpt & Glute Burn", "20-min Cardio Burn", "Hydrate 3L Water"],
    3: ["Core & Obliques Sculpt", "Resistance Band Workout", "Balanced Clean Diet"],
    4: ["Full Body Toning Circuit", "Yoga & Flexibility", "Sleep 8 Hours"],
    5: ["Final Sculpting Test", "Full Body Stretch", "Track Body Measurements"],
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
      final String? jsonStr = prefs.getString('lean_tone_progress');

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
      await prefs.setString('lean_tone_progress', jsonEncode(_completedMap));

      final user = _auth.currentUser;
      if (user != null) {
        await _dbRef.child('User').child(user.uid).child('lean_tone_progress').set(_completedMap);
      }
    } catch (e) {
      // Error
    }

    if (newValue) {
      Get.snackbar(
        'Task Complete! ✨',
        'Looking lean and toned! Great work!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.pinkAccent.shade400,
        colorText: Colors.white,
      );
    }
  }

  int get _completedCount => _completedMap.values.where((val) => val == true).length;
  int get _totalTasks => 15; // 5 weeks * 3 tasks
  double get _progressRatio => _totalTasks > 0 ? _completedCount / _totalTasks : 0.0;

  void _startWorkoutTimer(String taskTitle) {
    List<Map<String, String>> customDrills = [
      {'title': 'Side Plank Raises', 'gif': 'assets/gifs/sideplank.gif'},
      {'title': 'Crunches', 'gif': 'assets/gifs/crunches.gif'},
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
          SliverAppBar(
            expandedHeight: 250.0,
            pinned: true,
            backgroundColor: Colors.pinkAccent.shade400,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                'Lean & Tone Plan',
                style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white),
              ),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset('assets/images/upperbody.png', fit: BoxFit.cover),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.black.withValues(alpha: 0.6), Colors.pink.shade900.withValues(alpha: 0.8)],
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
                          decoration: BoxDecoration(color: Colors.pinkAccent, borderRadius: BorderRadius.circular(10)),
                          child: const Text('✨ MUSCLE SCULPTING', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.white)),
                        ),
                        const SizedBox(height: 8),
                        Text('5-Week Toning Plan', style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 10, offset: const Offset(0, 4))],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Overall Progress', style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold)),
                            Text('${(_progressRatio * 100).round()}%', style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.pinkAccent.shade400)),
                          ],
                        ),
                        const SizedBox(height: 10),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: LinearProgressIndicator(
                            value: _progressRatio,
                            minHeight: 10,
                            backgroundColor: Colors.grey[200],
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.pinkAccent.shade400),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text('$_completedCount of $_totalTasks tasks completed', style: TextStyle(fontSize: 12, color: Colors.grey[600])),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Select Week:', style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold)),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: Colors.pinkAccent.shade400),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<int>(
                            value: _selectedWeek,
                            items: List.generate(5, (i) => i + 1).map((w) {
                              return DropdownMenuItem<int>(
                                value: w,
                                child: Text('Week $w', style: GoogleFonts.poppins(fontWeight: FontWeight.bold, color: Colors.pinkAccent.shade400)),
                              );
                            }).toList(),
                            onChanged: (val) {
                              if (val != null) setState(() => _selectedWeek = val);
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

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
                            boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.03), blurRadius: 8)],
                          ),
                          child: ListTile(
                            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            leading: Checkbox(
                              activeColor: Colors.pinkAccent.shade400,
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
                              icon: const Icon(Icons.play_circle_fill_rounded, color: Colors.pinkAccent, size: 32),
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