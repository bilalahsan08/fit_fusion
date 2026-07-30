import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fit_fusion/features/workout/legacy/strength/start_exercise.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ExerciseInfo {
  final String title;
  final String gif;
  final List<String> targetMuscles;
  final int caloriesPerMin;
  final String equipment;
  final List<String> techniqueSteps;
  final String aiCoachTip;

  ExerciseInfo({
    required this.title,
    required this.gif,
    required this.targetMuscles,
    required this.caloriesPerMin,
    required this.equipment,
    required this.techniqueSteps,
    required this.aiCoachTip,
  });

  Map<String, String> toMap({int workSecs = 30, int restSecs = 15}) => {
        'title': title,
        'gif': gif,
        'workSecs': workSecs.toString(),
        'restSecs': restSecs.toString(),
      };
}

final List<ExerciseInfo> exerciseLibrary = [
  ExerciseInfo(
    title: 'Crunches',
    gif: 'assets/gifs/crunches.gif',
    targetMuscles: ['Upper Abs', 'Core', 'Transverse Abdominis'],
    caloriesPerMin: 10,
    equipment: 'Yoga Mat',
    techniqueSteps: [
      'Lie flat on your back with knees bent at a 90-degree angle.',
      'Place fingertips behind your head without pulling your neck.',
      'Exhale and curl your shoulders up towards your knees, contracting your abs.',
      'Hold peak contraction for 1 sec, then lower slowly while inhaling.',
    ],
    aiCoachTip: 'Keep lower back pressed firmly against the mat to prevent lumbar strain.',
  ),
  ExerciseInfo(
    title: 'Side Plank Raises',
    gif: 'assets/gifs/sideplank.gif',
    targetMuscles: ['Obliques', 'Lateral Core', 'Glute Medius'],
    caloriesPerMin: 12,
    equipment: 'Bodyweight',
    techniqueSteps: [
      'Lie on your side, propped up on your forearm directly below your shoulder.',
      'Stack your feet and lift your hips until your body forms a straight line.',
      'Lower bottom hip gently towards floor, then press back up explosively.',
    ],
    aiCoachTip: 'Engage your glutes and don’t let your hips sag backwards during movement.',
  ),
  ExerciseInfo(
    title: 'Leg Raises',
    gif: 'assets/gifs/LegRaises.gif',
    targetMuscles: ['Lower Abs', 'Hip Flexors', 'Core Stabilizers'],
    caloriesPerMin: 11,
    equipment: 'Yoga Mat',
    techniqueSteps: [
      'Lie flat on back with arms extended by sides or hands under glutes.',
      'Keep legs fully extended and raise them toward ceiling until perpendicular.',
      'Slowly lower legs back down until just inches off floor without touching.',
    ],
    aiCoachTip: 'If your lower back arches off mat, bend knees slightly to reduce lever length.',
  ),
  ExerciseInfo(
    title: 'Toe Touches',
    gif: 'assets/gifs/ToeTouches.gif',
    targetMuscles: ['Upper Abs', 'Rectus Abdominis', 'Hamstrings'],
    caloriesPerMin: 9,
    equipment: 'Bodyweight',
    techniqueSteps: [
      'Lie on back and extend both legs straight up towards ceiling.',
      'Reach your arms straight up towards your toes.',
      'Crunch upward by flexing upper abs until fingertips touch toes or ankles.',
    ],
    aiCoachTip: 'Focus on lifting your chest straight up rather than pulling chin into neck.',
  ),
];

class CustomWorkoutRoutine {
  final String id;
  final String title;
  final List<Map<String, String>> exercises;

  CustomWorkoutRoutine({
    required this.id,
    required this.title,
    required this.exercises,
  });

  int get totalCalories {
    int sum = 0;
    for (var ex in exercises) {
      final info = exerciseLibrary.firstWhere(
        (e) => e.title == ex['title'],
        orElse: () => exerciseLibrary.first,
      );
      final workSecs = int.tryParse(ex['workSecs'] ?? '30') ?? 30;
      sum += (info.caloriesPerMin * (workSecs / 60.0) * 3).round();
    }
    return sum > 0 ? sum : 90;
  }

