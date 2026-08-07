import 'package:fit_fusion/features/workout/legacy/strength/start_exercise.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Cardio extends StatefulWidget {
  const Cardio({super.key});

  @override
  State<Cardio> createState() => _CardioState();
}

class _CardioState extends State<Cardio> {
  int _selectedRest = 15; // 10s, 15s, 20s
  String _selectedHrZone = '130-150 BPM'; // 110-130, 130-150, 150-170+

  final List<Map<String, dynamic>> _engines = [
    {
      'id': 'tabata',
      'title': 'Tabata Express',
      'subtitle': '20s Work / High Burn',
      'image': 'assets/images/tabata.png',
      'focus': ['V02 Max', 'Explosive Power', 'Fat Loss'],
      'color': Colors.redAccent.shade700,
      'drills': [
        {'title': 'Fast Toe Touches', 'gif': 'assets/gifs/ToeTouches.gif'},
        {'title': 'Plank Jacks', 'gif': 'assets/gifs/plank.gif'},
        {'title': 'Speed Crunches', 'gif': 'assets/gifs/crunches.gif'},
        {'title': 'Fast Leg Raises', 'gif': 'assets/gifs/LegRaises.gif'},
      ],
    },
    {
      'id': 'aerobic',
      'title': 'Fat Burn Aerobic',
      'subtitle': 'Steady State Heart Rate Boost',
      'image': 'assets/images/lightcardio.png',
      'focus': ['Endurance', 'Caloric Burn', 'Heart Health'],
      'color': Colors.orange.shade800,
      'drills': [
        {'title': 'Steady Toe Touches', 'gif': 'assets/gifs/ToeTouches.gif'},
        {'title': 'Side Planks', 'gif': 'assets/gifs/sideplank.gif'},
        {'title': 'Slow Crunches', 'gif': 'assets/gifs/crunches.gif'},
      ],
    },
    {
      'id': 'plyometrics',
      'title': 'Explosive Plyometrics',
      'subtitle': 'Power Jump HIIT',
      'image': 'assets/images/polymetric.png',
      'focus': ['Agility', 'Speed', 'Muscle Tone'],
      'color': Colors.purple.shade700,
      'drills': [
        {'title': 'Explosive Planks', 'gif': 'assets/gifs/plank.gif'},
        {'title': 'Fast Toe Touches', 'gif': 'assets/gifs/ToeTouches.gif'},
        {'title': 'Power Leg Raises', 'gif': 'assets/gifs/LegRaises.gif'},
      ],
    },
  ];

  void _startEngineWorkout(Map<String, dynamic> engine) {
    List<Map<String, String>> drills = List<Map<String, String>>.from(engine['drills'] as List);
    // In a real app, we would pass _selectedRest and _selectedHrZone to the timer.
    Get.to(() => StartExercise(customExercises: drills));
  }

  @override
  Widget build(BuildContext context) {
    final restOptions = [10, 15, 20];
    final hrOptions = ['110-130 BPM', '130-150 BPM', '150-170+ BPM'];

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: CustomScrollView(
        slivers: [
          // Hero AppBar
          SliverAppBar(
            expandedHeight: 220.0,
            pinned: true,
            backgroundColor: Colors.redAccent.shade700,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                'HIIT & Cardio',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset('assets/images/cardio.png', fit: BoxFit.cover),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.black.withValues(alpha: 0.6),
                          Colors.redAccent.shade700.withValues(alpha: 0.8),
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
                            color: Colors.redAccent,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Text(
                            '🔥 3 CARDIO ENGINES',
                            style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Maximum Calorie Burn & Endurance',
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
                            Icon(Icons.monitor_heart_rounded, color: Colors.redAccent.shade700, size: 20),
                            const SizedBox(width: 8),
                            Text(
                              'Engine Control Panel',
                              style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        const SizedBox(height: 14),

                        // Rest Interval Selector
                        Text('Interval Rest Dial:', style: GoogleFonts.poppins(fontSize: 13, color: Colors.grey[700], fontWeight: FontWeight.w600)),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: restOptions.map((rest) {
                            final isSelected = _selectedRest == rest;
                            return ChoiceChip(
                              label: Text('${rest}s', style: TextStyle(color: isSelected ? Colors.white : Colors.black87, fontWeight: FontWeight.bold, fontSize: 12)),
                              selected: isSelected,
                              selectedColor: Colors.redAccent.shade700,
                              backgroundColor: Colors.grey[100],
                              onSelected: (_) => setState(() => _selectedRest = rest),
                            );
                          }).toList(),
                        ),
                        const SizedBox(height: 14),

                        // Heart Rate Zone Gauge
                        Text('Target Heart Rate Zone:', style: GoogleFonts.poppins(fontSize: 13, color: Colors.grey[700], fontWeight: FontWeight.w600)),
                        const SizedBox(height: 8),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: hrOptions.map((zone) {
                              final isSelected = _selectedHrZone == zone;
                              String iconStr = '🫁 ';
                              if (zone == '130-150 BPM') iconStr = '🔥 ';
                              if (zone == '150-170+ BPM') iconStr = '⚡ ';

                              return Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: ChoiceChip(
                                  label: Text('$iconStr$zone', style: TextStyle(color: isSelected ? Colors.white : Colors.black87, fontWeight: FontWeight.bold, fontSize: 12)),
                                  selected: isSelected,
                                  selectedColor: zone == '150-170+ BPM' ? Colors.purple.shade700 : Colors.redAccent.shade700,
                                  backgroundColor: Colors.grey[100],
                                  onSelected: (_) => setState(() => _selectedHrZone = zone),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Studios Section Title
                  Text(
                    'Choose Your Cardio Engine',
                    style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
                  ),
                  const SizedBox(height: 12),

                  // 3 Engine Cards
                  ..._engines.map((engine) {
                    final color = engine['color'] as Color;

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
                            onTap: () => _startEngineWorkout(engine),
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
                                          engine['image'] as String,
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
                                              engine['title'] as String,
                                              style: GoogleFonts.poppins(fontSize: 17, fontWeight: FontWeight.bold),
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              engine['subtitle'] as String,
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
                                                    '⏱️ ${_selectedRest}s Rest',
                                                    style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: color),
                                                  ),
                                                ),
                                                const SizedBox(width: 8),
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
                                          children: (engine['focus'] as List<String>).map((m) {
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
                                        onPressed: () => _startEngineWorkout(engine),
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
