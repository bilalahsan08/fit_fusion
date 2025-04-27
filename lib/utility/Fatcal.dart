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
            width: 350,
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
                        prefixIcon: Icon(Icons.accessibility),
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: neckController,
                    decoration: InputDecoration(
                      label: Text("Neck Circumference (cm)"),
                        prefixIcon: Icon(Icons.accessibility_new),
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: heightController,
                    decoration: InputDecoration(
                      label: Text("Height (cm)"),
                        prefixIcon: Icon(Icons.straighten),
                      border: OutlineInputBorder(),
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
                  Card(
                    elevation: 2,
                    margin: EdgeInsets.all(5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.read_more, color: Colors.blue,size: 32),

                          SizedBox(width: 8),
                          Text(
                            "Reference",
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          ]
                          ),
                          SizedBox(height: 16),
                          Table(
                            border: TableBorder.all(color: Colors.grey),
                            columnWidths: {
                              0: FlexColumnWidth(2),
                              1: FlexColumnWidth(1.5),
                              2: FlexColumnWidth(1.5),
                            },
                            children: [
                              TableRow(
                                decoration: BoxDecoration(color: Colors.grey[300]),
                                children: [
                                  _tableCell("Category", isHeader: true),
                                  _tableCell("Women", isHeader: true),
                                  _tableCell("Men", isHeader: true),
                                ],
                              ),
                              _tableRow("Essential Fat", "10% - 14%", "2% - 6%"),
                              _tableRow("Athletes", "14% - 21%", "6% - 14%"),
                              _tableRow("Fitness", "21% - 25%", "14% - 18%"),
                              _tableRow("Average", "25% - 32%", "18% - 25%"),
                              _tableRow("Obese", "Above 32%", "Above 25%"),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),

                  Card(
                    elevation: 2,
                    margin: EdgeInsets.all(5),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.info, color: Colors.blue, size: 30),
                              SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  'Information',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Body Fat Calculator helps you to find out your body fat percentage, your body type and the number of calories you have to burn, to lose 1% of your body fat.'
                            'BFP Index is the total mass of fat divided by total body mass; body fat includes essential body fat and storage body fat. Essential body fat is needed for life and reproductive functions. The percentage of essential body fat for women is greater than that for men, due to the demands of childbearing and other hormonal functions. An estimate of the amount of body fat that you need to lose is the first step in any successful weight loss program.'
                            'BFP Index is a good indicator of your body composition and indicates the amount of fat you have in your body.',
                            style: TextStyle(fontSize: 16, color: Colors.black87),
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
TableRow _tableRow(String category, String women, String men) {
  return TableRow(
    children: [
      _tableCell(category),
      _tableCell(women),
      _tableCell(men),
    ],
  );
}

Widget _tableCell(String text, {bool isHeader = false}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Text(
      text,
      style: TextStyle(
        fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
        fontSize: 14,
      ),
    ),
  );
}