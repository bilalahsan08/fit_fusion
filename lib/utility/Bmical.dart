import 'package:flutter/material.dart';

class Bmical extends StatefulWidget{
  @override
  State<Bmical> createState() => _BmicalState();
}

class _BmicalState extends State<Bmical> {
  var wtController = TextEditingController();
  var ftController = TextEditingController();
  var inController = TextEditingController();
  var result = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bmi Calculator'),
      ),
      body: Center(
        child: Container(
          width: 300,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('BMI',style:
                TextStyle(fontSize: 34, fontWeight: FontWeight.w400),
                ),
                SizedBox(height: 30,),
                TextField(
                  controller: wtController,
                  decoration: InputDecoration(
                      labelText: 'Enter your Weigth (in kgs)',
                    prefixIcon: Icon(Icons.line_weight)
                  ),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 20),
                TextField(
                  controller: ftController,
                  decoration: InputDecoration(
                      labelText: 'Enter your Height (in feets)',
                      prefixIcon: Icon(Icons.straighten)
                  ),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 20),
                TextField(
                  controller: inController,
                  decoration: InputDecoration(
                      labelText: 'Enter your Height (in inches)',
                      prefixIcon: Icon(Icons.height)
                  ),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    var wt = wtController.text.toString();
                    var ft = ftController.text.toString();
                    var In = inController.text.toString();
                    if (wt != "" && ft != "" && In != "") {
                      var iwt = int.parse(wt);
                      var ift = int.parse(ft);
                      var iIn = int.parse(In);
                      var totalinch = (ift * 12) + iIn;
                      var totalcm = totalinch * 2.54;
                      var totalmeter = totalcm / 100;
                      var bmi = iwt / (totalmeter * totalmeter);
                      setState(() {
                        result = "Your BMI is: ${bmi.toStringAsFixed(2)}";
                      });
                    } else {
                      setState(() {
                        result = "Please: Fill all the required fields";
                      });
                    }
                  },
                  child: Text("Calculate BMI"),
                ),
                SizedBox(height: 15),
                Text(
                  result,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}