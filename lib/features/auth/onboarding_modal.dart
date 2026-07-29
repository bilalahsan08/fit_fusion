import 'package:fit_fusion/core/controllers/profile_controller.dart';
import 'package:fit_fusion/core/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnboardingModal extends StatefulWidget {
  final String userName;

  const OnboardingModal({super.key, required this.userName});

  static void show(BuildContext context, String userName) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: false,
      enableDrag: false,
      backgroundColor: Colors.transparent,
      builder: (ctx) => OnboardingModal(userName: userName),
    );
  }

  @override
  State<OnboardingModal> createState() => _OnboardingModalState();
}

class _OnboardingModalState extends State<OnboardingModal> {
  final ProfileController _profileCtrl = Get.put(ProfileController());

  int _currentStep = 0;
  String _selectedGender = 'Male';
  double _height = 175.0;
  double _weight = 70.0;
  String _selectedGoal = 'Lose weight';
  bool _isSaving = false;

  final List<String> _goals = [
    'Lose weight',
    'Build muscle',
    'Stay fit',
    'Improve endurance',
  ];

  Future<void> _finishSetup() async {
    setState(() => _isSaving = true);

    await _profileCtrl.saveProfile(
      newName: widget.userName.isNotEmpty ? widget.userName : 'User',
      newGender: _selectedGender,
      newHeight: _height,
      newWeight: _weight,
      newGoal: _selectedGoal,
      newBirthday: '01 Jan 1995',
    );

    if (mounted) {
      Navigator.pop(context);
      Get.offAllNamed(AppRoutes.navbar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header Progress Pill
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Step ${_currentStep + 1} of 2',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                  ),
                ),
                Row(
                  children: [
                    Container(
                      width: 28,
                      height: 6,
                      decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                    const SizedBox(width: 6),
                    Container(
                      width: 28,
                      height: 6,
                      decoration: BoxDecoration(
                        color: _currentStep == 1 ? Colors.blueAccent : Colors.grey[300],
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),

            if (_currentStep == 0) _buildStepOne() else _buildStepTwo(),

            const SizedBox(height: 28),

            // Action Buttons
            Row(
              children: [
                if (_currentStep == 1)
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => setState(() => _currentStep = 0),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: const Text('Back'),
                    ),
                  ),
                if (_currentStep == 1) const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _isSaving
                        ? null
                        : () {
                            if (_currentStep == 0) {
                              setState(() => _currentStep = 1);
                            } else {
                              _finishSetup();
                            }
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: _isSaving
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                        : Text(
                            _currentStep == 0 ? 'Next Step' : 'Complete Setup',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStepOne() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Welcome, ${widget.userName.isNotEmpty ? widget.userName : 'Athlete'}! 👋',
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'Tell us a bit about yourself to personalize your fitness plan.',
          style: TextStyle(color: Colors.grey[600]),
        ),
        const SizedBox(height: 24),

        // Gender Selector
        const Text(
          'Gender',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 10),
        Row(
          children: ['Male', 'Female', 'Other'].map((g) {
            final isSelected = _selectedGender == g;
            return Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: ChoiceChip(
                  label: Center(child: Text(g)),
                  selected: isSelected,
                  selectedColor: Colors.blueAccent,
                  labelStyle: TextStyle(
                    color: isSelected ? Colors.white : Colors.black87,
                    fontWeight: FontWeight.bold,
                  ),
                  onSelected: (val) {
                    if (val) setState(() => _selectedGender = g);
                  },
                ),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 24),

        // Fitness Goal Selector
        const Text(
          'Primary Fitness Goal',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 10),
        Column(
          children: _goals.map((g) {
            final isSelected = _selectedGoal == g;
            return Container(
              margin: const EdgeInsets.only(bottom: 8),
              decoration: BoxDecoration(
                color: isSelected ? Colors.blueAccent.withValues(alpha: 0.08) : Colors.grey[100],
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: isSelected ? Colors.blueAccent : Colors.transparent,
                  width: 1.5,
                ),
              ),
              child: RadioListTile<String>(
                title: Text(
                  g,
                  style: TextStyle(
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    color: isSelected ? Colors.blueAccent : Colors.black87,
                  ),
                ),
                value: g,
                groupValue: _selectedGoal,
                onChanged: (val) {
                  if (val != null) setState(() => _selectedGoal = val);
                },
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildStepTwo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Your Body Metrics 📏',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'We use these to calculate your BMI and daily caloric needs.',
          style: TextStyle(color: Colors.grey[600]),
        ),
        const SizedBox(height: 24),

        // Height Slider
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Height',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  Text(
                    '${_height.round()} cm',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.blueAccent,
                    ),
                  ),
                ],
              ),
              Slider(
                value: _height,
                min: 120,
                max: 220,
                divisions: 100,
                activeColor: Colors.blueAccent,
                onChanged: (val) => setState(() => _height = val),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // Weight Slider
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Current Weight',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  Text(
                    '${_weight.toStringAsFixed(1)} kg',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.blueAccent,
                    ),
                  ),
                ],
              ),
              Slider(
                value: _weight,
                min: 30,
                max: 180,
                divisions: 300,
                activeColor: Colors.blueAccent,
                onChanged: (val) => setState(() => _weight = val),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
