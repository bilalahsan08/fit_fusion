import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fit_fusion/features/workout/legacy/strength/start_exercise.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomWorkoutRoutine {
  final String id;
  final String title;
  final List<Map<String, String>> exercises;

  CustomWorkoutRoutine({
    required this.id,
    required this.title,
    required this.exercises,
  });

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

  final List<Map<String, String>> _availableExerciseLibrary = [
    {'title': 'Crunches', 'gif': 'assets/gifs/crunches.gif'},
    {'title': 'Side Plank Raises', 'gif': 'assets/gifs/sideplank.gif'},
    {'title': 'Leg Raises', 'gif': 'assets/gifs/LegRaises.gif'},
    {'title': 'Toe Touches', 'gif': 'assets/gifs/ToeTouches.gif'},
  ];

  @override
  void initState() {
    super.initState();
    _loadCustomRoutines();
  }

  Future<void> _loadCustomRoutines() async {
    setState(() => _isLoading = true);
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? jsonStr = prefs.getString('custom_routines');

      if (jsonStr != null && jsonStr.isNotEmpty) {
        final List raw = jsonDecode(jsonStr);
        _routines = raw.map((item) => CustomWorkoutRoutine.fromJson(Map<String, dynamic>.from(item))).toList();
      } else {
        // Default sample custom routine if empty
        _routines = [
          CustomWorkoutRoutine(
            id: 'default_1',
            title: 'Express Core Routine',
            exercises: [
              {'title': 'Crunches', 'gif': 'assets/gifs/crunches.gif'},
              {'title': 'Leg Raises', 'gif': 'assets/gifs/LegRaises.gif'},
            ],
          )
        ];
        await _saveRoutinesToStorage();
      }
    } catch (e) {
      // Fallback
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _saveRoutinesToStorage() async {
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
    setState(() {
      _routines.removeAt(index);
    });
    _saveRoutinesToStorage();
    Get.snackbar(
      'Routine Deleted',
      'The custom workout was removed',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void _showCreateRoutineModal() {
    final nameCtrl = TextEditingController();
    final List<Map<String, String>> selectedExercises = [];

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) => StatefulBuilder(
        builder: (context, setModalState) => Padding(
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
              const Text(
                'Build Custom Routine',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: nameCtrl,
                decoration: InputDecoration(
                  labelText: 'Routine Name',
                  hintText: 'e.g. Morning Abs Blast',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                  prefixIcon: const Icon(Icons.fitness_center_rounded),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Select Exercises:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Column(
                children: _availableExerciseLibrary.map((ex) {
                  final isSelected = selectedExercises.any((item) => item['title'] == ex['title']);
                  return CheckboxListTile(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    title: Text(ex['title'] ?? ''),
                    value: isSelected,
                    activeColor: Colors.blueAccent,
                    onChanged: (val) {
                      setModalState(() {
                        if (val == true) {
                          selectedExercises.add(ex);
                        } else {
                          selectedExercises.removeWhere((item) => item['title'] == ex['title']);
                        }
                      });
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () {
                    final title = nameCtrl.text.trim();
                    if (title.isEmpty) {
                      Get.snackbar('Name Required', 'Please enter a routine name');
                      return;
                    }
                    if (selectedExercises.isEmpty) {
                      Get.snackbar('Select Exercises', 'Please select at least 1 exercise');
                      return;
                    }

                    final newRoutine = CustomWorkoutRoutine(
                      id: DateTime.now().millisecondsSinceEpoch.toString(),
                      title: title,
                      exercises: selectedExercises,
                    );

                    setState(() {
                      _routines.add(newRoutine);
                    });
                    _saveRoutinesToStorage();

                    Navigator.pop(ctx);
                    Get.snackbar(
                      'Routine Saved!',
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
                  child: const Text('Save Routine', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
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
        backgroundColor: Colors.grey[100],
        elevation: 0,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black87),
        ),
        title: const Text(
          'Custom Workouts',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black87),
        ),
        centerTitle: true,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _routines.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.fitness_center_outlined, size: 64, color: Colors.grey[400]),
                      const SizedBox(height: 16),
                      Text(
                        'No custom routines yet',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey[600]),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Build your own workout plan with your favorite exercises!',
                        style: TextStyle(color: Colors.grey[500]),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: _routines.length,
                  itemBuilder: (context, index) {
                    final routine = _routines[index];
                    return Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.04),
                            blurRadius: 10,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  routine.title,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete_outline_rounded, color: Colors.redAccent),
                                  onPressed: () => _deleteRoutine(index),
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),
                            Text(
                              '${routine.exercises.length} Exercises: ${routine.exercises.map((e) => e['title']).join(', ')}',
                              style: TextStyle(color: Colors.grey[600], fontSize: 13),
                            ),
                            const SizedBox(height: 16),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton.icon(
                                onPressed: () {
                                  Get.to(() => StartExercise(customExercises: routine.exercises));
                                },
                                icon: const Icon(Icons.play_arrow_rounded, color: Colors.white),
                                label: const Text('Start Workout', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blueAccent,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showCreateRoutineModal,
        backgroundColor: Colors.blueAccent,
        icon: const Icon(Icons.add_rounded, color: Colors.white),
        label: const Text('Create Routine', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
  }
}
