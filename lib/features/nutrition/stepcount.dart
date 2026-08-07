import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pedometer/pedometer.dart';
import 'package:permission_handler/permission_handler.dart';

class StepCountScreen extends StatefulWidget {
  const StepCountScreen({super.key});

  @override
  State<StepCountScreen> createState() => _StepCountScreenState();
}

class _StepCountScreenState extends State<StepCountScreen> {
  late Stream<StepCount> _stepCountStream;
  int _steps = 0;
  int _goal = 10000;
  bool _isSensorActive = false;
  String _sensorError = '';

  final List<int> _goals = [6000, 8000, 10000, 12000, 15000];

  // Dummy data for weekly chart
  final List<Map<String, dynamic>> _weeklyData = [
    {'day': 'Mon', 'steps': 7500},
    {'day': 'Tue', 'steps': 10200},
    {'day': 'Wed', 'steps': 8400},
    {'day': 'Thu', 'steps': 11500},
    {'day': 'Fri', 'steps': 5200},
    {'day': 'Sat', 'steps': 14000},
    {'day': 'Sun', 'steps': 0}, // Sun is today in this demo
  ];

  @override
  void initState() {
    super.initState();
    requestPermissionAndStart();
  }

  void requestPermissionAndStart() async {
    var status = await Permission.activityRecognition.request();
    if (status.isGranted) {
      startListening();
    } else {
      setState(() {
        _sensorError = 'Permission denied.';
      });
    }
  }

  void startListening() {
    try {
      _stepCountStream = Pedometer.stepCountStream;
      _stepCountStream.listen(onStepCount).onError(onStepCountError);
      setState(() {
        _isSensorActive = true;
      });
    } catch (e) {
      onStepCountError(e);
    }
  }

  void onStepCount(StepCount event) {
    setState(() {
      _steps = event.steps;
    });
  }

  void onStepCountError(error) {
    setState(() {
      _isSensorActive = false;
      _sensorError = 'Sensor not available.';
    });
  }

  void _addSimulationSteps() {
    setState(() {
      _steps += 500;
      // Update today's steps in the chart
      _weeklyData.last['steps'] = _steps;
    });
  }

  @override
  Widget build(BuildContext context) {
    double progress = (_steps / _goal).clamp(0.0, 1.0);
    double distanceKm = _steps * 0.000762;
    double calories = _steps * 0.04;
    int activeMins = (_steps / 100).floor(); // roughly 100 steps per min

    // If simulating, keep today's chart bar in sync
    _weeklyData.last['steps'] = _steps;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Step Tracker',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            fontSize: 22,
            color: Colors.black87,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.black87),
        actions: [
          if (!_isSensorActive)
            IconButton(
              icon: const Icon(Icons.add_circle_outline_rounded, color: Colors.teal),
              tooltip: 'Simulate +500 steps',
              onPressed: _addSimulationSteps,
            ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            // Error Banner if sensor fails
            if (!_isSensorActive && _sensorError.isNotEmpty)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                margin: const EdgeInsets.only(bottom: 24),
                decoration: BoxDecoration(
                  color: Colors.orange.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.orange.shade200),
                ),
                child: Row(
                  children: [
                    Icon(Icons.warning_rounded, color: Colors.orange.shade700, size: 20),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        "$_sensorError Tap '+' to simulate steps.",
                        style: TextStyle(color: Colors.orange.shade900, fontSize: 13),
                      ),
                    ),
                  ],
                ),
              ),

            // Hero Radial Gauge
            Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 240,
                    height: 240,
                    child: CustomPaint(
                      painter: GradientCircularProgressPainter(
                        progress: progress,
                        gradientColors: [Colors.teal.shade300, Colors.teal.shade700],
                        backgroundColor: Colors.grey.shade200,
                        strokeWidth: 20,
                      ),
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.directions_walk_rounded, color: Colors.teal, size: 36),
                      const SizedBox(height: 8),
                      Text(
                        '$_steps',
                        style: GoogleFonts.poppins(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                          height: 1.0,
                        ),
                      ),
                      Text(
                        '/ $_goal steps',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey.shade500,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Goal Selection Chips
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Daily Goal",
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
            const SizedBox(height: 12),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: _goals.map((goalVal) {
                  final bool isSelected = _goal == goalVal;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: ChoiceChip(
                      label: Text('${(goalVal / 1000).toStringAsFixed(0)}k'),
                      selected: isSelected,
                      onSelected: (selected) {
                        if (selected) {
                          setState(() {
                            _goal = goalVal;
                          });
                        }
                      },
                      selectedColor: Colors.teal.shade600,
                      backgroundColor: Colors.white,
                      labelStyle: TextStyle(
                        color: isSelected ? Colors.white : Colors.black87,
                        fontWeight: FontWeight.bold,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: BorderSide(
                          color: isSelected ? Colors.teal.shade600 : Colors.grey.shade300,
                        ),
                      ),
                      showCheckmark: false,
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 32),

            // Bento Metric Cards
            Row(
              children: [
                Expanded(
                  child: _buildMetricCard(
                    title: 'Distance',
                    value: '${distanceKm.toStringAsFixed(2)} km',
                    icon: Icons.place_rounded,
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildMetricCard(
                    title: 'Calories',
                    value: '${calories.toStringAsFixed(0)} kcal',
                    icon: Icons.local_fire_department_rounded,
                    color: Colors.orange,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildMetricCard(
              title: 'Active Time',
              value: '$activeMins mins',
              icon: Icons.timer_rounded,
              color: Colors.purple,
              isWide: true,
            ),
            const SizedBox(height: 32),

            // Weekly Chart
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "This Week",
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Container(
              height: 180,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.03),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: _weeklyData.map((data) {
                  final int daySteps = data['steps'] as int;
                  final double dayProgress = (daySteps / _goal).clamp(0.0, 1.2);
                  final bool isToday = data['day'] == 'Sun';
                  
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        width: 12,
                        height: 100 * dayProgress,
                        decoration: BoxDecoration(
                          color: isToday ? Colors.teal : Colors.teal.shade100,
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        data['day'],
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
                          color: isToday ? Colors.teal : Colors.grey.shade500,
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricCard({
    required String title,
    required String value,
    required IconData icon,
    required MaterialColor color,
    bool isWide = false,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.shade50,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color.shade600, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(color: Colors.grey.shade500, fontSize: 13, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black87),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Custom Painter for Gradient Radial Ring
class GradientCircularProgressPainter extends CustomPainter {
  final double progress;
  final List<Color> gradientColors;
  final Color backgroundColor;
  final double strokeWidth;

  GradientCircularProgressPainter({
    required this.progress,
    required this.gradientColors,
    required this.backgroundColor,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint backgroundPaint = Paint()
      ..color = backgroundColor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    Offset center = Offset(size.width / 2, size.height / 2);
    double radius = min(size.width / 2, size.height / 2) - strokeWidth / 2;

    // Draw background ring
    canvas.drawCircle(center, radius, backgroundPaint);

    // Draw progress ring with gradient
    Rect rect = Rect.fromCircle(center: center, radius: radius);
    Paint progressPaint = Paint()
      ..shader = SweepGradient(
        colors: gradientColors,
        startAngle: -pi / 2,
        endAngle: 3 * pi / 2,
      ).createShader(rect)
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    double sweepAngle = 2 * pi * progress;
    canvas.drawArc(rect, -pi / 2, sweepAngle, false, progressPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true; // Simple repaint always
  }
}
