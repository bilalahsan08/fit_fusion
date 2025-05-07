import 'package:flutter/material.dart';

class SidePlankRaises extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100], // 👈 added background color here
      appBar: AppBar(
        title: Text('Side Plank Raises'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              'assets/gifs/sideplank.gif',
              height: 200,
              width: double.infinity,
              fit: BoxFit.fitWidth,
            ),
            Text(
              'Side Plank',
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
            _buildBulletPoint('Lower your hips slowly toward the floor without touching it.'),
            _buildBulletPoint('Pause briefly.'),
            _buildBulletPoint('Raise your hips back up to plank height — squeezing your obliques at the top.'),
            _buildBulletPoint('Keep your shoulders and hips stacked vertically.'),
            _buildBulletPoint('Avoid letting your hips rotate forward or backward.'),
            _buildBulletPoint('Try to relax your neck muscles'),
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
              'Inhale as you lower your hips. Exhale as you raise them back up.',
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
                'assets/images/MFSidePlankRaises.jpg',
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) => Center(
                  child: Icon(Icons.image_not_supported, size: 50),
                ),
              ),
            ),
            Center(
              child: Text(
                'Obliques, Transverse Abdominis, Glute Medius, Quadratus Lumborum, Shoulders, Glutes, Adductors, Lats',
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
