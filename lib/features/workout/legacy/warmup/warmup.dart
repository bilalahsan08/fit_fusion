import 'package:fit_fusion/features/workout/legacy/strength/start_exercise.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Warmup extends StatefulWidget {
  const Warmup({super.key});

  @override
  State<Warmup> createState() => _WarmupState();
}

class _WarmupState extends State<Warmup> {
  String _selectedRegion = 'Neck & Shoulders'; // Neck & Shoulders, Lower Back, Legs & Glutes

  final List<Map<String, dynamic>> _clinics = [
    {
      'id': 'preworkout',
      'title': 'Pre-Workout Activation',
      'subtitle': '5-min Dynamic Warmup',
      'image': 'assets/images/up.png',
      'focus': ['Blood Flow', 'Joint Mobility', 'Injury Prep'],
      'color': Colors.orange.shade700,
      'drills': [
        {'title': 'Arm Circles', 'gif': 'assets/gifs/ToeTouches.gif'}, // Placeholder
        {'title': 'Dynamic Lunges', 'gif': 'assets/gifs/LegRaises.gif'}, // Placeholder
      ],
    },
    {
      'id': 'cooldown',
      'title': 'Post-Workout Cool Down',
      'subtitle': '5-min Heart Rate Lowering',
      'image': 'assets/images/cooldown.png',
      'focus': ['Heart Rate', 'Lactic Acid', 'Recovery'],
      'color': Colors.lightBlue.shade700,
      'drills': [
        {'title': 'Slow Walking', 'gif': 'assets/gifs/sideplank.gif'}, // Placeholder
        {'title': 'Static Hamstring Stretch', 'gif': 'assets/gifs/ToeTouches.gif'}, // Placeholder
      ],
    },
    {
      'id': 'foamrolling',
      'title': 'Soreness Foam Rolling',
      'subtitle': 'Myofascial Release',
      'image': 'assets/images/bodyrollng.png',
      'focus': ['Deep Tissue', 'Knots', 'Muscle Relief'],
      'color': Colors.purple.shade600,
      'drills': [
        {'title': 'Quad Foam Roll', 'gif': 'assets/gifs/plank.gif'}, // Placeholder
        {'title': 'IT Band Roll', 'gif': 'assets/gifs/sideplank.gif'}, // Placeholder
      ],
    },
  ];

  void _startClinicWorkout(Map<String, dynamic> clinic) {
    List<Map<String, String>> drills = List<Map<String, String>>.from(clinic['drills'] as List);
    
    // Dynamically insert a targeted stretch if foam rolling based on soreness region
    if (clinic['id'] == 'foamrolling') {
      if (_selectedRegion == 'Neck & Shoulders') {
        drills.insert(0, {'title': 'Upper Back Roll', 'gif': 'assets/gifs/crunches.gif'});
      } else if (_selectedRegion == 'Lower Back') {
        drills.insert(0, {'title': 'Lower Back Gentle Roll', 'gif': 'assets/gifs/plank.gif'});
      } else if (_selectedRegion == 'Legs & Glutes') {
        drills.insert(0, {'title': 'Glute Smash Roll', 'gif': 'assets/gifs/LegRaises.gif'});
      }
    }

    Get.to(() => StartExercise(customExercises: drills));
  }

  @override
  Widget build(BuildContext context) {
    final regionOptions = ['Neck & Shoulders', 'Lower Back', 'Legs & Glutes'];

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: CustomScrollView(
        slivers: [
          // Hero AppBar
          SliverAppBar(
            expandedHeight: 220.0,
            pinned: true,
            backgroundColor: Colors.blueGrey.shade800,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                'Recovery Clinic',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset('assets/images/warmup.png', fit: BoxFit.cover),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.black.withValues(alpha: 0.6),
                          Colors.blueGrey.shade900.withValues(alpha: 0.8),
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
                            color: Colors.blueGrey.shade400,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Text(
                            '🩹 3 HEALING CLINICS',
                            style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Injury Prevention & Muscle Care',
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
                            Icon(Icons.health_and_safety_rounded, color: Colors.blueGrey.shade700, size: 20),
                            const SizedBox(width: 8),
                            Text(
                              'Targeted Relief Settings',
                              style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        const SizedBox(height: 14),

                        Text('Where are you most sore today?', style: GoogleFonts.poppins(fontSize: 13, color: Colors.grey[700], fontWeight: FontWeight.w600)),
                        const SizedBox(height: 8),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: regionOptions.map((region) {
                              final isSelected = _selectedRegion == region;
                              return Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: ChoiceChip(
                                  label: Text(region, style: TextStyle(color: isSelected ? Colors.white : Colors.black87, fontWeight: FontWeight.bold, fontSize: 12)),
                                  selected: isSelected,
                                  selectedColor: Colors.blueGrey.shade700,
                                  backgroundColor: Colors.grey[100],
                                  onSelected: (_) => setState(() => _selectedRegion = region),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Select a region to dynamically customize your foam rolling clinic.',
                          style: TextStyle(fontSize: 11, color: Colors.grey[500]),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Studios Section Title
                  Text(
                    'Choose Your Clinic',
                    style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
                  ),
                  const SizedBox(height: 12),

                  // 3 Clinic Cards
                  ..._clinics.map((clinic) {
                    final color = clinic['color'] as Color;

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
                            onTap: () => _startClinicWorkout(clinic),
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
                                          clinic['image'] as String,
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
                                              clinic['title'] as String,
                                              style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold),
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              clinic['subtitle'] as String,
                                              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
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
                                          children: (clinic['focus'] as List<String>).map((m) {
                                            return Container(
                                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                              decoration: BoxDecoration(
                                                color: Colors.grey[100],
                                                borderRadius: BorderRadius.circular(6),
                                              ),
                                              child: Text(
                                                m,
                                                style: TextStyle(fontSize: 10, color: Colors.blueGrey.shade800, fontWeight: FontWeight.w500),
                                              ),
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                      ElevatedButton.icon(
                                        onPressed: () => _startClinicWorkout(clinic),
                                        icon: const Icon(Icons.play_arrow_rounded, size: 18),
                                        label: const Text('HEAL'),
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
