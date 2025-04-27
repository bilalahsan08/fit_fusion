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
      appBar: AppBar(
        title: Text('BMI Calculator'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Calculate Your BMI',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),

              // Weight Input
              TextField(
                controller: wtController,
                decoration: InputDecoration(
                  labelText: 'Weight (kg)',
                  prefixIcon: Icon(Icons.line_weight),
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 15),

              // Height in Feet Input
              TextField(
                controller: ftController,
                decoration: InputDecoration(
                  labelText: 'Height (feet)',
                  prefixIcon: Icon(Icons.straighten),
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 15),

              // Height in Inches Input
              TextField(
                controller: inController,
                decoration: InputDecoration(
                  labelText: 'Height (inches)',
                  prefixIcon: Icon(Icons.height),
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 20),

              // Calculate Button
              ElevatedButton(
                onPressed: calculateBMI,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text("Calculate BMI", style: TextStyle(fontSize: 18)),
              ),
              SizedBox(height: 20),

              // BMI Result Display
              result.isNotEmpty
                  ? Column(
                children: [
                  Text(
                    result,
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    category,
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: categoryColor),
                  ),
                  SizedBox(height: 10),
                ],
              )
                  : SizedBox(),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            elevation: 2,
            margin: EdgeInsets.all(5),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Icon(Icons.calculate, color: Colors.blue,size: 32),
                      SizedBox(width: 8),
                      Text(
                        'BMI Table',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 16),
                  Table(
                    columnWidths: {
                      0: FlexColumnWidth(1.5),
                      1: FlexColumnWidth(2),
                    },
                    border: TableBorder.all(color: Colors.grey),
                    children: [
                      TableRow(
                        decoration: BoxDecoration(color: Colors.grey[300]),
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('BMI Range',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16)),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('Category',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16)),
                          ),
                        ],
                      ),
                      _buildTableRow('Less than 16', 'Severely Underweight'),
                      _buildTableRow('16 - 18.5', 'Underweight'),
                      _buildTableRow('18.5 - 25', 'Normal'),
                      _buildTableRow('25 - 30', 'Overweight'),
                      _buildTableRow('Above 30', 'Obese Class'),
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
                        'BMI is a measurement of a persons leanness or corpulence based on their height and weight, and is intended to quantify tissue mass.'
                        'It is widely used as a general indicator of whether a person has a healthy body weight for their height.'
                            'Specifically, the value obtained from the calculation of BMI is used to categorize whether a person is underweight, normal weight, overweight, or obese depending on what range the value falls between.'
                        'These ranges of BMI vary based on factors such as region and age, and are sometimes further divided into subcategories such as severely underweight or very severely obese.'
                        'Being overweight or underweight can have significant health effects, so while BMI is an imperfect measure of healthy body weight, it is a useful indicator of whether any additional testing or action is required.'
                        ''
                        ,
                        style: TextStyle(fontSize: 16, color: Colors.black87),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}
TableRow _buildTableRow(String range, String category) {
  return TableRow(children: [
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(range, style: TextStyle(fontSize: 15)),
    ),
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(category, style: TextStyle(fontSize: 15)),
    ),
  ]);
}

