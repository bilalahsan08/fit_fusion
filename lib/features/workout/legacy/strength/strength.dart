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
  int _selectedDuration = 15; // 10, 15, 20, 30 mins
  String _selectedIntensity = 'Moderate'; // Light, Moderate, Beast Mode
  bool _includeWarmup = true;

  final List<Map<String, dynamic>> _studios = [
    {
      'id': 'full_body',
      'title': 'Full Body Hypertrophy',
      'subtitle': 'Build overall strength across all major muscle groups',
      'image': 'assets/images/fullbody.png',
      'muscles': ['Chest', 'Back', 'Quads', 'Core'],
      'color': Colors.blue.shade800,
      'drills': [
        {'title': 'Crunches', 'gif': 'assets/gifs/crunches.gif'},
        {'title': 'Side Plank Raises', 'gif': 'assets/gifs/sideplank.gif'},
        {'title': 'Leg Raises', 'gif': 'assets/gifs/LegRaises.gif'},
        {'title': 'Toe Touches', 'gif': 'assets/gifs/ToeTouches.gif'},
      ],
    },
    {
      'id': 'core_shred',
      'title': 'Core & Abs Shred',
      'subtitle': 'Target upper abs, lower abs, obliques & lower back',
      'image': 'assets/images/sixpack.png',
      'muscles': ['Upper Abs', 'Lower Abs', 'Obliques', 'Lower Back'],
      'color': Colors.redAccent.shade700,
      'drills': [
        {'title': 'Crunches', 'gif': 'assets/gifs/crunches.gif'},
        {'title': 'Leg Raises', 'gif': 'assets/gifs/LegRaises.gif'},
        {'title': 'Side Plank Raises', 'gif': 'assets/gifs/sideplank.gif'},
        {'title': 'Toe Touches', 'gif': 'assets/gifs/ToeTouches.gif'},
      ],
    },
    {
      'id': 'sculpt_split',
      'title': 'Sculpt Split',
      'subtitle': 'Upper body & lower body power circuits',
      'image': 'assets/images/upperbody.png',
      'muscles': ['Pectorals', 'Triceps', 'Glutes', 'Hamstrings'],
      'color': Colors.indigo.shade800,
      'drills': [
        {'title': 'Side Plank Raises', 'gif': 'assets/gifs/sideplank.gif'},
        {'title': 'Toe Touches', 'gif': 'assets/gifs/ToeTouches.gif'},
        {'title': 'Crunches', 'gif': 'assets/gifs/crunches.gif'},
      ],
    },
  ];

  void _startStudioWorkout(Map<String, dynamic> studio) {
    List<Map<String, String>> drills = List<Map<String, String>>.from(studio['drills'] as List);

    if (_includeWarmup) {
      drills.insert(0, {'title': '3-min Warmup Stretch', 'gif': 'assets/gifs/ToeTouches.gif'});
    }

    Get.to(() => StartExercise(customExercises: drills));
  }

  @override
  Widget build(BuildContext context) {
    final durationOptions = [10, 15, 20, 30];
    final intensityOptions = ['Light', 'Moderate', 'Beast Mode'];

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
                'Strength Studio',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset('assets/images/strength.png', fit: BoxFit.cover),
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
                            '🏋️ 3 CORE STUDIOS',
                            style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Interactive Customizer & Workouts',
                          style: GoogleFonts.poppins(fontSize: 14, color: Colors.white.withValues(alpha: 0.9)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Interactive Control Panel
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Control Panel Card
                  Container(
                    padding: const EdgeInsets.all(16),
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.tune_rounded, color: Colors.blue.shade800, size: 20),
                            const SizedBox(width: 8),
                            Text(
                              'Studio Control Panel',
                              style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        const SizedBox(height: 14),

                        // Duration Selector
                        Text('Target Duration:', style: GoogleFonts.poppins(fontSize: 13, color: Colors.grey[700], fontWeight: FontWeight.w600)),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: durationOptions.map((dur) {
                            final isSelected = _selectedDuration == dur;
                            return ChoiceChip(
                              label: Text('${dur}m', style: TextStyle(color: isSelected ? Colors.white : Colors.black87, fontWeight: FontWeight.bold, fontSize: 12)),
                              selected: isSelected,
                              selectedColor: Colors.blue.shade800,
                              backgroundColor: Colors.grey[100],
                              onSelected: (_) => setState(() => _selectedDuration = dur),
                            );
                          }).toList(),
                        ),
                        const SizedBox(height: 14),

                        // Intensity Selector
                        Text('Intensity Level:', style: GoogleFonts.poppins(fontSize: 13, color: Colors.grey[700], fontWeight: FontWeight.w600)),
                        const SizedBox(height: 8),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: intensityOptions.map((mode) {
                              final isSelected = _selectedIntensity == mode;
                              String iconStr = '🌱 ';
                              if (mode == 'Moderate') iconStr = '⚡ ';
                              if (mode == 'Beast Mode') iconStr = '🔥 ';

                              return Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: ChoiceChip(
                                  label: Text('$iconStr$mode', style: TextStyle(color: isSelected ? Colors.white : Colors.black87, fontWeight: FontWeight.bold, fontSize: 12)),
                                  selected: isSelected,
                                  selectedColor: mode == 'Beast Mode' ? Colors.redAccent.shade700 : Colors.blue.shade800,
                                  backgroundColor: Colors.grey[100],
                                  onSelected: (_) => setState(() => _selectedIntensity = mode),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Divider(),

                        // Warmup Toggle
                        SwitchListTile(
                          contentPadding: EdgeInsets.zero,
                          title: Text('Include 3-min Warmup Stretch', style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600)),
                          subtitle: Text('Prepend dynamic joint warmups before starting', style: TextStyle(fontSize: 11, color: Colors.grey[600])),
                          value: _includeWarmup,
                          activeThumbColor: Colors.blue.shade800,
                          onChanged: (val) => setState(() => _includeWarmup = val),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Studios Section Title
                  Text(
                    'Choose Your Studio Session',
                    style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
                  ),
                  const SizedBox(height: 12),

                  // 3 Studio Cards
                  ..._studios.map((studio) {
                    final color = studio['color'] as Color;

                    return Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(24),
                        child: Material(
                          color: Colors.white,
                          child: InkWell(
                            onTap: () => _startStudioWorkout(studio),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(16),
                                        child: Image.asset(
                                          studio['image'] as String,
                                          height: 80,
                                          width: 80,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      const SizedBox(width: 14),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              studio['title'] as String,
                                              style: GoogleFonts.poppins(fontSize: 17, fontWeight: FontWeight.bold),
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              studio['subtitle'] as String,
                                              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                                            ),
                                            const SizedBox(height: 8),
                                            Row(
                                              children: [
                                                Container(
                                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                                  decoration: BoxDecoration(
                                                    color: color.withValues(alpha: 0.1),
                                                    borderRadius: BorderRadius.circular(8),
                                                  ),
                                                  child: Text(
                                                    '⏱️ $_selectedDuration mins',
                                                    style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: color),
                                                  ),
                                                ),
                                                const SizedBox(width: 8),
                                                Container(
                                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                                  decoration: BoxDecoration(
                                                    color: Colors.orange.withValues(alpha: 0.1),
                                                    borderRadius: BorderRadius.circular(8),
                                                  ),
                                                  child: Text(
                                                    '⚡ $_selectedIntensity',
                                                    style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.orange),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 12),
                                  const Divider(),
                                  const SizedBox(height: 6),

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Wrap(
                                          spacing: 6,
                                          children: (studio['muscles'] as List<String>).map((m) {
                                            return Container(
                                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                              decoration: BoxDecoration(
                                                color: Colors.grey[100],
                                                borderRadius: BorderRadius.circular(6),
                                              ),
                                              child: Text(
                                                m,
                                                style: TextStyle(fontSize: 10, color: Colors.grey.shade800, fontWeight: FontWeight.w500),
                                              ),
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                      ElevatedButton.icon(
                                        onPressed: () => _startStudioWorkout(studio),
                                        icon: const Icon(Icons.play_arrow_rounded, size: 18),
                                        label: const Text('START'),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: color,
                                          foregroundColor: Colors.white,
                                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
