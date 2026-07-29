import 'package:flutter/material.dart';

class LegLifts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100], // 👈 added background color here
      appBar: AppBar(
        title: Text('Legs Lift'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              'assets/gifs/LegRaises.gif',
              height: 200,
              width: double.infinity,
              fit: BoxFit.fitWidth,
            ),
            Text(
              'Legs Lift',
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
            _buildBulletPoint('Keep your lower back pressed against the floor throughout the movement.'),
            _buildBulletPoint('Lower your legs slowly to control the movement.'),
            _buildBulletPoint('Avoid using momentum — keep it slow and steady.'),
            _buildBulletPoint('Engage your core and avoid arching your back.'),
            _buildBulletPoint('Keep your legs straight but avoid locking your knees.'),
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
              'Inhale as you lower your legs. Exhale as you raise them back up.',
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
                'assets/images/MFLegRaises.jpg',
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) => Center(
                  child: Icon(Icons.image_not_supported, size: 50),
                ),
              ),
            ),
            Center(
              child: Text(
                'Lower Abs, Hip Flexors, Rectus Abdominis, Obliques, Quadriceps',
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
