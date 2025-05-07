import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class proteincal extends StatefulWidget {
  @override
  _proteincalState createState() => _proteincalState();
}

class _proteincalState extends State<proteincal> {
  final TextEditingController _weightController = TextEditingController();
  String _selectedGoal = 'Fat Loss';
  double _minProtein = 0;
  double _maxProtein = 0;

  void _calculateProtein() {
    double weight = double.tryParse(_weightController.text) ?? 0;

    if (weight <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please enter a valid weight.")),
      );
      return;
    }

    double minFactor = 1.6;
    double maxFactor = 2.2;

    switch (_selectedGoal) {
      case 'Fat Loss':
        minFactor = 1.6;
        maxFactor = 2.2;
        break;
      case 'Muscle Gain':
        minFactor = 1.8;
        maxFactor = 2.4;
        break;
      case 'Maintenance':
        minFactor = 1.2;
        maxFactor = 1.8;
        break;
      case 'Endurance Training':
        minFactor = 1.4;
        maxFactor = 1.6;
        break;
      case 'Strength Training':
        minFactor = 1.6;
        maxFactor = 2.2;
        break;
    }

    setState(() {
      _minProtein = weight * minFactor;
      _maxProtein = weight * maxFactor;
    });
  }

  String _getTipForGoal(String goal) {
    switch (goal) {
      case 'Fat Loss':
        return "🏃‍♀️ Focus on a calorie deficit while maintaining protein intake to preserve muscle mass.";
      case 'Muscle Gain':
        return "🍗 Include high-quality protein sources and a calorie surplus to support muscle growth.";
      case 'Maintenance':
        return "⚖️ Maintain a balanced diet with adequate protein to support your daily activity levels.";
      case 'Endurance Training':
        return "🚴‍♂️ Ensure adequate protein and carbs to fuel your long training sessions.";
      case 'Strength Training':
        return "💪 Focus on increasing strength with a protein-rich diet to recover and grow stronger.";
      default:
        return "Stay consistent and follow your goal-specific plan.";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Protein Calculator',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Card(
                  color: Colors.grey[300],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 5,
                  shadowColor: Colors.black.withOpacity(0.1),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Text(
                          'Enter your weight in kilograms (kg):',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey[800],
                          ),
                        ),
                        SizedBox(height: 16),
                        TextField(
                          controller: _weightController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'Weight (kg)',
                            labelStyle: TextStyle(color: Colors.grey[600]),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            filled: true,
                            fillColor: Colors.grey[50],
                          ),
                          onChanged: (val) => _calculateProtein(),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Card(
                  color: Colors.grey[300],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 5,
                  shadowColor: Colors.black.withOpacity(0.1),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Text(
                          'Select your goal:',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey[800],
                          ),
                        ),
                        SizedBox(height: 16),
                        DropdownButtonFormField<String>(
                          value: _selectedGoal,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            filled: true,
                            fillColor: Colors.grey[100],
                          ),
                          dropdownColor: Colors.grey[100],
                          items: [
                            'Fat Loss',
                            'Muscle Gain',
                            'Maintenance',
                            'Endurance Training',
                            'Strength Training',
                          ].map((goal) {
                            return DropdownMenuItem(
                              value: goal,
                              child: Text(goal),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              _selectedGoal = value!;
                              _calculateProtein();
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _calculateProtein,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    padding: EdgeInsets.symmetric(horizontal: 70, vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 5,
                  ),
                  child: Text(
                    'Calculate Protein',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: 30),
                if (_minProtein > 0)
                  Card(
                    color: Colors.grey[200],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 5,
                    shadowColor: Colors.black.withOpacity(0.1),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "🎯 Daily Protein Target:",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.green[600],
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            "${_minProtein.toStringAsFixed(1)}g - ${_maxProtein.toStringAsFixed(1)}g",
                            style: TextStyle(fontSize: 18),
                          ),
                          SizedBox(height: 16),
                          Text(
                            "💡 Spread this over 4–6 meals (~${(_minProtein / 5).toStringAsFixed(0)}g to ${(_maxProtein / 4).toStringAsFixed(0)}g per meal).",
                            style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                          ),
                          SizedBox(height: 16),
                          Text(
                            _getTipForGoal(_selectedGoal),
                            style: TextStyle(
                              fontSize: 16,
                              fontStyle: FontStyle.italic,
                              color: Colors.grey[700],
                            ),
                          ),
                        ],
                      ),
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