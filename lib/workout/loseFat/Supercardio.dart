import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Supercardio extends StatelessWidget{
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
                    'assets/images/up.png',
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
                    "Super Cardio Burner",
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

            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _miniInfoCard(
                      'Strength', Icons.signal_cellular_alt, Colors.deepPurple),
                  _miniInfoCard(
                      'Cardio', Icons.directions_run, Colors.redAccent),
                  _miniInfoCard('10 Weeks', Icons.calendar_today, Colors.teal),
                ],
              ),
            ),
            const SizedBox(height: 20),

            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "10-Week Super Cardio Burner Plan",
                    style: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    "High-energy cardio workouts to maximize fat burn, boost endurance, and improve heart health.",
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: Colors.grey[700],
                    ),
                  ),
                  const SizedBox(height: 24),
                  _buildWeekCard(1, [
                    "20-min Brisk Walk",
                    "15-min HIIT (Low Impact)",
                    "Jump Rope (5 min x 2)",
                    "Core: Plank & Crunches",
                    "Rest or Stretch"
                  ]),
                  _buildWeekCard(2, [
                    "25-min Jog/Walk",
                    "20-min Bodyweight HIIT",
                    "Jump Rope (5 min x 3)",
                    "Lower Body Cardio",
                    "Active Recovery"
                  ]),
                  _buildWeekCard(3, [
                    "30-min Steady Jog",
                    "25-min HIIT",
                    "Tabata (4x4 min)",
                    "8-min Core Finisher",
                    "Walk + Stretch"
                  ]),
                  _buildWeekCard(4, [
                    "35-min Jog",
                    "30-min Full Body HIIT",
                    "10-min Jump Rope",
                    "EMOM Workout",
                    "Foam Rolling"
                  ]),
                  _buildWeekCard(5, [
                    "40-min Cardio Dance",
                    "25-min Hill Sprints",
                    "Plyo HIIT",
                    "Total Body Sweat",
                    "Mobility Work"
                  ]),
                  _buildWeekCard(6, [
                    "45-min Steady Cardio",
                    "30-min Intense HIIT",
                    "Jump Rope Tabata",
                    "Core + Glute Burn",
                    "Rest Walk"
                  ]),
                  _buildWeekCard(7, [
                    "50-min Cardio Kickboxing",
                    "20-min Sprints",
                    "Resistance HIIT",
                    "15-min Core Burn",
                    "Yoga Recovery"
                  ]),
                  _buildWeekCard(8, [
                    "60-min Mixed Cardio",
                    "35-min Bodyweight Blast",
                    "10-min AMRAP",
                    "Cardio + Core Hybrid",
                    "Long Walk"
                  ]),
                  _buildWeekCard(9, [
                    "30-min Fast Run",
                    "Tabata HIIT (5 rounds)",
                    "Jump Rope + Core",
                    "Ladder Workout",
                    "Deep Stretch"
                  ]),
                  _buildWeekCard(10, [
                    "75-min Cardio Challenge",
                    "30-min HIIT + Abs",
                    "EMOM & AMRAP Combo",
                    "Reflection & Goal Setting",
                    "Celebration Walk"
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
Widget _miniInfoCard(String title, IconData icon, Color color) {
  return Expanded(
    child: Container(
      margin: const EdgeInsets.symmetric(horizontal: 6),
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 30),
          const SizedBox(height: 8),
          Text(
            title,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    ),
  );
}

