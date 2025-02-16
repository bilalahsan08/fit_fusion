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
      appBar: AppBar(
        title: Text('Nutrition',style: Theme.of(context).textTheme.headlineLarge),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // First Card
               buildCard(
                  image: 'assets/images/meal.png',
                  title: '30 DAYS MEAL PLAN',
                ),
              // Second Card
               buildCard(
                  image: 'assets/images/cutlery.png',
                  title: 'DIET PLANS',
                ),
              // Third Card
               buildCard(
                  image: 'assets/images/calories.png',
                  title: 'FOOD CALORIE',
                ),
              // Fourth Card
               buildCard(
                  image: 'assets/images/protein.png',
                  title: 'PROTEIN CALCULATOR',
                ),
              // Fifth Card
               buildCard(
                  image: 'assets/images/restaurant.png',
                  title: 'SPECIAL DIET PLANS',
                ),
              // Sixth Card
               buildCard(
                  image: 'assets/images/calories (1).png',
                  title: 'CALORIES CALCULATOR',
                ),
              // Seventh Card
                 buildCard(
                  image: 'assets/images/idea.png',
                  title: 'TIPS',
                ),
            ],
          ),
        ),
      )
    );
  }
  Widget buildCard({required String image, required String title}) {
    return Card(
      elevation: 2,
      child: InkWell(
        onTap: (){},
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