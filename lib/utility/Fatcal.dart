import 'package:flutter/material.dart';
import 'dart:math';

class Fatcal extends StatefulWidget {
  const Fatcal({super.key});

  @override
  State<Fatcal> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Fatcal> {
  final abdomenController = TextEditingController();
  final neckController = TextEditingController();
  final heightController = TextEditingController();
  String result = '';

  double calculateBodyFat(double abdomen, double neck, double height) {
    return (86.010 * log(abdomen - neck) / log(10)) -
        (70.041 * log(height) / log(10)) + 36.76;
  }

  void calculate() {
    final abdomen = double.tryParse(abdomenController.text);
    final neck = double.tryParse(neckController.text);
    final height = double.tryParse(heightController.text);

    if (abdomen != null && neck != null && height != null) {
      final bodyFat = calculateBodyFat(abdomen, neck, height);
      setState(() {
        result = "Fat Percentage: ${bodyFat.toStringAsFixed(2)}%";
      });
    } else {
      setState(() {
        result = "Please: Fill in all fields correctly.";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fat Calculator'),
      ),
      body:Center(
          child: Container(
            width: 300,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Calculate Body Fat ",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 30),
                  TextField(
                    controller: abdomenController,
                    decoration: InputDecoration(
                      label: Text("Abdomen Circumference (cm)"),
                        prefixIcon: Icon(Icons.accessibility)
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: neckController,
                    decoration: InputDecoration(
                      label: Text("Neck Circumference (cm)"),
                        prefixIcon: Icon(Icons.accessibility_new)
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: heightController,
                    decoration: InputDecoration(
                      label: Text("Height (cm)"),
                        prefixIcon: Icon(Icons.straighten)
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: calculate,
                    child: Text("Calculate"),
                  ),
                  SizedBox(height: 20),
                  Text(
                    result,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ),
          ),
        ),
    );
  }
}