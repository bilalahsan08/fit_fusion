import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class leantone extends StatelessWidget{
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
                    'assets/images/upperbody.png',
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
                    "Lean & Tone Plan",
                    style: GoogleFonts.poppins(
                      fontSize: 33,
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
                    "5-Week Lean and Tone Plan",
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    "Progressive weekly plan focused on toning muscles, burning fat, and developing lean strength.",
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: Colors.grey[700],
                    ),
                  ),
                  const SizedBox(height: 24),
                  _buildWeekCard(1, [
                    "Full Body Strength (30 min)",
                    "Low-Impact Cardio (20 min)",
                    "Meal Prep Lean Proteins",
                    "Stretch/Yoga (15 min)",
                    "Hydrate (2.5L Daily)",
                  ]),
                  _buildWeekCard(2, [
                    "Upper Body Tone (35 min)",
                    "Power Walk or Jog (25 min)",
                    "Track Protein Intake",
                    "Lower Body Sculpt (30 min)",
                    "Meditation & Sleep (7-8h)",
                  ]),
                  _buildWeekCard(3, [
                    "HIIT & Core (30 min)",
                    "Glutes & Hamstrings Burn",
                    "Green Smoothie Breakfast",
                    "Mobility & Stretch (20 min)",
                    "Limit Sugar <20g/day",
                  ]),
                  _buildWeekCard(4, [
                    "Plyometrics + Abs (30 min)",
                    "Pilates Flow (30 min)",
                    "Lean Lunch Planning",
                    "Strength Circuits (Upper+Lower)",
                    "Tech-free Evening Routine",
                  ]),
                  _buildWeekCard(5, [
                    "Full Body Finisher Workout",
                    "Endurance Cardio (45 min)",
                    "Meal Prep for Week Ahead",
                    "Deep Stretch & Recovery",
                    "Goal Reflection & Journal",
                  ]),
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