import 'package:fit_fusion/nutiton/Foodcal.dart';
import 'package:fit_fusion/nutiton/Proteincal.dart';
import 'package:fit_fusion/nutiton/Tips.dart';
import 'package:flutter/material.dart';
class NutritionHomePage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
    );
  }

}

class NutritionHome extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true, // To allow background under AppBar
      appBar: AppBar(
        title: Text(
          'Nutrition',
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
        color: Colors.grey[200], // Updated: background color set to grey
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  buildCard(
                    image: 'assets/images/meal.png',
                    title: '30 DAYS MEAL PLAN',
                    onPressed: () {},
                  ),
                  buildCard(
                    image: 'assets/images/cutlery.png',
                    title: 'DIET PLANS',
                    onPressed: () {},
                  ),
                  buildCard(
                    image: 'assets/images/calories.png',
                    title: 'FOOD CALORIE',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Foodcal()),
                      );
                    },
                  ),
                  buildCard(
                    image: 'assets/images/protein.png',
                    title: 'PROTEIN CALCULATOR',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => proteincal()),
                      );
                    },
                  ),
                  buildCard(
                    image: 'assets/images/restaurant.png',
                    title: 'SPECIAL DIET PLANS',
                    onPressed: () {},
                  ),
                  buildCard(
                    image: 'assets/images/calories (1).png',
                    title: 'CALORIES CALCULATOR',
                    onPressed: () {},
                  ),
                  buildCard(
                    image: 'assets/images/idea.png',
                    title: 'TIPS',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Tips()),
                      );
                    },
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
