
import 'package:flutter/material.dart';

class ToeTouches extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100], // 👈 added background color here
      appBar: AppBar(
        title: Text('Toe Touches'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              'assets/gifs/ToeTouches.gif',
              height: 200,
              width: double.infinity,
              fit: BoxFit.fitWidth,
            ),
            Text(
              'Toe Touches',
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
            Chip(
              label: Text('Abs & Core'),
              backgroundColor: Colors.grey[100],
            ),
            SizedBox(height: 24),
            Divider(height: 1, thickness: 1),
            SizedBox(height: 16),
            Text(
              'Hints',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            _buildBulletPoint('Keep your legs extended and as straight as possible.'),
            _buildBulletPoint('Engage your core before starting the movement.'),
            _buildBulletPoint('Reach toward your toes using your upper abs, not your neck.'),
            _buildBulletPoint('Avoid pulling your head or neck forward.'),
            _buildBulletPoint('Control the lowering phase — don’t drop back suddenly.'),
            SizedBox(height: 24),
            Divider(height: 1, thickness: 1),
            SizedBox(height: 16),

            Text(
              'Breathing',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Exhale as you crunch up to reach your toes. Inhale as you lower back down.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),


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
                color: Colors.grey[100],
              ),
              child: Image.asset(
                'assets/images/MFToeTouches.jpg',
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) => Center(
                  child: Icon(Icons.image_not_supported, size: 50),
                ),
              ),
            ),
            Center(
              child: Text(
                'Rectus Abdominis, Obliques, Hip Flexors',
                style: TextStyle(fontSize: 11),
              ),
            ),
            SizedBox(height: 24),
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
