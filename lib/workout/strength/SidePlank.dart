import 'package:flutter/material.dart';

class Crunches extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crunches'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              'assets/gifs/crunches.gif',
              height: 200,
              width: double.infinity,
              fit: BoxFit.contain,
            ),
            Text(
              'Crunches',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Instructions',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.blue[800],
              ),
            ),
            SizedBox(height: 16),

            // Category Chip

            Chip(
              label: Text('Abs & Core'),
              backgroundColor: Colors.blue[50],
            ),
            SizedBox(height: 24),
            Divider(height: 1, thickness: 1),
            SizedBox(height: 16),

            // Hints Section
            Text(
              'Hints',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            _buildBulletPoint('Use your abdominals to get up, your neck and shoulders are relaxed'),
            _buildBulletPoint('Do not pull on your neck with your hands'),
            _buildBulletPoint('Focus on muscle contraction, the range of motion is not important'),
            _buildBulletPoint('Squeeze your shoulder blades together'),
            _buildBulletPoint('Do not shrug your shoulders'),
            _buildBulletPoint('Try to relax your neck muscles'),
            SizedBox(height: 24),
            Divider(height: 1, thickness: 1),
            SizedBox(height: 16),

            // Breathing Section
            Text(
              'Breathing',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Breathe in going down, breathe out going up.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),

            // Breathing Section
            Text(
              'Muscle Focus',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
              SizedBox(height: 8),
            Container(
              height: 320,
              width: double.infinity,
              margin: EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.grey[200], // Fallback color
              ),
              child: Image.asset(
                'assets/images/MFCrunches.jpg', // Your muscle diagram image
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) => Center(
                  child: Icon(Icons.image_not_supported, size: 50),
                ),

              ),

            ),
            Center(
              child: Text(
                'Primary muscles worked: Rectus abdominis, obliques',
                style: TextStyle(fontSize: 11),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildBulletPoint(String text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('• ', style: TextStyle(fontSize: 16)),
          Expanded(
            child: Text(
              text,
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}