
import 'package:flutter/material.dart';
import 'package:pedometer/pedometer.dart';
import 'package:permission_handler/permission_handler.dart';

class Stepcount extends StatefulWidget {
  @override
  _StepcountState createState() => _StepcountState();
}

class _StepcountState extends State<Stepcount> {
  late Stream<StepCount> _stepCountStream;
  int _steps = 0;

  final int _goal = 10000; // daily step goal

  @override
  void initState() {
    super.initState();
    requestPermissionAndStart();
  }

  void requestPermissionAndStart() async {
    var status = await Permission.activityRecognition.request();
    if (status.isGranted) {
      startListening();
    }
  }

  void startListening() {
    _stepCountStream = Pedometer.stepCountStream;
    _stepCountStream.listen(onStepCount).onError(onStepCountError);
  }

  void onStepCount(StepCount event) {
    setState(() {
      _steps = event.steps;
    });
  }

  void onStepCountError(error) {
    print('Step Count Error: $error');
  }

  @override
  Widget build(BuildContext context) {
    double distance = _steps * 0.000762; // in kilometers
    double calories = _steps * 0.04;
    double progress = (_steps / _goal).clamp(0.0, 1.0);

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Step Track',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.directions_walk, size: 100, color: Colors.teal),
            SizedBox(height: 20),
            Text('Steps Taken:', style: TextStyle(fontSize: 22)),
            Text('$_steps', style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            LinearProgressIndicator(
              value: progress,
              minHeight: 12,
              backgroundColor: Colors.grey[300],
              color: Colors.teal,
            ),
            SizedBox(height: 10),
            Text('${(_steps / _goal * 100).toStringAsFixed(1)}% of $_goal steps',
                style: TextStyle(fontSize: 16, color: Colors.grey[700])),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Text('Distance', style: TextStyle(fontSize: 18)),
                    Text('${distance.toStringAsFixed(2)} km',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
                Column(
                  children: [
                    Text('Calories', style: TextStyle(fontSize: 18)),
                    Text('${calories.toStringAsFixed(0)} kcal',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
