import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class proteincal extends StatefulWidget{
  @override
  State<proteincal> createState() => _proteincalState();
}

class _proteincalState extends State<proteincal> {
  final TextEditingController weightController = TextEditingController();
  double selectedActivityFactor = 1.2;
  double proteinResult = 0.0;

  final Map<String, double> activityLevels = {
    'Sedentary (0.8 g/kg)': 0.8,
    'Lightly active (1.0 g/kg)': 1.0,
    'Moderate (1.4 g/kg)': 1.4,
    'Active (1.8 g/kg)': 1.8,
    'Bodybuilding (2.2 g/kg)': 2.2,
  };
  void calculateProtein() {
    double weight = double.tryParse(weightController.text) ?? 0;

    setState(() {
      proteinResult = weight * selectedActivityFactor;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Protein Calculator'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: weightController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Enter your weight (kg)',
            ),
            ),
            SizedBox()
          ],
        ),
      ),

    );
  }
}