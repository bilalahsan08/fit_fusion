import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FfmiCalScreen extends StatefulWidget {
  const FfmiCalScreen({super.key});

  @override
  State<FfmiCalScreen> createState() => _FfmiCalScreenState();
}

class _FfmiCalScreenState extends State<FfmiCalScreen> {
  bool _isMetric = true;

  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heightCmController = TextEditingController();
  final TextEditingController _heightFtController = TextEditingController();
  final TextEditingController _heightInController = TextEditingController();
  final TextEditingController _bodyFatController = TextEditingController();

  double? _ffmiResult;
  double? _normalizedFfmiResult;
  double? _leanMassResult;
  String _ffmiCategory = "";
  Color _ffmiColor = Colors.grey;

  @override
  void dispose() {
    _weightController.dispose();
    _heightCmController.dispose();
    _heightFtController.dispose();
    _heightInController.dispose();
    _bodyFatController.dispose();
    super.dispose();
  }

  void _calculateFFMI() {
    FocusScope.of(context).unfocus();

    double weight = double.tryParse(_weightController.text) ?? 0.0;
    double bodyFat = double.tryParse(_bodyFatController.text) ?? 0.0;
    double heightMeters = 0.0;

    if (weight <= 0 || bodyFat <= 0 || bodyFat >= 100) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter valid positive numbers."), backgroundColor: Colors.redAccent),
      );
      return;
    }

    if (_isMetric) {
      double heightCm = double.tryParse(_heightCmController.text) ?? 0.0;
      if (heightCm <= 0) return;
      heightMeters = heightCm / 100;
    } else {
      double feet = double.tryParse(_heightFtController.text) ?? 0.0;
      double inches = double.tryParse(_heightInController.text) ?? 0.0;
      if (feet <= 0) return;
      heightMeters = (((feet * 12) + inches) * 2.54) / 100;
    }

    double weightKg = _isMetric ? weight : weight * 0.453592;

    double leanMassKg = weightKg * (1 - (bodyFat / 100));
    
    // FFMI = Lean Mass (kg) / Height (m)^2
    double ffmi = leanMassKg / (heightMeters * heightMeters);
    
    // Normalized FFMI = FFMI + 6.1 * (1.8 - Height (m))
    double normalizedFfmi = ffmi + 6.1 * (1.8 - heightMeters);

    String category;
    Color color;

    if (normalizedFfmi < 18) {
      category = "Below Average";
      color = Colors.blue.shade500;
    } else if (normalizedFfmi < 20) {
      category = "Average";
      color = Colors.teal.shade500;
    } else if (normalizedFfmi < 22) {
      category = "Excellent";
      color = Colors.green.shade600;
    } else if (normalizedFfmi < 25) {
      category = "Superior (Pro Natural)";
      color = Colors.orange.shade600;
    } else {
      category = "Suspicious (>25 limit)";
      color = Colors.red.shade600;
    }

    setState(() {
      _ffmiResult = ffmi;
      _normalizedFfmiResult = normalizedFfmi;
      _leanMassResult = leanMassKg;
      _ffmiCategory = category;
      _ffmiColor = color;
    });
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
          'FFMI Muscle Index',
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
              // Unit Toggle
              Center(
                child: Container(
                  decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(30)),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildToggleButton("Metric (kg/cm)", true),
                      _buildToggleButton("Imperial (lbs/in)", false),
                    ],
                  ),
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
                    Text("Your Measurements", style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold)),
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
                    _buildInputField(controller: _bodyFatController, label: "Body Fat (%)", icon: Icons.opacity_rounded),
                    
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: _calculateFFMI,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue.shade600,
                        foregroundColor: Colors.white,
                        minimumSize: const Size.fromHeight(56),
                        elevation: 0,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      ),
                      child: Text("Calculate FFMI", style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600)),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 32),

              // Results Section
              if (_normalizedFfmiResult != null) ...[
                Text("Your Muscle Potential", style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),
                
                // Normalized FFMI Card
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: _ffmiColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(28),
                    border: Border.all(color: _ffmiColor.withValues(alpha: 0.3), width: 2),
                  ),
                  child: Column(
                    children: [
                      Text("NORMALIZED FFMI", style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600, color: _ffmiColor, letterSpacing: 1.5)),
                      const SizedBox(height: 8),
                      Text(_normalizedFfmiResult!.toStringAsFixed(1), style: GoogleFonts.poppins(fontSize: 56, fontWeight: FontWeight.bold, color: _ffmiColor, height: 1)),
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(color: _ffmiColor, borderRadius: BorderRadius.circular(20)),
                        child: Text(_ffmiCategory.toUpperCase(), style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 16),
                
                // Secondary Stats
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
                            Text("Raw FFMI", style: TextStyle(color: Colors.grey.shade600, fontSize: 13, fontWeight: FontWeight.w500)),
                            const SizedBox(height: 4),
                            Text(_ffmiResult!.toStringAsFixed(1), style: GoogleFonts.poppins(color: Colors.black87, fontSize: 18, fontWeight: FontWeight.bold)),
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
                              decoration: BoxDecoration(color: Colors.teal.shade50, shape: BoxShape.circle),
                              child: Icon(Icons.monitor_weight_rounded, color: Colors.teal.shade600, size: 20),
                            ),
                            const SizedBox(height: 12),
                            Text("Lean Mass", style: TextStyle(color: Colors.grey.shade600, fontSize: 13, fontWeight: FontWeight.w500)),
                            const SizedBox(height: 4),
                            Text("${_leanMassResult!.toStringAsFixed(1)} kg", style: GoogleFonts.poppins(color: Colors.black87, fontSize: 18, fontWeight: FontWeight.bold)),
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

  Widget _buildToggleButton(String label, bool isMetricChoice) {
    final bool isSelected = _isMetric == isMetricChoice;
    return GestureDetector(
      onTap: () {
        setState(() {
          _isMetric = isMetricChoice;
          _weightController.clear();
          _heightCmController.clear();
          _heightFtController.clear();
          _heightInController.clear();
          _bodyFatController.clear();
          _normalizedFfmiResult = null;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue.shade600 : Colors.transparent,
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
        prefixIcon: Icon(icon, color: Colors.blue.shade500),
        filled: true,
        fillColor: Colors.grey.shade50,
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide(color: Colors.grey.shade200)),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide(color: Colors.blue.shade400, width: 2)),
      ),
    );
  }
}
