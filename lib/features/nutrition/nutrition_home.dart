import 'package:fit_fusion/core/routes/app_routes.dart';
import 'package:fit_fusion/features/nutrition/pages/special_diet_plans_screen.dart';
import 'package:get/get.dart';
import 'package:fit_fusion/features/nutrition/foodcal.dart';
import 'package:fit_fusion/features/nutrition/proteincal.dart';
import 'package:fit_fusion/features/nutrition/stepcount.dart';
import 'package:fit_fusion/features/nutrition/tips.dart';
import 'package:fit_fusion/features/nutrition/doctor.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import 'package:fit_fusion/core/controllers/user_stats_controller.dart';
import '../profile/patient_home_page.dart';

class NutritionHomePage extends StatelessWidget {
  const NutritionHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const NutritionHome(),
    );
  }
}

class NutritionHome extends StatelessWidget {
  const NutritionHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          'Nutrition Hub',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black87),
      ),
      body: Container(
        color: Colors.grey[50], // Soft background
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. Top Hero Widget: Macro Dashboard
                _buildMacroDashboard(),
                
                const SizedBox(height: 24),
                
                // 2. Bento Grid Architecture
                const Text(
                  'Daily Studios',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 12),
                
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: _BentoTallCard(
                        title: 'Diet Plans',
                        subtitle: 'Meals & Prep',
                        image: 'assets/images/cutlery.png',
                        color1: Colors.green.shade700,
                        onPressed: () => Get.toNamed(AppRoutes.dietPlan),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        children: [
                          _BentoSmallCard(
                            title: 'Food Cal',
                            subtitle: 'Lookup',
                            icon: Icons.search_rounded,
                            color1: Colors.blue.shade700,
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => Foodcal()),
                              );
                            },
                          ),
                          const SizedBox(height: 12),
                          _BentoSmallCard(
                            title: 'Protein',
                            subtitle: 'Calculator',
                            icon: Icons.calculate_rounded,
                            color1: Colors.orange.shade700,
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const ProteinCalScreen()),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 12),
                
                _BentoWideCard(
                  title: 'Dietitian Consultation',
                  subtitle: 'Book an expert appointment',
                  icon: Icons.medical_services_rounded,
                  color1: Colors.indigo.shade600,
                  onPressed: () => Get.to(() => const DoctorScreen()),
                ),
                
                const SizedBox(height: 24),
                
                // 3. Quick Utilities & Special Diets
                const Text(
                  'Quick Actions',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 12),
                
                _buildUtilityListTile(
                  title: 'Step Tracker',
                  subtitle: 'Daily pedometer goal',
                  icon: Icons.directions_walk_rounded,
                  color: Colors.teal,
                  onTap: () {
                    Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const StepCountScreen()),
                    );
                  },
                ),
                const SizedBox(height: 12),
                _buildUtilityListTile(
                  title: 'Specialized Diet Plans',
                  subtitle: 'Keto, Fasting, Vegan, etc.',
                  icon: Icons.restaurant_menu_rounded,
                  color: Colors.purple,
                  onTap: () {
                     Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const SpecialDietPlansScreen()),
                    );
                  },
                ),
                const SizedBox(height: 12),
                _buildUtilityListTile(
                  title: 'Daily Tips',
                  subtitle: 'Healthy habits & advice',
                  icon: Icons.lightbulb_outline_rounded,
                  color: Colors.amber.shade700,
                  onTap: () {
                    Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const TipsScreen()),
                    );
                  },
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMacroDashboard() {
    return Obx(() {
      final controller = Get.find<UserStatsController>();
      final lastTdee = controller.lastTdee.value;
      
      int proteinG = 0;
      int carbsG = 0;
      int fatsG = 0;

      if (lastTdee != null) {
        // 30% Protein (4 kcal/g), 40% Carbs (4 kcal/g), 30% Fat (9 kcal/g)
        proteinG = ((lastTdee * 0.3) / 4).round();
        carbsG = ((lastTdee * 0.4) / 4).round();
        fatsG = ((lastTdee * 0.3) / 9).round();
      }

      return Container(
        padding: const EdgeInsets.all(20),
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
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Daily Goal', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)),
                    Text(lastTdee != null ? '$lastTdee kcal' : '-- kcal', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  ],
                ),
                if (lastTdee != null)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.blue.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.local_fire_department_rounded, size: 16, color: Colors.blue.shade700),
                        const SizedBox(width: 4),
                        Text('On Track', style: TextStyle(color: Colors.blue.shade700, fontWeight: FontWeight.bold, fontSize: 12)),
                      ],
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildMacroPill('Protein', lastTdee != null ? '${proteinG}g' : '--g', Colors.red.shade400),
                _buildMacroPill('Carbs', lastTdee != null ? '${carbsG}g' : '--g', Colors.orange.shade400),
                _buildMacroPill('Fats', lastTdee != null ? '${fatsG}g' : '--g', Colors.blue.shade400),
              ],
            ),
          ],
        ),
      );
    });
  }

  Widget _buildMacroPill(String label, String value, Color color) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              height: 50,
              width: 50,
              child: CircularProgressIndicator(
                value: 0.6, // Example static progress
                strokeWidth: 4,
                backgroundColor: color.withValues(alpha: 0.2),
                valueColor: AlwaysStoppedAnimation<Color>(color),
              ),
            ),
            Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
          ],
        ),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _buildUtilityListTile({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: ListTile(
          onTap: onTap,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          leading: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          subtitle: Text(subtitle, style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
          trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 14, color: Colors.grey),
        ),
      ),
    );
  }
}


class _BentoTallCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String image;
  final Color color1;
  final VoidCallback onPressed;

  const _BentoTallCard({
    required this.title,
    required this.subtitle,
    required this.image,
    required this.color1,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 255, 
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
          color: Colors.transparent,
          child: InkWell(
            onTap: onPressed,
            child: Stack(
              children: [
                Positioned(
                  right: -30,
                  bottom: -20,
                  child: Opacity(
                    opacity: 0.8,
                    child: Image.asset(
                      image,
                      height: 180,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: Colors.black87),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: TextStyle(fontSize: 13, color: Colors.grey.shade600, fontWeight: FontWeight.w600),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _BentoSmallCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color1;
  final VoidCallback onPressed;

  const _BentoSmallCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color1,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      width: double.infinity,
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
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(24),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: color1.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(icon, color: color1, size: 20),
                    ),
                    const Icon(Icons.arrow_outward_rounded, color: Colors.black26, size: 18),
                  ],
                ),
                const Spacer(),
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black87),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: TextStyle(fontSize: 11, color: Colors.grey.shade600, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _BentoWideCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color1;
  final VoidCallback onPressed;

  const _BentoWideCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color1,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
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
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(24),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: color1.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(icon, color: color1, size: 24),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black87),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: TextStyle(fontSize: 12, color: Colors.grey.shade600, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.arrow_forward_rounded, color: Colors.black26, size: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
