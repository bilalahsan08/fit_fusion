import 'package:fit_fusion/core/controllers/auth_controller.dart';
import 'package:fit_fusion/core/controllers/profile_controller.dart';
import 'package:fit_fusion/features/profile/edit_profile_screen.dart';
import 'package:fit_fusion/features/profile/patient_home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileController profileCtrl = Get.put(ProfileController());
    final AuthController authCtrl = Get.put(AuthController());

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'My Profile',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: Colors.black87,
          ),
        ),
      ),
      body: Obx(() {
        if (profileCtrl.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          children: [
            // User Header Banner Card
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blueAccent, Colors.lightBlueAccent],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blueAccent.withValues(alpha: 0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 36,
                    backgroundColor: Colors.white,
                    child: Icon(
                      profileCtrl.role.value == 'Dietitian'
                          ? Icons.medical_services_rounded
                          : Icons.person_rounded,
                      size: 40,
                      color: Colors.blueAccent,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          profileCtrl.name.value,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          profileCtrl.email.value,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white.withValues(alpha: 0.9),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.25),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            profileCtrl.role.value.toUpperCase(),
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Live Health Metrics Bar (Weight, Height, BMI)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.04),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildMetricStat(
                    label: 'Weight',
                    value: '${profileCtrl.weightKg.value.toStringAsFixed(1)} kg',
                    icon: Icons.monitor_weight_outlined,
                  ),
                  Container(height: 35, width: 1, color: Colors.grey[200]),
                  _buildMetricStat(
                    label: 'Height',
                    value: '${profileCtrl.heightCm.value.round()} cm',
                    icon: Icons.height_rounded,
                  ),
                  Container(height: 35, width: 1, color: Colors.grey[200]),
                  _buildMetricStat(
                    label: 'BMI',
                    value: profileCtrl.bmi.toStringAsFixed(1),
                    subtitle: profileCtrl.bmiCategory,
                    icon: Icons.speed_rounded,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Account Settings Section
            _buildSectionHeader('Account Settings'),
            const SizedBox(height: 10),
            _buildSettingCard(
              title: 'Edit Profile & Fitness Goals',
              subtitle: 'Update height, weight, and target goal',
              icon: Icons.edit_note_rounded,
              onTap: () => Get.to(() => const ProfileScreen()),
            ),
            const SizedBox(height: 10),
            _buildSettingCard(
              title: 'My Dietitian Appointments',
              subtitle: 'View booked appointments and consultations',
              icon: Icons.calendar_month_rounded,
              onTap: () => Get.to(() => PatientHomePage()),
            ),
            const SizedBox(height: 24),
 
            // Preferences & Support
            _buildSectionHeader('Preferences & Support'),
            const SizedBox(height: 10),
            _buildSettingCard(
              title: 'Notifications & Reminders',
              subtitle: 'Daily workout and hydration alerts',
              icon: Icons.notifications_active_outlined,
              onTap: () {
                Get.snackbar(
                  'Notifications',
                  'Daily reminder alerts are active',
                  snackPosition: SnackPosition.BOTTOM,
                );
              },
            ),
            const SizedBox(height: 10),
            _buildSettingCard(
              title: 'Rate & Feedback',
              subtitle: 'Help us improve FitFusion',
              icon: Icons.star_rate_rounded,
              onTap: () => _showFeedbackDialog(context),
            ),
            const SizedBox(height: 28),

            // Sign Out Button
            SizedBox(
              height: 52,
              child: ElevatedButton.icon(
                onPressed: () => _showLogoutConfirmation(context, authCtrl),
                icon: const Icon(Icons.logout_rounded, color: Colors.redAccent),
                label: const Text(
                  'Log Out',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.redAccent,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent.withValues(alpha: 0.1),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
          ],
        );
      }),
    );
  }

  Widget _buildMetricStat({
    required String label,
    required String value,
    String? subtitle,
    required IconData icon,
  }) {
    return Column(
      children: [
        Icon(icon, color: Colors.blueAccent, size: 22),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        Text(
          subtitle ?? label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.grey[700],
        letterSpacing: 0.5,
      ),
    );
  }

  Widget _buildSettingCard({
    required String title,
    required String subtitle,
    required IconData icon,
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
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        onTap: onTap,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.blueAccent.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: Colors.blueAccent, size: 22),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(fontSize: 12, color: Colors.grey[600]),
        ),
        trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 14, color: Colors.grey),
      ),
    );
  }

  void _showLogoutConfirmation(BuildContext context, AuthController authCtrl) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Log Out'),
        content: const Text('Are you sure you want to log out of FitFusion?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              authCtrl.logout();
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
            child: const Text('Log Out', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _showFeedbackDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('App Feedback'),
        content: const Text('Thank you for using FitFusion! Rate your experience.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              Get.snackbar(
                'Thank You!',
                'Your feedback was received',
                snackPosition: SnackPosition.BOTTOM,
              );
            },
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }
}
