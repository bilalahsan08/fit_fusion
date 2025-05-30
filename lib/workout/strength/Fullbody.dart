import 'dart:ui';
import 'package:flutter/material.dart';

class Fullbody extends StatefulWidget {
  @override
  _FullbodyState createState() => _FullbodyState();
}

class _FullbodyState extends State<Fullbody> {
  double _selectedMinutes = 15; // Initialize with default time value (15 minutes)

  void _updateMinutes(double newMinutes) {
    setState(() {
      _selectedMinutes = newMinutes; // Update the time
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Stack(
        children: [
          Image.asset(
            'assets/images/fullbody.png', // Make sure this path exists
            width: double.infinity,
            height: 220,
            fit: BoxFit.cover,
          ),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Container(
                color: Colors.black.withOpacity(0.1),
              ),
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    SizedBox(height: 10),
                    Center(
                      child: Text(
                        'Full Body',
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 28,
                          color: Colors.white.withOpacity(0.8),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Ab workout that will get you a shredded six-pack in no time.',
                      style: TextStyle(fontSize: 16, color: Colors.white.withOpacity(0.8)),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.timer, color: Colors.blue),
                        SizedBox(width: 4),
                        Text("${_selectedMinutes.round()} minutes"),
                        SizedBox(width: 16),
                        Icon(Icons.local_fire_department, color: Colors.orange),
                        SizedBox(width: 4),
                        Text("157 calories"),
                      ],
                    ),
                    SizedBox(height: 40),

                    buildCard(
                      title: 'Music and Sound',
                      icon: Icons.music_note,
                      onPressed: () {},
                    ),
                    SizedBox(height: 20),

                    DurationPickerCard(
                      selectedMinutes: _selectedMinutes,
                      onMinutesChanged: _updateMinutes,
                    ),

                    Divider(height: 1, color: Colors.grey.withOpacity(0.2)),

                    buildCard(
                      title: 'Fitness Tools',
                      icon: Icons.fitness_center_rounded,
                      onPressed: () {},
                    ),
                    Divider(height: 1, color: Colors.grey.withOpacity(0.2)),

                    buildCard(
                      title: 'Start with warmup',
                      icon: Icons.loop,
                      onPressed: () {},
                      trailing: WarmupToggle(),
                    ),
                    SizedBox(height: 20),

                    Text(
                      'Exercise List',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.all(16),
              child: SafeArea(
                top: false,
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // Start action
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 16),
                      textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: Text('Start'),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Duration picker card (minutes only)
class DurationPickerCard extends StatelessWidget {
  final double selectedMinutes;
  final ValueChanged<double> onMinutesChanged;

  DurationPickerCard({
    required this.selectedMinutes,
    required this.onMinutesChanged,
  });

  @override
  Widget build(BuildContext context) {
    return buildCard(
      title: 'Duration',
      icon: Icons.timer,
      onPressed: () {},
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '${selectedMinutes.round()} min',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(width: 10),
          IconButton(
            icon: Icon(Icons.access_time_sharp),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (context) => StatefulBuilder(
                  builder: (context, setStateBottomSheet) {
                    double localValue = selectedMinutes;
                    return Container(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Select Workout Duration (min)',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                          ),
                          Slider(
                            value: localValue,
                            min: 5,
                            max: 90,
                            divisions: 17,
                            label: '${localValue.round()} min',
                            onChanged: (value) {
                              setStateBottomSheet(() {
                                localValue = value;
                              });
                              onMinutesChanged(value); // Update the minutes
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
              );
            },
          )
        ],
      ),
    );
  }
}

// Modified buildCard function to support trailing widget
Widget buildCard({
  required String title,
  required IconData icon,
  required VoidCallback onPressed,
  Widget? trailing,
}) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white.withOpacity(0.7),
      borderRadius: BorderRadius.circular(4),
    ),
    child: InkWell(
      onTap: onPressed,
      splashColor: Colors.grey.withOpacity(0.2),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        height: 60,
        width: double.infinity,
        child: Row(
          children: [
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
              ),
            ),
            if (trailing != null) trailing,
          ],
        ),
      ),
    ),
  );
}

// Warmup toggle widget
class WarmupToggle extends StatefulWidget {
  @override
  _WarmupToggleState createState() => _WarmupToggleState();
}

class _WarmupToggleState extends State<WarmupToggle> {
  bool isOn = false;

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: isOn,
      onChanged: (value) {
        setState(() {
          isOn = value;
        });
      },
      activeColor: Colors.blue,
    );
  }
}
