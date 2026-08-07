import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HydrationTrackerScreen extends StatefulWidget {
  const HydrationTrackerScreen({super.key});

  @override
  State<HydrationTrackerScreen> createState() => _HydrationTrackerScreenState();
}

class _HydrationTrackerScreenState extends State<HydrationTrackerScreen> {
  int _currentIntakeMl = 0;
  int _dailyGoalMl = 2500;

  void _addWater(int amount) {
    setState(() {
      _currentIntakeMl += amount;
      if (_currentIntakeMl > _dailyGoalMl * 2) {
        _currentIntakeMl = _dailyGoalMl * 2; // Cap it so the UI doesn't break
      }
    });
  }

  void _removeWater(int amount) {
    setState(() {
      _currentIntakeMl -= amount;
      if (_currentIntakeMl < 0) _currentIntakeMl = 0;
    });
  }

  void _editGoal() {
    TextEditingController goalController = TextEditingController(text: _dailyGoalMl.toString());
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Text("Set Daily Goal", style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
          content: TextField(
            controller: goalController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: "Amount in ml (e.g. 2500)",
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            ),
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: Text("Cancel", style: TextStyle(color: Colors.grey.shade600))),
            ElevatedButton(
              onPressed: () {
                int? newGoal = int.tryParse(goalController.text);
                if (newGoal != null && newGoal > 0) {
                  setState(() => _dailyGoalMl = newGoal);
                  Navigator.pop(context);
                }
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.cyan, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
              child: const Text("Save", style: TextStyle(color: Colors.white)),
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double progress = _currentIntakeMl / _dailyGoalMl;
    if (progress > 1.0) progress = 1.0;

    return Scaffold(
      backgroundColor: Colors.cyan.shade50,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Hydration Tracker',
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.cyan.shade900),
        ),
        iconTheme: IconThemeData(color: Colors.cyan.shade900),
        actions: [
          IconButton(
            icon: Icon(Icons.settings_rounded, color: Colors.cyan.shade900),
            onPressed: _editGoal,
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          SizedBox(
                            width: 250,
                            height: 250,
                            child: CircularProgressIndicator(
                              value: progress,
                              strokeWidth: 20,
                              backgroundColor: Colors.cyan.shade100,
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.cyan.shade500),
                              strokeCap: StrokeCap.round,
                            ),
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.water_drop_rounded, size: 48, color: Colors.cyan.shade600),
                              const SizedBox(height: 8),
                              Text(
                                "${(_currentIntakeMl / 1000).toStringAsFixed(1)} L",
                                style: GoogleFonts.poppins(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.cyan.shade900, height: 1),
                              ),
                              Text(
                                "of ${(_dailyGoalMl / 1000).toStringAsFixed(1)} L",
                                style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.cyan.shade700),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 40),
                      Text(
                        progress >= 1.0 
                            ? "Goal Reached! Excellent! 🎉" 
                            : "Keep drinking water to reach your goal!",
                        style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600, color: progress >= 1.0 ? Colors.green.shade600 : Colors.cyan.shade800),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            
            // Controls Bottom Sheet style
            Container(
              padding: const EdgeInsets.all(32),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 20, offset: Offset(0, -5))],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text("Quick Log", style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87), textAlign: TextAlign.center),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildAddButton("Glass", 250, Icons.local_drink_rounded),
                      _buildAddButton("Bottle", 500, Icons.sanitizer_rounded),
                      _buildAddButton("Jug", 1000, Icons.coffee_maker_rounded),
                    ],
                  ),
                  const SizedBox(height: 24),
                  TextButton.icon(
                    onPressed: () => _removeWater(250),
                    icon: Icon(Icons.undo_rounded, color: Colors.grey.shade500),
                    label: Text("Undo last log", style: TextStyle(color: Colors.grey.shade600, fontWeight: FontWeight.w600)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddButton(String label, int amountMl, IconData icon) {
    return GestureDetector(
      onTap: () => _addWater(amountMl),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.cyan.shade50,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.cyan.shade100, width: 2),
            ),
            child: Icon(icon, color: Colors.cyan.shade600, size: 32),
          ),
          const SizedBox(height: 8),
          Text(label, style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black87)),
          Text("+$amountMl ml", style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
        ],
      ),
    );
  }
}
