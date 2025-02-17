import 'package:fit_fusion/utility/Bmical.dart';
import 'package:fit_fusion/utility/Fatcal.dart';
import 'package:flutter/material.dart';

class UtilityHomePage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
    )
    );
  }

}

class UtilityHome extends StatefulWidget{
  @override
  State<UtilityHome> createState() => _UtilityHomeState();
}

class _UtilityHomeState extends State<UtilityHome> {
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Utility',style: Theme.of(context).textTheme.headlineLarge),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // First Card
               buildCard(
                    image: 'assets/images/statistics.png',
                    title: 'REPORT',
                   onPressed: () {  }),
              // Second Card
              buildCard(
                    image: 'assets/images/bell.png',
                    title: 'REMINDER',
                  onPressed: () {  }),
              // Third Card
               buildCard(
                    image: 'assets/images/bmi.png',
                    title: 'BMI CALCULATOR',
                   onPressed: () {Navigator.push(context,
                       MaterialPageRoute(builder:(context) => Bmical()));  }),
              // Forth Card
               buildCard(
                    image: 'assets/images/obesity.png',
                    title: 'FAT CALCULATOR',
                   onPressed: () {Navigator.push(context,
                       MaterialPageRoute(builder:(context) => Fatcal()));  }),
              // Fifth Card
              buildCard(
                    image: 'assets/images/dumbell.png',
                    title: 'ONE REP MAX',
                  onPressed: () {  }),
              // Sixth Card
               buildCard(
                    image: 'assets/images/calculator.png',
                    title: 'BASIC METABOLIC RATE',
                   onPressed: () {  }),
              // Seventh Card
               buildCard(
                    image: 'assets/images/power.png',
                    title: 'FAT FREE MASS INDEX',
                   onPressed: () {  }),
            ],
          ),
        ),
      )
    );
  }
  Widget buildCard({required String image, required String title,required VoidCallback onPressed}) {
    return Card(
      elevation: 2,
      child: InkWell(
        onTap: onPressed,
        splashColor: Colors.grey.withOpacity(0.2),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          height: 100,
          width: double.infinity, // Ensures the card takes the full width of the parent
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 35,
                backgroundImage: AssetImage(image),
              ),
              const SizedBox(width: 10),
              Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
              ),
            ],
          ),
        ),
      ),
    );
  }
}