  int get estDurationMins {
    int totalSecs = 0;
    for (var ex in exercises) {
      final workSecs = int.tryParse(ex['workSecs'] ?? '30') ?? 30;
      final restSecs = int.tryParse(ex['restSecs'] ?? '15') ?? 15;
      totalSecs += (workSecs + restSecs) * 3; // 3 rounds
    }
    final mins = (totalSecs / 60).round();
    return mins > 0 ? mins : 12;
  }

  String get intensityScore {
    final cals = totalCalories;
    if (cals > 150) return '🔥 HIGH INTENSITY';
    if (cals > 90) return '⚡ MODERATE';
    return '🌱 LIGHT';
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'exercises': exercises,
      };

  factory CustomWorkoutRoutine.fromJson(Map<String, dynamic> json) {
    final rawList = json['exercises'] as List? ?? [];
    final parsedExercises = rawList.map((e) => Map<String, String>.from(e as Map)).toList();
    return CustomWorkoutRoutine(
      id: json['id'] ?? '',
      title: json['title'] ?? 'Custom Workout',
      exercises: parsedExercises,
    );
  }
}

class CustomWorkoutScreen extends StatefulWidget {
  const CustomWorkoutScreen({super.key});

  @override
  State<CustomWorkoutScreen> createState() => _CustomWorkoutScreenState();
}

