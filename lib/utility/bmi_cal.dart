import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:fit_fusion/core/controllers/user_stats_controller.dart';
class Bmical extends StatefulWidget {
  const Bmical({super.key});

  @override
  State<Bmical> createState() => _BmiCalScreenState();
}

class _BmiCalScreenState extends State<Bmical> {
  bool _isMetric = true;

  final TextEditingController _weightController = TextEditingController();
  
  // Metric
  final TextEditingController _heightCmController = TextEditingController();
  
  // Imperial
  final TextEditingController _heightFtController = TextEditingController();
  final TextEditingController _heightInController = TextEditingController();

  double? _bmiResult;
  String _bmiCategory = "";
  Color _bmiColor = Colors.grey;
  String _idealWeightRange = "";

  @override
  void dispose() {
    _weightController.dispose();
    _heightCmController.dispose();
    _heightFtController.dispose();
    _heightInController.dispose();
    super.dispose();
  }

  void _calculateBMI() {
    FocusScope.of(context).unfocus();
    
    double weight = double.tryParse(_weightController.text) ?? 0.0;
    double heightMeters = 0.0;

    if (weight <= 0) {
      _showError("Please enter a valid weight.");
      return;
    }

    if (_isMetric) {
      double heightCm = double.tryParse(_heightCmController.text) ?? 0.0;
      if (heightCm <= 0) {
        _showError("Please enter a valid height.");
        return;
      }
      heightMeters = heightCm / 100;
    } else {
      double feet = double.tryParse(_heightFtController.text) ?? 0.0;
      double inches = double.tryParse(_heightInController.text) ?? 0.0;
      if (feet <= 0) {
        _showError("Please enter a valid height.");
        return;
      }
      double totalInches = (feet * 12) + inches;
      heightMeters = (totalInches * 2.54) / 100;
      
      // Convert weight from lbs to kg for internal calculation
      weight = weight * 0.453592;
    }

    double bmi = weight / (heightMeters * heightMeters);
    
    // Calculate Ideal Weight
    double minIdealKg = 18.5 * (heightMeters * heightMeters);
    double maxIdealKg = 24.9 * (heightMeters * heightMeters);
    
    if (_isMetric) {
      _idealWeightRange = "${minIdealKg.toStringAsFixed(1)} - ${maxIdealKg.toStringAsFixed(1)} kg";
    } else {
      double minIdealLbs = minIdealKg / 0.453592;
      double maxIdealLbs = maxIdealKg / 0.453592;
      _idealWeightRange = "${minIdealLbs.toStringAsFixed(1)} - ${maxIdealLbs.toStringAsFixed(1)} lbs";
    }

    String category;
    Color color;

    if (bmi < 18.5) {
      category = "Underweight";
      color = Colors.blue.shade400;
    } else if (bmi >= 18.5 && bmi <= 24.9) {
      category = "Normal Weight";
      color = Colors.teal.shade500;
    } else if (bmi >= 25 && bmi <= 29.9) {
      category = "Overweight";
      color = Colors.orange.shade500;
    } else {
      category = "Obese";
      color = Colors.red.shade500;
    }

    setState(() {
      _bmiResult = bmi;
      _bmiCategory = category;
      _bmiColor = color;
    });

    Get.find<UserStatsController>().saveBmi(bmi);
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
          'BMI & Ideal Weight',
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
              // Toggle Unit
              Center(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildToggleButton("Metric (kg/cm)", true),
                      _buildToggleButton("Imperial (lbs/ft)", false),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // Inputs
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
                    Text("Your Body Metrics", style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 20),
                    
                    _buildInputField(
                      controller: _weightController,
                      label: _isMetric ? "Weight (kg)" : "Weight (lbs)",
                      icon: Icons.scale_rounded,
                    ),
                    const SizedBox(height: 16),

                    if (_isMetric)
                      _buildInputField(
                        controller: _heightCmController,
                        label: "Height (cm)",
                        icon: Icons.height_rounded,
                      )
                    else
                      Row(
                        children: [
                          Expanded(
                            child: _buildInputField(
                              controller: _heightFtController,
                              label: "Feet",
                              icon: Icons.height_rounded,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: _buildInputField(
                              controller: _heightInController,
                              label: "Inches",
                              icon: Icons.straighten_rounded,
                            ),
                          ),
                        ],
                      ),
                      
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: _calculateBMI,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal.shade600,
                        foregroundColor: Colors.white,
                        minimumSize: const Size.fromHeight(56),
                        elevation: 0,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      ),
                      child: Text("Calculate BMI", style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600)),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 32),

