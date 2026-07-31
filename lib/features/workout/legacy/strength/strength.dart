import 'package:fit_fusion/features/workout/legacy/strength/fullbody.dart';
import 'package:fit_fusion/features/workout/legacy/strength/sixpack.dart';
import 'package:fit_fusion/features/workout/legacy/strength/start_exercise.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Strength extends StatefulWidget {
  const Strength({super.key});

  @override
  State<Strength> createState() => _StrengthState();
}

class _StrengthState extends State<Strength> {
  String _selectedCategory = 'All';

  final List<Map<String, dynamic>> _routines = [
    {
      'title': 'Full Body Strength',
      'category': 'Full Body',
      'image': 'assets/images/fullbody.png',
      'duration': '25 mins',
      'difficulty': 'INTERMEDIATE',
      'diffColor': Colors.orange,
      'muscles': ['Full Body', 'Core', 'Legs'],
      'screen': Fullbody(),
      'customDrills': null,
    },
    {
      'title': 'Insane Six Pack',
      'category': 'Abs & Core',
      'image': 'assets/images/sixpack.png',
      'duration': '15 mins',
      'difficulty': 'ADVANCED',
      'diffColor': Colors.redAccent,
      'muscles': ['Upper Abs', 'Lower Abs', 'Obliques'],
      'screen': Sixpack(),
      'customDrills': null,
    },
    {
      'title': 'Complex Core',
      'category': 'Abs & Core',
      'image': 'assets/images/complexcore.png',
      'duration': '18 mins',
      'difficulty': 'INTERMEDIATE',
      'diffColor': Colors.orange,
      'muscles': ['Core Stability', 'Obliques', 'Lower Back'],
      'screen': null,
      'customDrills': [
        {'title': 'Crunches', 'gif': 'assets/gifs/crunches.gif'},
        {'title': 'Side Plank Raises', 'gif': 'assets/gifs/sideplank.gif'},
        {'title': 'Toe Touches', 'gif': 'assets/gifs/ToeTouches.gif'},
      ],
    },
    {
      'title': 'Strong Back',
      'category': 'Abs & Core',
      'image': 'assets/images/strongback.png',
      'duration': '20 mins',
      'difficulty': 'INTERMEDIATE',
      'diffColor': Colors.orange,
      'muscles': ['Lats', 'Rhomboids', 'Postural Chain'],
      'screen': null,
      'customDrills': [
        {'title': 'Side Plank Raises', 'gif': 'assets/gifs/sideplank.gif'},
        {'title': 'Toe Touches', 'gif': 'assets/gifs/ToeTouches.gif'},
        {'title': 'Leg Raises', 'gif': 'assets/gifs/LegRaises.gif'},
      ],
    },
    {
      'title': 'Complex Lower Body',
      'category': 'Lower Body',
      'image': 'assets/images/lowerbody.png',
      'duration': '22 mins',
      'difficulty': 'ADVANCED',
      'diffColor': Colors.redAccent,
      'muscles': ['Quads', 'Hamstrings', 'Glutes'],
      'screen': null,
      'customDrills': [
        {'title': 'Leg Raises', 'gif': 'assets/gifs/LegRaises.gif'},
        {'title': 'Toe Touches', 'gif': 'assets/gifs/ToeTouches.gif'},
      ],
    },
    {
      'title': 'Explosive Power Jumps',
      'category': 'Lower Body',
      'image': 'assets/images/powerjump.png',
      'duration': '15 mins',
      'difficulty': 'BEGINNER',
      'diffColor': Colors.green,
      'muscles': ['Calves', 'Plyometrics', 'Explosiveness'],
      'screen': null,
      'customDrills': [
        {'title': 'Toe Touches', 'gif': 'assets/gifs/ToeTouches.gif'},
        {'title': 'Crunches', 'gif': 'assets/gifs/crunches.gif'},
      ],
    },
    {
      'title': 'Complex Upper Body',
      'category': 'Upper Body',
      'image': 'assets/images/upperbody.png',
      'duration': '20 mins',
      'difficulty': 'INTERMEDIATE',
      'diffColor': Colors.orange,
      'muscles': ['Shoulders', 'Chest', 'Biceps'],
      'screen': null,
      'customDrills': [
        {'title': 'Crunches', 'gif': 'assets/gifs/crunches.gif'},
        {'title': 'Side Plank Raises', 'gif': 'assets/gifs/sideplank.gif'},
      ],
    },
    {
      'title': 'Chest & Arms Sculpt',
      'category': 'Upper Body',
      'image': 'assets/images/chestarm.png',
      'duration': '25 mins',
      'difficulty': 'ADVANCED',
      'diffColor': Colors.redAccent,
      'muscles': ['Pectorals', 'Triceps', 'Forearms'],
      'screen': null,
      'customDrills': [
        {'title': 'Side Plank Raises', 'gif': 'assets/gifs/sideplank.gif'},
        {'title': 'Toe Touches', 'gif': 'assets/gifs/ToeTouches.gif'},
      ],
    },
  ];

