import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Tips extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true, // To make background go under app bar
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Tips',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Container(
        color: Colors.grey[200], // Updated: Grey background
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
              child: Column(
                children: [
                  _buildTipCard(
                    title: 'Eat 5-6 times a day',
                    description:
                    'You should eat every 2 or 3 hours. Consume 300–1200 calories in every meal, depending on your goal. You can find diet plans and calorie tables in our application.',
                  ),
                  _buildTipCard(
                    title: 'Proteins',
                    description:
                    'One gram of protein contains 4 calories. Physically active people should eat at least 2 grams of protein per kg of their body weight to maintain muscles.',
                  ),
                  _buildTipCard(
                    title: 'Carbohydrates',
                    description:
                    'Carbs provide energy. Consume quality sources like oats, rice, and potatoes. Skinny individuals should eat them generously.',
                  ),
                  _buildTipCard(
                    title: 'Fats',
                    description:
                    'Fats are essential but limit them to 30% of daily intake. Focus on plant-based fats to avoid cardiovascular diseases.',
                  ),
                  _buildTipCard(
                    title: 'Water',
                    description:
                    'Higher protein intake demands more water. Drink at least 2L of water for every 100g of protein to support kidney health.',
                  ),
                  _buildTipCard(
                    title: 'Supplements',
                    description:
                    'Use supplements as additions, not replacements. Read our detailed guide in the app for correct supplement usage.',
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

    Widget _buildTipCard({required String title, required String description}) {
      return AnimatedContainer(
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
        margin: EdgeInsets.symmetric(vertical: 10),
        padding: EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.9),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 12,
              offset: Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.local_fire_department, color: Colors.deepPurple, size: 28),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 14),
            Text(
              description,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black.withOpacity(0.7),
                height: 1.5,
              ),
            ),
          ],
        ),
      );
    }
