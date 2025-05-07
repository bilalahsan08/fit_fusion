import 'package:fit_fusion/nutiton/Dietplan/breakfast1.dart';
import 'package:fit_fusion/nutiton/Dietplan/breakfast2.dart';
import 'package:fit_fusion/nutiton/Dietplan/breakfast3.dart';
import 'package:flutter/material.dart';

class Dietplan extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Diet Plans',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Breakfast Section
            Row(
              children: [
                Icon(Icons.free_breakfast, color: Colors.grey),
                const SizedBox(width: 8),
                Text(
                  "Breakfast",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),
            // Horizontal Scroll for Breakfast Cards
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  DietCard(
                    title: "Cashew Banana Pancakes",
                    imagePath: "assets/images/pancake.png", // Replace with the correct path
                    duration: '15 min',
                    kcal: '456 kcal',
                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => breakfast1())),
                  ),
                  DietCard(
                    title: "Avocado Egg Wraps",
                    imagePath: "assets/images/wrap.png", // Replace with the correct path
                    duration: '15 min',
                    kcal: '456 kcal',
                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => breakfast2())),
                  ),
                  DietCard(
                    title: "Cucumber & Avocado Toast",
                    imagePath: "assets/images/toast.png", // Replace with the correct path
                    duration: '15 min',
                    kcal: '456 kcal',
                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => breakfast3())),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Lunch Section
            Row(
              children: [
                Icon(Icons.lunch_dining, color: Colors.grey),
                const SizedBox(width: 8),
                Text(
                  "Lunch",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),
            // Horizontal Scroll for Lunch Cards
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  DietCard(
                    title: "Grilled Chicken Salad",
                    imagePath: "assets/images/chickensalad.png", // Replace with the correct path
                    duration: '15 min',
                    kcal: '456 kcal',
                    onPressed: () {
                      // Action for Lunch
                    },
                  ),
                  DietCard(
                    title: "Quinoa Salad with Avocado",
                    imagePath: "assets/images/avocadosalad.png", // Replace with the correct path
                    duration: '20 min',
                    kcal: '350 kcal',
                    onPressed: () {
                      // Action for Lunch
                    },
                  ),
                  DietCard(
                    title: "Grilled Fish Tacos",
                    imagePath: "assets/images/fishtacos.png", // Replace with the correct path
                    duration: '25 min',
                    kcal: '400 kcal',
                    onPressed: () {
                      // Action for Lunch
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Dinner Section
            Row(
              children: [
                Icon(Icons.dinner_dining, color: Colors.grey),
                const SizedBox(width: 8),
                Text(
                  "Dinner",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),
            // Horizontal Scroll for Dinner Cards
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  DietCard(
                    title: "Cheese Salad",
                    imagePath: "assets/images/cheese.png", // Replace with the correct path
                    duration: '30 min',
                    kcal: '450 kcal',
                    onPressed: () {
                      // Action for Dinner
                    },
                  ),
                  DietCard(
                    title: "Chicken with Sweet Potato",
                    imagePath: "assets/images/potato.png", // Replace with the correct path
                    duration: '40 min',
                    kcal: '500 kcal',
                    onPressed: () {
                      // Action for Dinner
                    },
                  ),
                  DietCard(
                    title: "Salmon with Asparagus",
                    imagePath: "assets/images/salmon.png", // Replace with the correct path
                    duration: '35 min',
                    kcal: '550 kcal',
                    onPressed: () {
                      // Action for Dinner
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),


    );
  }
}

class DietCard extends StatelessWidget {
  final String title;
  final String imagePath;
  final String duration;
  final String kcal;
  final VoidCallback onPressed;

  const DietCard({
    Key? key,
    required this.title,
    required this.imagePath,
    required this.duration,
    required this.kcal,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Parse the kcal string to a double value (assuming it's always in the format 'XXX kcal')
    double kcalValue = double.tryParse(kcal.replaceAll(' kcal', '')) ?? 0.0;

    return InkWell(
      onTap: onPressed,
      child: Container(
        width: 250,
        margin: EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8)],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              child: Image.asset(imagePath, height: 160, width: double.infinity, fit: BoxFit.cover),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  SizedBox(height: 12),
                  // Other content like progress bars can go here
                ],
              ),
            ),
            // Bottom row with Time and Kcal
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.access_time, size: 16, color: Colors.grey[600]),
                      SizedBox(width: 4),
                      Text(duration, style: TextStyle(color: Colors.grey[700])),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.whatshot, size: 16, color: Colors.grey[600]),
                      SizedBox(width: 4),
                      Text(kcal, style: TextStyle(color: Colors.grey[700])),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
