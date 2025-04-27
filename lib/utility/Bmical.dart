import 'package:flutter/material.dart';
class Bmical extends StatefulWidget {
  @override
  State<Bmical> createState() => _BmicalState();
}

class _BmicalState extends State<Bmical> {
  final TextEditingController wtController = TextEditingController();
  final TextEditingController ftController = TextEditingController();
  final TextEditingController inController = TextEditingController();

  String result = "";
  String category = "";
  Color categoryColor = Colors.grey;

  void calculateBMI() {
    var wt = wtController.text.trim();
    var ft = ftController.text.trim();
    var In = inController.text.trim();

    if (wt.isNotEmpty && ft.isNotEmpty && In.isNotEmpty) {
      try {
        var iwt = double.parse(wt);
        var ift = double.parse(ft);
        var iIn = double.parse(In);

        var totalInches = (ift * 12) + iIn;
        var totalMeters = (totalInches * 2.54) / 100;
        var bmi = iwt / (totalMeters * totalMeters);

        String bmiCategory;
        Color color;

        if (bmi < 18.5) {
          bmiCategory = "Underweight";
          color = Colors.blue;
        } else if (bmi >= 18.5 && bmi <= 24.9) {
          bmiCategory = "Normal";
          color = Colors.green;
        } else if (bmi >= 25 && bmi <= 29.9) {
          bmiCategory = "Overweight";
          color = Colors.orange;
        } else {
          bmiCategory = "Obese";
          color = Colors.red;
        }

        setState(() {
          result = "Your BMI is: ${bmi.toStringAsFixed(2)}";
          category = bmiCategory;
          categoryColor = color;

          // Clear the text fields after calculation
          wtController.clear();
          ftController.clear();
          inController.clear();
        });
      } catch (e) {
        setState(() {
          result = "Please enter valid numbers";
          category = "";
          categoryColor = Colors.grey;
        });
      }
    } else {
      setState(() {
        result = "Please fill all the fields";
        category = "";
        categoryColor = Colors.grey;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        title: Text('BMI Calculator', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Calculate Your BMI',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                ),
              ),
              SizedBox(height: 20),
              _buildInputField(wtController, 'Weight (kg)', Icons.line_weight),
              SizedBox(height: 15),
              _buildInputField(ftController, 'Height (feet)', Icons.straighten),
              SizedBox(height: 15),
              _buildInputField(inController, 'Height (inches)', Icons.height),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: calculateBMI,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  "Calculate BMI",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
              SizedBox(height: 20),
              if (result.isNotEmpty) ...[
                Text(
                  result,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal[800],
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  category,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: categoryColor,
                  ),
                ),
                SizedBox(height: 20),
              ],
              _buildCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.calculate, color: Colors.teal, size: 32),
                        SizedBox(width: 8),
                        Text(
                          'BMI Table',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[800],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    _buildBmiTable(),
                  ],
                ),
              ),
              SizedBox(height: 15),
              _buildCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.info_outline, color: Colors.teal, size: 30),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'Information',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[800],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Text(
                      'BMI is a measurement of a person\'s leanness or corpulence based on their height and weight. '
                          'It helps to categorize whether a person is underweight, normal weight, overweight, or obese, '
                          'providing a general indication of healthy body weight.',
                      style: TextStyle(fontSize: 16, color: Colors.black87, height: 1.4),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputField(TextEditingController controller, String label, IconData icon) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
      keyboardType: TextInputType.number,
    );
  }

  Widget _buildCard({required Widget child}) {
    return Card(
      color: Colors.white,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: child,
      ),
    );
  }

  Widget _buildBmiTable() {
    return Table(
      columnWidths: {
        0: FlexColumnWidth(1.5),
        1: FlexColumnWidth(2),
      },
      border: TableBorder.all(color: Colors.grey.shade300),
      children: [
        _buildTableHeader(),
        _buildTableRow('Less than 16', 'Severely Underweight'),
        _buildTableRow('16 - 18.5', 'Underweight'),
        _buildTableRow('18.5 - 25', 'Normal'),
        _buildTableRow('25 - 30', 'Overweight'),
        _buildTableRow('Above 30', 'Obese Class'),
      ],
    );
  }

  TableRow _buildTableHeader() {
    return TableRow(
      decoration: BoxDecoration(color: Colors.grey[300]),
      children: [
        _tableCell('BMI Range', isHeader: true),
        _tableCell('Category', isHeader: true),
      ],
    );
  }

  TableRow _buildTableRow(String range, String category) {
    return TableRow(
      children: [
        _tableCell(range),
        _tableCell(category),
      ],
    );
  }

  Widget _tableCell(String text, {bool isHeader = false}) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 16,
          fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
          color: Colors.black87,
        ),
      ),
    );
  }
}
