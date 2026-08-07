import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:fit_fusion/core/controllers/user_stats_controller.dart';
class BmrCalScreen extends StatefulWidget {
  const BmrCalScreen({super.key});

  @override
  State<BmrCalScreen> createState() => _BmrCalScreenState();
}

class _BmrCalScreenState extends State<BmrCalScreen> {
  bool _isMale = true;
  bool _isMetric = true;
  double _activityMultiplier = 1.2;

  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heightCmController = TextEditingController();
  final TextEditingController _heightFtController = TextEditingController();
  final TextEditingController _heightInController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();

  double? _bmrResult;
  double? _tdeeResult;

  final List<Map<String, dynamic>> _activityLevels = [
    {"label": "Sedentary", "value": 1.2, "desc": "Little or no exercise"},
    {"label": "Light", "value": 1.375, "desc": "1-3 days/week"},
    {"label": "Moderate", "value": 1.55, "desc": "3-5 days/week"},
    {"label": "Very Active", "value": 1.725, "desc": "6-7 days/week"},
    {"label": "Extra Active", "value": 1.9, "desc": "Physical job or 2x training"},
  ];

  @override
  void dispose() {
    _weightController.dispose();
    _heightCmController.dispose();
    _heightFtController.dispose();
    _heightInController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  void _calculateBMR() {
    FocusScope.of(context).unfocus();

    double weight = double.tryParse(_weightController.text) ?? 0.0;
    int age = int.tryParse(_ageController.text) ?? 0;
    double heightCm = 0.0;

    if (weight <= 0 || age <= 0) {
      _showError("Please enter valid positive numbers for all fields.");
      return;
    }

    if (_isMetric) {
      heightCm = double.tryParse(_heightCmController.text) ?? 0.0;
      if (heightCm <= 0) {
        _showError("Please enter a valid height.");
        return;
      }
    } else {
      double feet = double.tryParse(_heightFtController.text) ?? 0.0;
      double inches = double.tryParse(_heightInController.text) ?? 0.0;
      if (feet <= 0) {
        _showError("Please enter a valid height.");
        return;
      }
      heightCm = ((feet * 12) + inches) * 2.54;
      weight = weight * 0.453592; // Convert lbs to kg
    }

    double bmr;
    
    // Mifflin-St Jeor Equation (uses kg and cm)
    if (_isMale) {
      bmr = (10 * weight) + (6.25 * heightCm) - (5 * age) + 5;
    } else {
      bmr = (10 * weight) + (6.25 * heightCm) - (5 * age) - 161;
    }

    double tdee = bmr * _activityMultiplier;

    setState(() {
      _bmrResult = bmr;
      _tdeeResult = tdee;
    });

    Get.find<UserStatsController>().saveTdee(tdee.round());
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.redAccent),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'BMR & TDEE Calories',
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.black87),
        ),
        iconTheme: const IconThemeData(color: Colors.black87),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Top Toggles
              Center(
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(30)),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _buildGenderToggleButton("Male", true, Icons.male_rounded),
                          _buildGenderToggleButton("Female", false, Icons.female_rounded),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(30)),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _buildUnitToggleButton("Metric (kg/cm)", true),
                          _buildUnitToggleButton("Imperial (lbs/ft)", false),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // Inputs Form
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(28),
                  boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.03), blurRadius: 10, offset: const Offset(0, 4))],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Your Details", style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 20),
                    
                    Row(
                      children: [
                        Expanded(child: _buildInputField(controller: _weightController, label: _isMetric ? "Weight (kg)" : "Weight (lbs)", icon: Icons.scale_rounded)),
                      ],
                    ),
                    const SizedBox(height: 16),
                    if (_isMetric)
                      _buildInputField(controller: _heightCmController, label: "Height (cm)", icon: Icons.height_rounded)
                    else
                      Row(
                        children: [
                          Expanded(child: _buildInputField(controller: _heightFtController, label: "Feet", icon: Icons.height_rounded)),
                          const SizedBox(width: 16),
                          Expanded(child: _buildInputField(controller: _heightInController, label: "Inches", icon: Icons.straighten_rounded)),
                        ],
                      ),
                    const SizedBox(height: 16),
                    _buildInputField(controller: _ageController, label: "Age (years)", icon: Icons.cake_rounded),
                    
                    const SizedBox(height: 24),
                    Text("Activity Level", style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 12),
                    
                    // Activity Dropdown Area
                    GestureDetector(
                      onTap: _showActivitySelector,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade50,
                          border: Border.all(color: Colors.grey.shade200),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.directions_run_rounded, color: Colors.orange.shade500),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _activityLevels.firstWhere((e) => e["value"] == _activityMultiplier)["label"],
                                    style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 14),
                                  ),
                                  Text(
                                    _activityLevels.firstWhere((e) => e["value"] == _activityMultiplier)["desc"],
                                    style: TextStyle(color: Colors.grey.shade500, fontSize: 11),
                                  ),
                                ],
                              ),
                            ),
                            Icon(Icons.arrow_drop_down_circle_rounded, color: Colors.orange.shade500),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: _calculateBMR,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange.shade600,
                        foregroundColor: Colors.white,
                        minimumSize: const Size.fromHeight(56),
                        elevation: 0,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      ),
                      child: Text("Calculate Calories", style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600)),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 32),

              // Results Section
              if (_tdeeResult != null && _bmrResult != null) ...[
                Text("Your Caloric Needs", style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),
                
                // TDEE Maintenance Card
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.orange.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(28),
                    border: Border.all(color: Colors.orange.withValues(alpha: 0.3), width: 2),
                  ),
                  child: Column(
                    children: [
                      Text("DAILY MAINTENANCE (TDEE)", style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.orange.shade800, letterSpacing: 1.0)),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(_tdeeResult!.toStringAsFixed(0), style: GoogleFonts.poppins(fontSize: 56, fontWeight: FontWeight.bold, color: Colors.orange.shade700, height: 1)),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0, left: 8),
                            child: Text("kcal", style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.orange.shade700)),
                          )
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text("Calories to maintain your current weight.", style: TextStyle(color: Colors.orange.shade800, fontSize: 12, fontWeight: FontWeight.w500)),
                    ],
                  ),
                ),
                
                const SizedBox(height: 16),
                
                // Goals Breakdown
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.03), blurRadius: 10, offset: const Offset(0, 4))],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(color: Colors.blue.shade50, shape: BoxShape.circle),
                              child: Icon(Icons.trending_down_rounded, color: Colors.blue.shade600, size: 20),
                            ),
                            const SizedBox(height: 12),
                            Text("Weight Loss", style: TextStyle(color: Colors.grey.shade600, fontSize: 13, fontWeight: FontWeight.w500)),
                            const SizedBox(height: 4),
                            Text("${(_tdeeResult! - 500).toStringAsFixed(0)} kcal", style: GoogleFonts.poppins(color: Colors.black87, fontSize: 18, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.03), blurRadius: 10, offset: const Offset(0, 4))],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(color: Colors.green.shade50, shape: BoxShape.circle),
                              child: Icon(Icons.trending_up_rounded, color: Colors.green.shade600, size: 20),
                            ),
                            const SizedBox(height: 12),
                            Text("Muscle Gain", style: TextStyle(color: Colors.grey.shade600, fontSize: 13, fontWeight: FontWeight.w500)),
                            const SizedBox(height: 4),
                            Text("${(_tdeeResult! + 500).toStringAsFixed(0)} kcal", style: GoogleFonts.poppins(color: Colors.black87, fontSize: 18, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 16),
                
                // BMR Rest Card
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.03), blurRadius: 10, offset: const Offset(0, 4))],
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(color: Colors.grey.shade100, shape: BoxShape.circle),
                        child: Icon(Icons.bed_rounded, color: Colors.grey.shade600),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Basal Metabolic Rate (BMR)", style: TextStyle(color: Colors.grey.shade600, fontSize: 13, fontWeight: FontWeight.w500)),
                            const SizedBox(height: 4),
                            Text("${_bmrResult!.toStringAsFixed(0)} kcal / day", style: GoogleFonts.poppins(color: Colors.black87, fontSize: 16, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 2),
                            Text("Calories burned at complete rest.", style: TextStyle(color: Colors.grey.shade400, fontSize: 11)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

              ],
              
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGenderToggleButton(String label, bool isMaleChoice, IconData icon) {
    final bool isSelected = _isMale == isMaleChoice;
    return GestureDetector(
      onTap: () {
        setState(() {
          _isMale = isMaleChoice;
          _bmrResult = null;
          _tdeeResult = null;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? Colors.orange.shade500 : Colors.transparent,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 18, color: isSelected ? Colors.white : Colors.grey.shade600),
            const SizedBox(width: 8),
            Text(
              label,
              style: GoogleFonts.poppins(
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                fontSize: 13,
                color: isSelected ? Colors.white : Colors.grey.shade600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUnitToggleButton(String label, bool isMetricChoice) {
    final bool isSelected = _isMetric == isMetricChoice;
    return GestureDetector(
      onTap: () {
        setState(() {
          _isMetric = isMetricChoice;
          _weightController.clear();
          _heightCmController.clear();
          _heightFtController.clear();
          _heightInController.clear();
          _bmrResult = null;
          _tdeeResult = null;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? Colors.orange.shade500 : Colors.transparent,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Text(
          label,
          style: GoogleFonts.poppins(
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
            fontSize: 13,
            color: isSelected ? Colors.white : Colors.grey.shade600,
          ),
        ),
      ),
    );
  }

  Widget _buildInputField({required TextEditingController controller, required String label, required IconData icon}) {
    return TextField(
      controller: controller,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.grey.shade600, fontSize: 13),
        prefixIcon: Icon(icon, color: Colors.orange.shade500),
        filled: true,
        fillColor: Colors.grey.shade50,
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide(color: Colors.grey.shade200)),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide(color: Colors.orange.shade400, width: 2)),
      ),
    );
  }

  void _showActivitySelector() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.6,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
          ),
          child: Column(
            children: [
              const SizedBox(height: 12),
              Container(width: 40, height: 5, decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(10))),
              const SizedBox(height: 24),
              Text("Select Activity Level", style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87)),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: _activityLevels.length,
                  itemBuilder: (context, index) {
                    final level = _activityLevels[index];
                    final isSelected = _activityMultiplier == level["value"];
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _activityMultiplier = level["value"];
                          _bmrResult = null;
                        });
                        Navigator.pop(context);
                      },
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: isSelected ? Colors.orange.shade50 : Colors.grey.shade50,
                          border: Border.all(color: isSelected ? Colors.orange.shade400 : Colors.grey.shade200, width: isSelected ? 2 : 1),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(color: isSelected ? Colors.orange.shade100 : Colors.grey.shade200, shape: BoxShape.circle),
                              child: Icon(Icons.directions_run_rounded, color: isSelected ? Colors.orange.shade700 : Colors.grey.shade600, size: 20),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(level["label"], style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 14, color: isSelected ? Colors.orange.shade800 : Colors.black87)),
                                  Text(level["desc"], style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
                                ],
                              ),
                            ),
                            if (isSelected) Icon(Icons.check_circle_rounded, color: Colors.orange.shade500),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
