import 'package:fit_fusion/features/workout/legacy/strength/start_exercise.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Yoga extends StatefulWidget {
  const Yoga({super.key});

  @override
  State<Yoga> createState() => _YogaState();
}

class _YogaState extends State<Yoga> with SingleTickerProviderStateMixin {
  int _poseHold = 30; // 30s, 60s
  late AnimationController _breathController;
  late Animation<double> _breathAnimation;

  final List<Map<String, dynamic>> _flows = [
    {
      'id': 'morning',
      'title': 'Morning Energy Flow',
      'subtitle': 'Flexibility & Wake-up',
      'image': 'assets/images/morning.png',
      'focus': ['Energy', 'Flexibility', 'Mindfulness'],
      'color': Colors.amber.shade800,
      'drills': [
        {'title': 'Sun Salutation', 'gif': 'assets/gifs/ToeTouches.gif'},
        {'title': 'Warrior Pose', 'gif': 'assets/gifs/sideplank.gif'},
      ],
    },
    {
      'id': 'spine',
      'title': 'Spine & Posture Relief',
      'subtitle': 'Back & Neck Tension Release',
      'image': 'assets/images/healthyback.png',
      'focus': ['Posture', 'Pain Relief', 'Alignment'],
      'color': Colors.teal.shade700,
      'drills': [
        {'title': 'Cat-Cow Stretch', 'gif': 'assets/gifs/plank.gif'},
        {'title': 'Child\'s Pose', 'gif': 'assets/gifs/crunches.gif'}, // Placeholder
      ],
    },
    {
      'id': 'sleep',
      'title': 'Bedtime Sleep Stretch',
      'subtitle': 'Relaxation & Unwind',
      'image': 'assets/images/sleep.png',
      'focus': ['Relaxation', 'Deep Sleep', 'Calm'],
      'color': Colors.indigo.shade500,
      'drills': [
        {'title': 'Lying Spinal Twist', 'gif': 'assets/gifs/sideplank.gif'},
        {'title': 'Legs Up the Wall', 'gif': 'assets/gifs/LegRaises.gif'},
      ],
    },
  ];

  @override
  void initState() {
    super.initState();
    // 4 seconds inhale, 4 seconds exhale
    _breathController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);

    _breathAnimation = Tween<double>(begin: 0.8, end: 1.5).animate(
      CurvedAnimation(parent: _breathController, curve: Curves.easeInOutSine),
    );
  }

  @override
  void dispose() {
    _breathController.dispose();
    super.dispose();
  }

  void _startFlowWorkout(Map<String, dynamic> flow) {
    List<Map<String, String>> drills = List<Map<String, String>>.from(flow['drills'] as List);
    Get.to(() => StartExercise(customExercises: drills));
  }

  @override
  Widget build(BuildContext context) {
    final holdOptions = [30, 60];

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: CustomScrollView(
        slivers: [
          // Hero AppBar
          SliverAppBar(
            expandedHeight: 220.0,
            pinned: true,
            backgroundColor: Colors.teal.shade800,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                'Yoga & Mobility',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset('assets/images/legrolling.png', fit: BoxFit.cover),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.black.withValues(alpha: 0.4),
                          Colors.teal.shade900.withValues(alpha: 0.8),
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
                            color: Colors.tealAccent.shade700,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Text(
                            '🧘 3 SERENE FLOWS',
                            style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.black87),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Restore Balance & Flexibility',
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
                          color: Colors.teal.withValues(alpha: 0.05),
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
                            Icon(Icons.self_improvement_rounded, color: Colors.teal.shade700, size: 20),
                            const SizedBox(width: 8),
                            Text(
                              'Sanctuary Settings',
                              style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        const SizedBox(height: 14),

                        // Pose Hold Switcher
                        Text('Pose Hold Duration:', style: GoogleFonts.poppins(fontSize: 13, color: Colors.grey[700], fontWeight: FontWeight.w600)),
                        const SizedBox(height: 8),
                        Row(
                          children: holdOptions.map((hold) {
                            final isSelected = _poseHold == hold;
                            final label = hold == 30 ? '30s Gentle' : '60s Deep Stretch';
                            return Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: ChoiceChip(
                                label: Text(label, style: TextStyle(color: isSelected ? Colors.white : Colors.black87, fontWeight: FontWeight.bold, fontSize: 12)),
                                selected: isSelected,
                                selectedColor: Colors.teal.shade700,
                                backgroundColor: Colors.teal.shade50,
                                onSelected: (_) => setState(() => _poseHold = hold),
                              ),
                            );
                          }).toList(),
                        ),
                        const SizedBox(height: 20),

                        // Breath Pace Synchronizer (Visual Ring)
                        Text('Breath Synchronizer:', style: GoogleFonts.poppins(fontSize: 13, color: Colors.grey[700], fontWeight: FontWeight.w600)),
                        const SizedBox(height: 16),
                        Center(
                          child: AnimatedBuilder(
                            animation: _breathAnimation,
                            builder: (context, child) {
                              // Calculate text based on animation status
                              String breathText = _breathController.status == AnimationStatus.forward ? 'Inhale' : 'Exhale';

                              return Stack(
                                alignment: Alignment.center,
                                children: [
                                  // Outer expanding ring
                                  Container(
                                    width: 100 * _breathAnimation.value,
                                    height: 100 * _breathAnimation.value,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.tealAccent.withValues(alpha: 0.2),
                                    ),
                                  ),
                                  // Inner expanding ring
                                  Container(
                                    width: 70 * _breathAnimation.value,
                                    height: 70 * _breathAnimation.value,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.tealAccent.withValues(alpha: 0.4),
                                    ),
                                  ),
                                  // Core text
                                  Text(
                                    breathText,
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.teal.shade800,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 10),
                        Center(
                          child: Text(
                            'Follow the rhythm to relax your nervous system',
                            style: TextStyle(fontSize: 10, color: Colors.grey[500]),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Studios Section Title
                  Text(
                    'Choose Your Flow',
                    style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
                  ),
                  const SizedBox(height: 12),

                  // 3 Flow Cards
                  ..._flows.map((flow) {
                    final color = flow['color'] as Color;

                    return Container(
                      margin: const EdgeInsets.only(bottom: 16),
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
                          color: Colors.white,
                          child: InkWell(
                            onTap: () => _startFlowWorkout(flow),
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
                                          flow['image'] as String,
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
                                              flow['title'] as String,
                                              style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold),
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              flow['subtitle'] as String,
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
                                                    '⏱️ $_poseHold Sec Holds',
                                                    style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: color),
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
                                          children: (flow['focus'] as List<String>).map((m) {
                                            return Container(
                                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                              decoration: BoxDecoration(
                                                color: Colors.teal.shade50,
                                                borderRadius: BorderRadius.circular(6),
                                              ),
                                              child: Text(
                                                m,
                                                style: TextStyle(fontSize: 10, color: Colors.teal.shade800, fontWeight: FontWeight.w500),
                                              ),
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                      ElevatedButton.icon(
                                        onPressed: () => _startFlowWorkout(flow),
                                        icon: const Icon(Icons.play_arrow_rounded, size: 18),
                                        label: const Text('FLOW'),
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
