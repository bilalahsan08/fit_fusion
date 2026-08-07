import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fit_fusion/core/routes/app_routes.dart';
import 'package:fit_fusion/core/controllers/user_stats_controller.dart';

class UtilityHome extends StatelessWidget {
  const UtilityHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Utility Studio',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            fontSize: 22,
            color: Colors.black87,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.black87),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildQuickStatsHeader(),
              const SizedBox(height: 32),
              Text(
                "Health & Body",
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 16),
              _buildBentoGrid(context, true),
              const SizedBox(height: 32),
              Text(
                "Performance & Tools",
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 16),
              _buildBentoGrid(context, false),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuickStatsHeader() {
    return Obx(() {
      final controller = Get.find<UserStatsController>();
      final lastBmi = controller.lastBmi.value;
      final lastTdee = controller.lastTdee.value;

      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.teal.shade800, Colors.teal.shade500],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(28),
          boxShadow: [
            BoxShadow(color: Colors.teal.withValues(alpha: 0.3), blurRadius: 15, offset: const Offset(0, 8)),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Your Quick Stats",
              style: GoogleFonts.poppins(color: Colors.teal.shade50, fontSize: 14, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatItem("BMI", lastBmi != null ? lastBmi.toStringAsFixed(1) : "--", "Score"),
                Container(width: 1, height: 40, color: Colors.teal.shade300.withValues(alpha: 0.5)),
                _buildStatItem("TDEE", lastTdee != null ? "$lastTdee" : "--", "kcal/day"),
              ],
            ),
          ],
        ),
      );
    });
  }

  Widget _buildStatItem(String label, String value, String unit) {
    return Column(
      children: [
        Text(value, style: GoogleFonts.poppins(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Text("$label • $unit", style: TextStyle(color: Colors.teal.shade100, fontSize: 12, fontWeight: FontWeight.w600)),
      ],
    );
  }

  Widget _buildBentoGrid(BuildContext context, bool isHealth) {
    if (isHealth) {
      return GridView.count(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 1.25, // Adjusted ratio to make cards shorter
        children: [
          _buildBentoCard(
            title: "BMI & Ideal\nWeight",
            icon: Icons.monitor_weight_rounded,
            color: Colors.teal,
            onTap: () => Get.toNamed(AppRoutes.bmiCal),
          ),
          _buildBentoCard(
            title: "Body Fat\nPercentage",
            icon: Icons.accessibility_new_rounded,
            color: Colors.purple,
            onTap: () => Get.toNamed(AppRoutes.fatCal),
          ),
          _buildBentoCard(
            title: "BMR & TDEE\nCalories",
            icon: Icons.local_fire_department_rounded,
            color: Colors.orange,
            onTap: () => Get.toNamed(AppRoutes.bmrCal),
          ),
          _buildBentoCard(
            title: "Hydration\nReminders",
            icon: Icons.water_drop_rounded,
            color: Colors.cyan,
            onTap: () => Get.toNamed(AppRoutes.hydration),
          ),
        ],
      );
    } else {
      return GridView.count(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 1.25, // Adjusted ratio to make cards shorter
        children: [
          _buildBentoCard(
            title: "1-Rep Max\nStrength",
            icon: Icons.fitness_center_rounded,
            color: Colors.indigo,
            onTap: () => Get.toNamed(AppRoutes.oneRepMax),
          ),
          _buildBentoCard(
            title: "FFMI Muscle\nIndex",
            icon: Icons.electric_bolt_rounded,
            color: Colors.blue,
            onTap: () => Get.toNamed(AppRoutes.ffmiCal),
          ),
        ],
      );
    }
  }

  Widget _buildBentoCard({
    required String title,
    required IconData icon,
    required MaterialColor color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12), // Reduced padding
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(color: Colors.black.withValues(alpha: 0.03), blurRadius: 10, offset: const Offset(0, 4)),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(10), // Reduced icon padding
              decoration: BoxDecoration(
                color: color.shade50,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color.shade600, size: 24), // Reduced icon size
            ),
            const Spacer(),
            Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 14, // Slightly smaller text
                fontWeight: FontWeight.bold,
                color: Colors.black87,
                height: 1.2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