class _CustomWorkoutScreenState extends State<CustomWorkoutScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref();

  List<CustomWorkoutRoutine> _routines = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadRoutines();
  }

  Future<void> _loadRoutines() async {
    setState(() => _isLoading = true);
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? jsonStr = prefs.getString('custom_routines');

      if (jsonStr != null && jsonStr.isNotEmpty) {
        final List raw = jsonDecode(jsonStr);
        _routines = raw.map((item) => CustomWorkoutRoutine.fromJson(Map<String, dynamic>.from(item))).toList();
      } else {
        // Default sample routine
        _routines = [
          CustomWorkoutRoutine(
            id: 'sample_1',
            title: 'Pro Core & Abs Blast',
            exercises: [
              {'title': 'Crunches', 'gif': 'assets/gifs/crunches.gif', 'workSecs': '30', 'restSecs': '15'},
              {'title': 'Leg Raises', 'gif': 'assets/gifs/LegRaises.gif', 'workSecs': '30', 'restSecs': '15'},
              {'title': 'Side Plank Raises', 'gif': 'assets/gifs/sideplank.gif', 'workSecs': '30', 'restSecs': '15'},
            ],
          )
        ];
        await _saveRoutines();
      }
    } catch (e) {
      // Fallback
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _saveRoutines() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonList = _routines.map((r) => r.toJson()).toList();
      await prefs.setString('custom_routines', jsonEncode(jsonList));

      final user = _auth.currentUser;
      if (user != null) {
        await _dbRef.child('User').child(user.uid).child('custom_workouts').set(jsonList);
      }
    } catch (e) {
      // Handle error
    }
  }

  void _deleteRoutine(int index) {
    final title = _routines[index].title;
    setState(() {
      _routines.removeAt(index);
    });
    _saveRoutines();
    Get.snackbar(
      'Routine Removed',
      '"$title" was deleted',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.redAccent,
      colorText: Colors.white,
    );
  }

  void _showSmartAiGeneratorSheet() {
    String selectedFocus = 'Abs & Core';
    int selectedDuration = 15;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => StatefulBuilder(
        builder: (context, setModalState) => Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
          ),
          padding: EdgeInsets.only(
            left: 24,
            right: 24,
            top: 24,
            bottom: MediaQuery.of(context).viewInsets.bottom + 24,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.amberAccent.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Icons.auto_awesome_rounded, color: Colors.amber, size: 24),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      'AI Smart Generator',
                      style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  'Automatically generate a dynamic, balanced routine based on your goals.',
                  style: TextStyle(color: Colors.grey[600], fontSize: 13),
                ),
                const SizedBox(height: 20),

                const Text('Select Target Focus Area:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 10,
                  children: ['Abs & Core', 'Lower Body', 'Full Body HIIT'].map((focus) {
                    final isSelected = selectedFocus == focus;
                    return ChoiceChip(
                      label: Text(focus),
                      selected: isSelected,
                      selectedColor: Colors.blueAccent,
                      labelStyle: TextStyle(
                        color: isSelected ? Colors.white : Colors.black87,
                        fontWeight: FontWeight.bold,
                      ),
                      onSelected: (val) {
                        if (val) setModalState(() => selectedFocus = focus);
                      },
                    );
                  }).toList(),
                ),
                const SizedBox(height: 20),

                const Text('Target Duration (Minutes):', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                const SizedBox(height: 10),
                Row(
                  children: [10, 15, 20].map((dur) {
                    final isSelected = selectedDuration == dur;
                    return Expanded(
                      child: GestureDetector(
                        onTap: () => setModalState(() => selectedDuration = dur),
                        child: Container(
                          margin: const EdgeInsets.only(right: 8),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            color: isSelected ? Colors.blueAccent : Colors.grey[100],
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(color: isSelected ? Colors.blueAccent : Colors.grey.shade300),
                          ),
                          child: Center(
                            child: Text(
                              '$dur Mins',
                              style: TextStyle(
                                color: isSelected ? Colors.white : Colors.black87,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 24),

                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      List<ExerciseInfo> picks = [];
                      if (selectedFocus == 'Abs & Core') {
                        picks = [exerciseLibrary[0], exerciseLibrary[2], exerciseLibrary[1]];
                      } else if (selectedFocus == 'Lower Body') {
                        picks = [exerciseLibrary[2], exerciseLibrary[3], exerciseLibrary[1]];
                      } else {
                        picks = exerciseLibrary;
                      }

                      final newRoutine = CustomWorkoutRoutine(
                        id: DateTime.now().millisecondsSinceEpoch.toString(),
                        title: 'AI $selectedFocus ($selectedDuration Mins)',
                        exercises: picks
                            .map((e) => e.toMap(workSecs: selectedDuration > 15 ? 45 : 30, restSecs: 15))
                            .toList(),
                      );

                      setState(() {
                        _routines.add(newRoutine);
                      });
                      _saveRoutines();

                      Navigator.pop(ctx);
                      Get.snackbar(
                        'AI Routine Generated! ⚡',
                        '"${newRoutine.title}" created successfully',
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.indigo.shade800,
                        colorText: Colors.white,
                      );
                    },
                    icon: const Icon(Icons.auto_awesome_rounded, color: Colors.white),
                    label: const Text('Generate Smart Routine', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 16)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showExerciseIntelligenceSheet(ExerciseInfo info) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        ),
        padding: const EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    info.title,
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black87),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close_rounded, color: Colors.grey),
                    onPressed: () => Navigator.pop(ctx),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: info.targetMuscles.map((muscle) {
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.blueAccent.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.blueAccent.withValues(alpha: 0.3)),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.track_changes_rounded, size: 14, color: Colors.blueAccent),
                        const SizedBox(width: 6),
                        Text(
                          muscle,
                          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.blueAccent),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),

              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.orangeAccent.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.local_fire_department_rounded, color: Colors.orangeAccent, size: 20),
                          const SizedBox(width: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Est. Burn', style: TextStyle(fontSize: 11, color: Colors.grey[600])),
                              Text('~${info.caloriesPerMin * 3} kcal', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.purpleAccent.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.fitness_center_rounded, color: Colors.purpleAccent, size: 20),
                          const SizedBox(width: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Equipment', style: TextStyle(fontSize: 11, color: Colors.grey[600])),
                              Text(info.equipment, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              const Text('📋 Step-by-Step Execution Guide', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              Column(
                children: info.techniqueSteps.asMap().entries.map((entry) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 24,
                          height: 24,
                          decoration: const BoxDecoration(color: Colors.blueAccent, shape: BoxShape.circle),
                          child: Center(
                            child: Text(
                              '${entry.key + 1}',
                              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(entry.value, style: const TextStyle(fontSize: 14, height: 1.4, color: Colors.black87)),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),

              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [Colors.indigo.shade800, Colors.blue.shade900]),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.lightbulb_rounded, color: Colors.amberAccent, size: 28),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('AI PRO-TIP FOR INJURY PREVENTION', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.amberAccent)),
                          const SizedBox(height: 4),
                          Text(info.aiCoachTip, style: const TextStyle(fontSize: 13, color: Colors.white, height: 1.3)),
                        ],
                      ),
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

  void _showCreateRoutineSheet() {
    final nameCtrl = TextEditingController();
    final Map<String, Map<String, int>> selectedExMap = {}; // title -> {workSecs, restSecs}

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(28))),
      builder: (ctx) => StatefulBuilder(
        builder: (context, setModalState) => SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              left: 20,
              right: 20,
              top: 24,
              bottom: MediaQuery.of(context).viewInsets.bottom + 24,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Create Custom Workout Routine', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),
                TextField(
                  controller: nameCtrl,
                  decoration: InputDecoration(
                    labelText: 'Routine Name',
                    hintText: 'e.g. Abs & Core Blast',
                    prefixIcon: const Icon(Icons.fitness_center_rounded),
                    filled: true,
                    fillColor: Colors.grey[100],
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
                  ),
                ),
                const SizedBox(height: 20),
                const Text('Pick Exercises & Customize Timers:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),

                Column(
                  children: exerciseLibrary.map((ex) {
                    final isSelected = selectedExMap.containsKey(ex.title);
                    final workSecs = selectedExMap[ex.title]?['workSecs'] ?? 30;
                    final restSecs = selectedExMap[ex.title]?['restSecs'] ?? 15;

                    return Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.blueAccent.withValues(alpha: 0.08) : Colors.grey[100],
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: isSelected ? Colors.blueAccent : Colors.transparent, width: 1.5),
                      ),
                      child: Column(
                        children: [
                          CheckboxListTile(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                            activeColor: Colors.blueAccent,
                            value: isSelected,
                            title: Text(ex.title, style: TextStyle(fontWeight: isSelected ? FontWeight.bold : FontWeight.normal)),
                            subtitle: Text('Target: ${ex.targetMuscles.first}', style: TextStyle(fontSize: 12, color: Colors.grey[600])),
                            secondary: IconButton(
                              icon: const Icon(Icons.info_outline_rounded, color: Colors.blueAccent),
                              onPressed: () => _showExerciseIntelligenceSheet(ex),
                            ),
                            onChanged: (val) {
                              setModalState(() {
                                if (val == true) {
                                  selectedExMap[ex.title] = {'workSecs': 30, 'restSecs': 15};
                                } else {
                                  selectedExMap.remove(ex.title);
                                }
                              });
                            },
                          ),
                          if (isSelected)
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Work Time: $workSecs sec', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                                      Text('Rest: $restSecs sec', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.orangeAccent)),
                                    ],
                                  ),
                                  Slider(
                                    value: workSecs.toDouble(),
                                    min: 15,
                                    max: 60,
                                    divisions: 9,
                                    activeColor: Colors.blueAccent,
                                    onChanged: (val) {
                                      setModalState(() {
                                        selectedExMap[ex.title]!['workSecs'] = val.toInt();
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 20),

                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: () {
                      final title = nameCtrl.text.trim();
                      if (title.isEmpty) {
                        Get.snackbar('Title Required', 'Please give your routine a name');
                        return;
                      }
                      if (selectedExMap.isEmpty) {
                        Get.snackbar('Select Exercises', 'Select at least 1 exercise');
                        return;
                      }

                      final List<Map<String, String>> exercisesPayload = [];
                      selectedExMap.forEach((exTitle, timers) {
                        final info = exerciseLibrary.firstWhere((e) => e.title == exTitle);
                        exercisesPayload.add(info.toMap(
                          workSecs: timers['workSecs'] ?? 30,
                          restSecs: timers['restSecs'] ?? 15,
                        ));
                      });

                      final newRoutine = CustomWorkoutRoutine(
                        id: DateTime.now().millisecondsSinceEpoch.toString(),
                        title: title,
                        exercises: exercisesPayload,
                      );

                      setState(() {
                        _routines.add(newRoutine);
                      });
                      _saveRoutines();

                      Navigator.pop(ctx);
                      Get.snackbar(
                        'Routine Created!',
                        '"$title" is ready to train',
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.green,
                        colorText: Colors.white,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    ),
                    child: const Text('Save & Build Routine', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black87),
        ),
        title: const Text('Custom Workouts', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black87)),
        centerTitle: true,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              children: [
                // Top Hero Banner
                Container(
                  padding: const EdgeInsets.all(20),
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
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.15), shape: BoxShape.circle),
                            child: const Icon(Icons.tune_rounded, color: Colors.white, size: 32),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Workout Builder', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
                                const SizedBox(height: 4),
                                Text('${_routines.length} Custom Plans Created', style: TextStyle(color: Colors.white.withValues(alpha: 0.9), fontSize: 13)),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton.icon(
                          onPressed: _showSmartAiGeneratorSheet,
                          icon: const Icon(Icons.auto_awesome_rounded, color: Colors.amberAccent),
                          label: const Text('⚡ Smart AI Routine Generator', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Colors.amberAccent, width: 1.5),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                if (_routines.isEmpty)
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 40),
                      child: Column(
                        children: [
                          Icon(Icons.fitness_center_outlined, size: 64, color: Colors.grey[400]),
                          const SizedBox(height: 16),
                          Text('No Custom Routines', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey[600])),
                        ],
                      ),
                    ),
                  )
                else
                  Column(
                    children: _routines.asMap().entries.map((entry) {
                      final index = entry.key;
                      final routine = entry.value;

                      return Container(
                        margin: const EdgeInsets.only(bottom: 16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: [
                            BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 10, offset: const Offset(0, 3)),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(routine.title, style: const TextStyle(fontSize: 19, fontWeight: FontWeight.bold, color: Colors.black87)),
                                  IconButton(
                                    icon: const Icon(Icons.delete_outline_rounded, color: Colors.redAccent),
                                    onPressed: () => _deleteRoutine(index),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),

                              // Dynamic Gauges
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                    decoration: BoxDecoration(color: Colors.blueAccent.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(10)),
                                    child: Row(
                                      children: [
                                        const Icon(Icons.timer_outlined, size: 14, color: Colors.blueAccent),
                                        const SizedBox(width: 4),
                                        Text('~${routine.estDurationMins} Mins', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.blueAccent)),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                    decoration: BoxDecoration(color: Colors.orangeAccent.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(10)),
                                    child: Row(
                                      children: [
                                        const Icon(Icons.local_fire_department_rounded, size: 14, color: Colors.orangeAccent),
                                        const SizedBox(width: 4),
                                        Text('~${routine.totalCalories} kcal', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.orangeAccent)),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                    decoration: BoxDecoration(color: Colors.amberAccent.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(10)),
                                    child: Text(routine.intensityScore, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.brown)),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 14),

                              const Text('Exercises (Tap for details):', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey)),
                              const SizedBox(height: 8),
                              Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                children: routine.exercises.map((exMap) {
                                  final exTitle = exMap['title'] ?? '';
                                  final workSecs = exMap['workSecs'] ?? '30';
                                  final info = exerciseLibrary.firstWhere((e) => e.title == exTitle, orElse: () => exerciseLibrary.first);

                                  return ActionChip(
                                    avatar: const Icon(Icons.info_outline_rounded, size: 16, color: Colors.blueAccent),
                                    label: Text('$exTitle (${workSecs}s)'),
                                    backgroundColor: Colors.grey[100],
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                    onPressed: () => _showExerciseIntelligenceSheet(info),
                                  );
                                }).toList(),
                              ),
                              const SizedBox(height: 20),

                              SizedBox(
                                width: double.infinity,
                                height: 48,
                                child: ElevatedButton.icon(
                                  onPressed: () {
                                    Get.to(() => StartExercise(customExercises: routine.exercises));
                                  },
                                  icon: const Icon(Icons.play_arrow_rounded, color: Colors.white),
                                  label: const Text('Start Workout', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blueAccent,
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
              ],
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showCreateRoutineSheet,
        backgroundColor: Colors.blueAccent,
        icon: const Icon(Icons.add_rounded, color: Colors.white),
        label: const Text('Build Routine', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
  }
}