              // Results
              if (_bmiResult != null) ...[
                Text("Your Results", style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),
                
                // Main Result Card
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: _bmiColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(28),
                    border: Border.all(color: _bmiColor.withValues(alpha: 0.3), width: 2),
                  ),
                  child: Column(
                    children: [
                      Text("BODY MASS INDEX", style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600, color: _bmiColor, letterSpacing: 1.5)),
                      const SizedBox(height: 8),
                      Text(_bmiResult!.toStringAsFixed(1), style: GoogleFonts.poppins(fontSize: 56, fontWeight: FontWeight.bold, color: _bmiColor, height: 1)),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: _bmiColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(_bmiCategory.toUpperCase(), style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 20),
                
                // Ideal Weight Card
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(color: Colors.black.withValues(alpha: 0.03), blurRadius: 10, offset: const Offset(0, 4)),
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(color: Colors.teal.shade50, shape: BoxShape.circle),
                        child: Icon(Icons.star_rounded, color: Colors.teal.shade600),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Healthy Weight Range", style: TextStyle(color: Colors.grey.shade600, fontSize: 13, fontWeight: FontWeight.w500)),
                            const SizedBox(height: 4),
                            Text(_idealWeightRange, style: GoogleFonts.poppins(color: Colors.black87, fontSize: 18, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // Spectrum Bar
                Container(
                  padding: const EdgeInsets.all(20),
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
                      Text("BMI Spectrum", style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 16),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Row(
                          children: [
                            Expanded(flex: 185, child: Container(height: 12, color: Colors.blue.shade400)), // <18.5
                            Expanded(flex: 64, child: Container(height: 12, color: Colors.teal.shade500)), // 18.5 - 24.9
                            Expanded(flex: 50, child: Container(height: 12, color: Colors.orange.shade500)), // 25.0 - 29.9
                            Expanded(flex: 101, child: Container(height: 12, color: Colors.red.shade500)), // 30.0+
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildLegendItem("Under", Colors.blue.shade400),
                          _buildLegendItem("Normal", Colors.teal.shade500),
                          _buildLegendItem("Over", Colors.orange.shade500),
                          _buildLegendItem("Obese", Colors.red.shade500),
                        ],
                      )
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

  Widget _buildToggleButton(String label, bool isMetricChoice) {
    final bool isSelected = _isMetric == isMetricChoice;
    return GestureDetector(
      onTap: () {
        setState(() {
          _isMetric = isMetricChoice;
          // Clear inputs on switch
          _weightController.clear();
          _heightCmController.clear();
          _heightFtController.clear();
          _heightInController.clear();
          _bmiResult = null;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? Colors.teal.shade600 : Colors.transparent,
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
        labelStyle: TextStyle(color: Colors.grey.shade600),
        prefixIcon: Icon(icon, color: Colors.teal.shade500),
        filled: true,
        fillColor: Colors.grey.shade50,
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide(color: Colors.grey.shade200)),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide(color: Colors.teal.shade400, width: 2)),
      ),
    );
  }

  Widget _buildLegendItem(String label, Color color) {
    return Row(
      children: [
        Container(width: 10, height: 10, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
        const SizedBox(width: 4),
        Text(label, style: TextStyle(fontSize: 11, color: Colors.grey.shade700, fontWeight: FontWeight.w500)),
      ],
    );
  }
}
