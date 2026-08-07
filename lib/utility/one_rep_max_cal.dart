import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OneRepMaxScreen extends StatefulWidget {
  const OneRepMaxScreen({super.key});

  @override
  State<OneRepMaxScreen> createState() => _OneRepMaxScreenState();
}

class _OneRepMaxScreenState extends State<OneRepMaxScreen> {
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _repsController = TextEditingController();
  
  bool _isMetric = true; // true = kg, false = lbs
  double? _oneRepMax;

  @override
  void dispose() {
    _weightController.dispose();
    _repsController.dispose();
    super.dispose();
  }

  void _calculate1RM() {
    FocusScope.of(context).unfocus();

    double weight = double.tryParse(_weightController.text) ?? 0.0;
    int reps = int.tryParse(_repsController.text) ?? 0;

    if (weight <= 0 || reps <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter valid positive numbers for weight and reps."), backgroundColor: Colors.redAccent),
      );
      return;
    }

    if (reps == 1) {
      setState(() => _oneRepMax = weight);
      return;
    }

    // Epley Formula: 1RM = Weight × (1 + 0.0333 × Reps)
    double epley = weight * (1 + (0.0333 * reps));
    
    // Brzycki Formula: 1RM = Weight × (36 / (37 - Reps))
    // Brzycki gets weird if reps >= 37, so we bound it
    double brzycki = weight * (36 / (37 - (reps > 36 ? 36 : reps))); 
    
    // Average them for a slightly more accurate blended prediction
    double estimated1RM = (epley + brzycki) / 2;

    setState(() {
      _oneRepMax = estimated1RM;
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
          '1-Rep Max Calculator',
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
                      _buildToggleButton("Kilograms (kg)", true),
                      _buildToggleButton("Pounds (lbs)", false),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // Input Form
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
                    Text("Your Lift Details", style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 20),
                    
                    Row(
                      children: [
                        Expanded(
                          child: _buildInputField(
                            controller: _weightController, 
                            label: _isMetric ? "Weight (kg)" : "Weight (lbs)", 
                            icon: Icons.fitness_center_rounded
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _buildInputField(
                            controller: _repsController, 
                            label: "Reps", 
                            icon: Icons.repeat_rounded
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: _calculate1RM,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.indigo.shade600,
                        foregroundColor: Colors.white,
                        minimumSize: const Size.fromHeight(56),
                        elevation: 0,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      ),
                      child: Text("Calculate 1RM", style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600)),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 32),

              // Results Section
              if (_oneRepMax != null) ...[
                Text("Your Maximum Strength", style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),
                
                // 1RM Hero Card
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.indigo.shade700, Colors.indigo.shade500],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(28),
                    boxShadow: [BoxShadow(color: Colors.indigo.withValues(alpha: 0.3), blurRadius: 15, offset: const Offset(0, 8))],
                  ),
                  child: Column(
                    children: [
                      Text("ESTIMATED 1-REP MAX", style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.indigo.shade100, letterSpacing: 1.0)),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(_oneRepMax!.toStringAsFixed(1), style: GoogleFonts.poppins(fontSize: 56, fontWeight: FontWeight.bold, color: Colors.white, height: 1)),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0, left: 8),
                            child: Text(_isMetric ? "kg" : "lbs", style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.indigo.shade100)),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 32),
                Text("Percentage Breakdown", style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),
                
                // Percentage List
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(28),
                    boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.03), blurRadius: 10, offset: const Offset(0, 4))],
                  ),
                  child: Column(
                    children: [
                      _buildPercentageRow(100, 1),
                      _buildDivider(),
                      _buildPercentageRow(95, 2),
                      _buildDivider(),
                      _buildPercentageRow(90, 4),
                      _buildDivider(),
                      _buildPercentageRow(85, 6),
                      _buildDivider(),
                      _buildPercentageRow(80, 8),
                      _buildDivider(),
                      _buildPercentageRow(75, 10),
                      _buildDivider(),
                      _buildPercentageRow(70, 12),
                      _buildDivider(),
                      _buildPercentageRow(65, 15),
                      _buildDivider(),
                      _buildPercentageRow(60, 20),
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

  Widget _buildPercentageRow(int percentage, int estimatedReps) {
    double weightAtPercentage = _oneRepMax! * (percentage / 100);
    
    // Color coding based on intensity zone
    Color zoneColor;
    String zoneName;
    if (percentage >= 90) {
      zoneColor = Colors.red.shade500;
      zoneName = "Power";
    } else if (percentage >= 80) {
      zoneColor = Colors.orange.shade500;
      zoneName = "Strength";
    } else if (percentage >= 70) {
      zoneColor = Colors.green.shade500;
      zoneName = "Hypertrophy";
    } else {
      zoneColor = Colors.blue.shade500;
      zoneName = "Endurance";
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(color: zoneColor.withValues(alpha: 0.1), shape: BoxShape.circle),
                child: Center(
                  child: Text("$percentage%", style: GoogleFonts.poppins(color: zoneColor, fontWeight: FontWeight.bold, fontSize: 13)),
                ),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("~ $estimatedReps Reps", style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.black87)),
                  Text(zoneName, style: TextStyle(color: Colors.grey.shade500, fontSize: 12)),
                ],
              ),
            ],
          ),
          Text(
            "${weightAtPercentage.toStringAsFixed(1)} ${_isMetric ? 'kg' : 'lbs'}", 
            style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.indigo.shade700)
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(height: 1, thickness: 1, color: Colors.grey.shade100, indent: 24, endIndent: 24);
  }

  Widget _buildToggleButton(String label, bool isMetricChoice) {
    final bool isSelected = _isMetric == isMetricChoice;
    return GestureDetector(
      onTap: () {
        setState(() {
          _isMetric = isMetricChoice;
          // Conversion logic if they already entered weight
          double currentWeight = double.tryParse(_weightController.text) ?? 0.0;
          if (currentWeight > 0) {
            if (_isMetric) { // Convert lbs to kg
              _weightController.text = (currentWeight * 0.453592).toStringAsFixed(1);
            } else { // Convert kg to lbs
              _weightController.text = (currentWeight / 0.453592).toStringAsFixed(1);
            }
            if (_oneRepMax != null) _calculate1RM(); // Recalculate
          }
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? Colors.indigo.shade600 : Colors.transparent,
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
        prefixIcon: Icon(icon, color: Colors.indigo.shade500),
        filled: true,
        fillColor: Colors.grey.shade50,
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide(color: Colors.grey.shade200)),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide(color: Colors.indigo.shade400, width: 2)),
      ),
    );
  }
}