  List<Map<String, dynamic>> get _filteredRoutines {
    if (_selectedCategory == 'All') return _routines;
    return _routines.where((r) => r['category'] == _selectedCategory).toList();
  }

  void _launchRoutine(Map<String, dynamic> routine) {
    if (routine['screen'] != null) {
      Get.to(() => routine['screen'] as Widget);
    } else if (routine['customDrills'] != null) {
      Get.to(() => StartExercise(
            customExercises: List<Map<String, String>>.from(
              routine['customDrills'] as List,
            ),
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    final categories = ['All', 'Full Body', 'Abs & Core', 'Lower Body', 'Upper Body'];

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: CustomScrollView(
        slivers: [
          // Hero AppBar
          SliverAppBar(
            expandedHeight: 220.0,
            pinned: true,
            backgroundColor: Colors.blue.shade900,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                'Strength Programs',
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
                    'assets/images/strength.png',
                    fit: BoxFit.cover,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.black.withValues(alpha: 0.6),
                          Colors.blue.shade900.withValues(alpha: 0.8),
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
                            color: Colors.blueAccent,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Text(
                            '💪 8 STRENGTH ROUTINES',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Target Muscle Groups & Build Power',
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: Colors.white.withValues(alpha: 0.9),
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
                  // Filter Chips
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: categories.map((cat) {
                        final isSelected = _selectedCategory == cat;
                        return Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: ChoiceChip(
                            label: Text(
                              cat,
                              style: TextStyle(
                                color: isSelected ? Colors.white : Colors.black87,
                                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                              ),
                            ),
                            selected: isSelected,
                            selectedColor: Colors.blue.shade800,
                            backgroundColor: Colors.white,
                            elevation: isSelected ? 2 : 0,
                            onSelected: (_) {
                              setState(() => _selectedCategory = cat);
                            },
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Routine Cards
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _filteredRoutines.length,
                    itemBuilder: (context, index) {
                      final r = _filteredRoutines[index];
                      return Container(
                        margin: const EdgeInsets.only(bottom: 14),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.04),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(20),
                          onTap: () => _launchRoutine(r),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: Image.asset(
                                    r['image'] as String,
                                    height: 85,
                                    width: 85,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(width: 14),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        r['title'] as String,
                                        style: GoogleFonts.poppins(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black87,
                                        ),
                                      ),
                                      const SizedBox(height: 6),
                                      Row(
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                            decoration: BoxDecoration(
                                              color: (r['diffColor'] as Color).withValues(alpha: 0.15),
                                              borderRadius: BorderRadius.circular(6),
                                            ),
                                            child: Text(
                                              r['difficulty'] as String,
                                              style: TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold,
                                                color: r['diffColor'] as Color,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                          Icon(Icons.timer_outlined, size: 13, color: Colors.grey[600]),
                                          const SizedBox(width: 3),
                                          Text(
                                            r['duration'] as String,
                                            style: TextStyle(fontSize: 11, color: Colors.grey[700]),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 6),
                                      Wrap(
                                        spacing: 4,
                                        children: (r['muscles'] as List<String>).map((m) {
                                          return Container(
                                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                            decoration: BoxDecoration(
                                              color: Colors.grey[100],
                                              borderRadius: BorderRadius.circular(6),
                                            ),
                                            child: Text(
                                              m,
                                              style: const TextStyle(fontSize: 9, color: Colors.black54),
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                    ],
                                  ),
                                ),
                                Icon(
                                  Icons.play_circle_fill_rounded,
                                  color: Colors.blue.shade800,
                                  size: 36,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
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
