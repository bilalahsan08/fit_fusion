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

        // Clear the text fields after calculation
        abdomenController.clear();
        neckController.clear();
        heightController.clear();
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
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text(
          'Fat Calculator',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.grey[200],
      ),
      body: Center(
        child: Container(
          width: 350,
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Calculate Body Fat",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 30),

                _buildInputField(
                  controller: abdomenController,
                  label: "Abdomen Circumference (cm)",
                  icon: Icons.accessibility,
                ),
                const SizedBox(height: 20),

                _buildInputField(
                  controller: neckController,
                  label: "Neck Circumference (cm)",
                  icon: Icons.accessibility_new,
                ),
                const SizedBox(height: 20),

                _buildInputField(
                  controller: heightController,
                  label: "Height (cm)",
                  icon: Icons.straighten,
                ),
                const SizedBox(height: 30),

                ElevatedButton(
                  onPressed: calculate,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    "Calculate",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
                const SizedBox(height: 20),

                Text(
                  result,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 20),

                _buildCard(
                  title: "Reference",
                  icon: Icons.read_more,
                  child: _buildReferenceTable(),
                ),
                const SizedBox(height: 15),

                _buildCard(
                  title: "Information",
                  icon: Icons.info,
                  child: const Text(
                    'Body Fat Calculator helps you to find out your body fat percentage, your body type and the number of calories you have to burn, to lose 1% of your body fat.\n\n'
                        'BFP Index is the total mass of fat divided by total body mass; body fat includes essential body fat and storage body fat.\n\n',

                    style: TextStyle(fontSize: 16, color: Colors.black87, height: 1.5),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputField({required TextEditingController controller, required String label, required IconData icon}) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
      keyboardType: TextInputType.number,
    );
  }

  Widget _buildCard({required String title, required IconData icon, required Widget child}) {
    return Card(
      color: Colors.white,
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: Colors.blue, size: 30),
                const SizedBox(width: 10),
                Text(
                  title,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 10),
            child,
          ],
        ),
      ),
    );
  }

  Widget _buildReferenceTable() {
    return Table(
      border: TableBorder.all(color: Colors.grey),
      columnWidths: const {
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
    );
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
          fontSize: 15,
        ),
      ),
    );
  }
}
