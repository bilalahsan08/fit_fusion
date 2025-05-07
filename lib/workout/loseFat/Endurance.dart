import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Endurance extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F4F4),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(24),
                    bottomRight: Radius.circular(24),
                  ),
                  child: Image.asset(
                    'assets/images/tabata.png',
                    fit: BoxFit.cover,
                    height: 250,
                    width: double.infinity,
                  ),
                ),
                Positioned.fill(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                    child: Container(
                      color: Colors.black.withOpacity(0.2),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 20,
                  left: 20,
                  child: Text(
                    "Endurance Builder Plan",
                    style: GoogleFonts.poppins(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          blurRadius: 10.0,
                          color: Colors.black.withOpacity(0.5),
                          offset: const Offset(3, 3),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 40,
                  left: 10,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "6-Week Endurance Builder Plan",
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    "Progressive plan combining cardio, strength, and recovery to build stamina and endurance.",
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: Colors.grey[700],
                    ),
                  ),
                  const SizedBox(height: 24),
                  _buildWeekCard(1, ["Run/Walk Intervals (30 min)", "Cross-Train (45 min)", "Active Recovery", "Steady Jog (25 min)", "Strength Training", "Long Walk (45–60 min)"]),
                  _buildWeekCard(2, ["Run/Walk Intervals (35 min)", "Cross-Train (45 min)", "Active Recovery", "Jog (30 min)", "Strength Training", "Long Walk (1 hr)"]),
                  _buildWeekCard(3, ["Run/Walk Intervals (40 min)", "Cross-Train (50 min)", "Jump Rope or Active Recovery", "Jog (35 min)", "Strength Training", "Long Run (45 min)"]),
                  _buildWeekCard(4, ["Run/Walk (45 min)", "Cross-Train (50 min)", "Yoga/Stretch", "Jog (40 min)", "Strength Training", "Hike or Long Walk (1 hr)"]),
                  _buildWeekCard(5, ["Run/Walk (45 min)", "HIIT Cross-Train (55 min)", "Recovery", "Jog (45 min)", "Strength Training", "Long Run (60 min)"]),
                  _buildWeekCard(6, ["Run/Walk (50 min)", "Cross-Train (1 hr)", "Yoga/Stretch", "Jog (50 min)", "Strength Training", "Final Endurance Test (1.5 hrs)"]),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
Widget _buildWeekCard(int week, List<String> goals) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 10),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: const [
        BoxShadow(
          color: Color(0x1A000000),
          blurRadius: 8,
          offset: Offset(0, 4),
        )
      ],
    ),
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Week $week",
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 10),
        ...goals.map(
              (goal) => Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Row(
              children: [
                const Icon(Icons.check_circle, color: Colors.green, size: 20),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    goal,
                    style: GoogleFonts.poppins(fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}