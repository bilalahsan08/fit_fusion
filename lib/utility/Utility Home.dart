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
      extendBodyBehindAppBar: true, // Allow background under the AppBar
      appBar: AppBar(
        title: Text(
          'Utility',
          style: Theme.of(context).textTheme.headlineLarge?.copyWith(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black87),
      ),
      body: Container(
        color: Colors.grey[200], // Updated: grey background
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  buildCard(
                    image: 'assets/images/statistics.png',
                    title: 'Report',
                    onPressed: () {},
                  ),
                  buildCard(
                    image: 'assets/images/bell.png',
                    title: 'Reminder',
                    onPressed: () {
                    },
                  ),
                  buildCard(
                    image: 'assets/images/bmi.png',
                    title: 'BMI Calculator',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Bmical()),
                      );
                    },
                  ),
                  buildCard(
                    image: 'assets/images/obesity.png',
                    title: 'Fat Calculator',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Fatcal()),
                      );
                    },
                  ),
                  buildCard(
                    image: 'assets/images/dumbell.png',
                    title: 'One Rep Max',
                    onPressed: () {},
                  ),
                  buildCard(
                    image: 'assets/images/calculator.png',
                    title: 'Basic Metabolic Rate',
                    onPressed: () {},
                  ),
                  buildCard(
                    image: 'assets/images/power.png',
                    title: 'Fat Free Mass Index',
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

    Widget buildCard({
      required String image,
      required String title,
      required VoidCallback onPressed,
    }) {
      return AnimatedContainer(
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
        margin: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.95),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              spreadRadius: 3,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(20),
          splashColor: Colors.blueAccent.withOpacity(0.2),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            height: 110,
            width: double.infinity,
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [Colors.blueAccent, Colors.lightBlueAccent],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: CircleAvatar(
                    radius: 35,
                    backgroundImage: AssetImage(image),
                    backgroundColor: Colors.white,
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.black87,
                    ),
                  ),
                ),
                Icon(Icons.arrow_forward_ios, size: 18, color: Colors.grey),
              ],
            ),
          ),
        ),
      );
    }
