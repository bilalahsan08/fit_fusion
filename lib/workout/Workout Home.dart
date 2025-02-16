import 'package:flutter/material.dart';

class WorkoutHome extends StatefulWidget{
  @override
  State<WorkoutHome> createState() => _WorkoutHomeState();
}

class _WorkoutHomeState extends State<WorkoutHome> {
  @override
  void initState() {
    super.initState();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Workouts',style: Theme.of(context).textTheme.headlineLarge),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            buildCard(
                title: 'Strength',
                image: 'assets/images/strength.png'),
            buildCard(
                title: 'HIIT,Cardio',
                image: 'assets/images/bell.png'),
            buildCard(
                title: 'Yoga, Stretching',
                image: 'assets/images/bell.png'),
            buildCard(
                title: 'Warmup,Recovery',
                image: 'assets/images/bell.png'),
            buildCard(
                title: 'Custom Workouts',
                image: 'assets/images/bell.png'),


          ],

        ),
      ),
    );
  }
  Widget buildCard({required String title,required String image}) {
    return Card(
      elevation: 2,
      child: InkWell(
        onTap: (){},
        splashColor: Colors.grey.withOpacity(0.2),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          height: 100,
          width: double.infinity, // Ensures the card takes the full width of the parent
          child:Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text(
                  title,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    image,
                    height: 80,
                    width: 80,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          ),
        ),
    );
  }
}