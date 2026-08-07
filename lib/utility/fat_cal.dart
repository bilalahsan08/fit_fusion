import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Fatcal extends StatefulWidget {
  const Fatcal({super.key});

  @override
  State<Fatcal> createState() => _FatCalScreenState();
}

class _FatCalScreenState extends State<Fatcal> {
  bool _isMale = true;
  bool _isMetric = true;

  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heightCmController = TextEditingController();
  final TextEditingController _heightFtController = TextEditingController();
  final TextEditingController _heightInController = TextEditingController();
  final TextEditingController _neckController = TextEditingController();
  final TextEditingController _waistController = TextEditingController();
  final TextEditingController _hipController = TextEditingController();

  double? _bodyFatPercentage;
  double? _fatMassKg;
  double? _leanMassKg;
  String _fatCategory = "";
  Color _fatColor = Colors.grey;

  @override
  void dispose() {
    _weightController.dispose();
    _heightCmController.dispose();
    _heightFtController.dispose();
    _heightInController.dispose();
    _neckController.dispose();
    _waistController.dispose();
    _hipController.dispose();
    super.dispose();
  }

  void _calculateBodyFat() {
    FocusScope.of(context).unfocus();

    double weight = double.tryParse(_weightController.text) ?? 0.0;
    double neck = double.tryParse(_neckController.text) ?? 0.0;
    double waist = double.tryParse(_waistController.text) ?? 0.0;
    double hip = double.tryParse(_hipController.text) ?? 0.0;
    double height = 0.0;

    if (weight <= 0 || neck <= 0 || waist <= 0) {
      _showError("Please enter valid positive numbers for all required fields.");
      return;
    }
    
    if (!_isMale && hip <= 0) {
      _showError("Hip circumference is required for females.");
      return;
    }

    if (_isMetric) {
      height = double.tryParse(_heightCmController.text) ?? 0.0;
      if (height <= 0) {
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
      height = ((feet * 12) + inches) * 2.54;
      weight = weight * 0.453592;
      neck = neck * 2.54;
      waist = waist * 2.54;
      hip = hip * 2.54;
    }

    double bodyFat;
    
    // US Navy Body Fat Formula
    if (_isMale) {
      bodyFat = 495 / (1.0324 - 0.19077 * (log(waist - neck) / ln10) + 0.15456 * (log(height) / ln10)) - 450;
    } else {
      bodyFat = 495 / (1.29579 - 0.35004 * (log(waist + hip - neck) / ln10) + 0.22100 * (log(height) / ln10)) - 450;
    }

    // Clamp value
    if (bodyFat < 2.0) bodyFat = 2.0;
    if (bodyFat > 60.0) bodyFat = 60.0;

    double fatMass = weight * (bodyFat / 100);
    double leanMass = weight - fatMass;

    // Categories (ACE ACE Chart)
    String category;
    Color color;

    if (_isMale) {
      if (bodyFat < 6) { category = "Essential Fat"; color = Colors.blue; }
      else if (bodyFat <= 13) { category = "Athletes"; color = Colors.teal; }
      else if (bodyFat <= 17) { category = "Fitness"; color = Colors.green; }
      else if (bodyFat <= 24) { category = "Average"; color = Colors.orange; }
      else { category = "Obese"; color = Colors.red; }
    } else {
      if (bodyFat < 14) { category = "Essential Fat"; color = Colors.blue; }
      else if (bodyFat <= 20) { category = "Athletes"; color = Colors.teal; }
      else if (bodyFat <= 24) { category = "Fitness"; color = Colors.green; }
      else if (bodyFat <= 31) { category = "Average"; color = Colors.orange; }
      else { category = "Obese"; color = Colors.red; }
    }

    setState(() {
      _bodyFatPercentage = bodyFat;
      _fatMassKg = fatMass;
      _leanMassKg = leanMass;
      _fatCategory = category;
      _fatColor = color;
    });
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
          'Body Fat Studio',
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
              // Toggles
              Center(
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(30),
                      ),
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
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _buildUnitToggleButton("Metric (kg/cm)", true),
                          _buildUnitToggleButton("Imperial (lbs/in)", false),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // Form
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(28),
                  boxShadow: [
                    BoxShadow(color: Colors.black.withValues(alpha: 0.03), blurRadius: 10, offset: const Offset(0, 4)),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Measurements", style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 20),
                    
                    Row(
                      children: [
                        Expanded(
                          child: _buildInputField(controller: _weightController, label: _isMetric ? "Weight (kg)" : "Weight (lbs)", icon: Icons.scale_rounded),
                        ),
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
                    _buildInputField(controller: _neckController, label: _isMetric ? "Neck Circumference (cm)" : "Neck Circumference (in)", icon: Icons.accessibility_rounded),
                    const SizedBox(height: 16),
                    _buildInputField(controller: _waistController, label: _isMetric ? "Waist Circumference (cm)" : "Waist Circumference (in)", icon: Icons.accessibility_new_rounded),
                    
                    if (!_isMale) ...[
                      const SizedBox(height: 16),
                      _buildInputField(controller: _hipController, label: _isMetric ? "Hip Circumference (cm)" : "Hip Circumference (in)", icon: Icons.boy_rounded),
                    ],
                      
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: _calculateBodyFat,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.purple.shade600,
                        foregroundColor: Colors.white,
                        minimumSize: const Size.fromHeight(56),
                        elevation: 0,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      ),
                      child: Text("Calculate Body Fat %", style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600)),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 32),

              // Results
              if (_bodyFatPercentage != null) ...[
                Text("Your Composition", style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),
                
                // Main Result Card
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: _fatColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(28),
                    border: Border.all(color: _fatColor.withValues(alpha: 0.3), width: 2),
                  ),
                  child: Column(
                    children: [
                      Text("BODY FAT PERCENTAGE", style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600, color: _fatColor, letterSpacing: 1.5)),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(_bodyFatPercentage!.toStringAsFixed(1), style: GoogleFonts.poppins(fontSize: 56, fontWeight: FontWeight.bold, color: _fatColor, height: 1)),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0, left: 4),
                            child: Text("%", style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold, color: _fatColor)),
                          )
                        ],
                      ),
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(color: _fatColor, borderRadius: BorderRadius.circular(20)),
                        child: Text(_fatCategory.toUpperCase(), style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 16),
                
                // Lean vs Fat Mass
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
                              child: Icon(Icons.fitness_center_rounded, color: Colors.blue.shade600, size: 20),
                            ),
                            const SizedBox(height: 12),
                            Text("Lean Mass", style: TextStyle(color: Colors.grey.shade600, fontSize: 13, fontWeight: FontWeight.w500)),
                            const SizedBox(height: 4),
                            Text("${_leanMassKg!.toStringAsFixed(1)} kg", style: GoogleFonts.poppins(color: Colors.black87, fontSize: 18, fontWeight: FontWeight.bold)),
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
                              decoration: BoxDecoration(color: Colors.purple.shade50, shape: BoxShape.circle),
                              child: Icon(Icons.opacity_rounded, color: Colors.purple.shade600, size: 20),
                            ),
                            const SizedBox(height: 12),
                            Text("Fat Mass", style: TextStyle(color: Colors.grey.shade600, fontSize: 13, fontWeight: FontWeight.w500)),
                            const SizedBox(height: 4),
                            Text("${_fatMassKg!.toStringAsFixed(1)} kg", style: GoogleFonts.poppins(color: Colors.black87, fontSize: 18, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                    ),
                  ],
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
          // Clear inputs on switch to avoid confusion
          _weightController.clear();
          _heightCmController.clear();
          _heightFtController.clear();
          _heightInController.clear();
          _neckController.clear();
          _waistController.clear();
          _hipController.clear();
          _bodyFatPercentage = null;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? Colors.purple.shade600 : Colors.transparent,
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
          _neckController.clear();
          _waistController.clear();
          _hipController.clear();
          _bodyFatPercentage = null;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? Colors.purple.shade600 : Colors.transparent,
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
        prefixIcon: Icon(icon, color: Colors.purple.shade500),
        filled: true,
        fillColor: Colors.grey.shade50,
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide(color: Colors.grey.shade200)),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide(color: Colors.purple.shade400, width: 2)),
      ),
    );
  }
}
