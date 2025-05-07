import 'dart:ui';
import 'package:flutter/material.dart';
import 'Exercise Details/Crunches.dart';
import 'Exercise Details/LegLifts.dart';
import 'Exercise Details/SidePlankRaises.dart';
import 'Exercise Details/ToeTouches.dart';
import 'StartExercise.dart';

class Exercise {
  final String name;
  final String duration;
  final String imagePath;

  Exercise({required this.name, required this.duration,required this.imagePath});
}

class ExerciseDetailPage extends StatelessWidget {
  final Exercise exercise;

  const ExerciseDetailPage({required this.exercise});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(exercise.name)),
      body: Column(
        children: [
          Image.asset(exercise.imagePath),
          Text('Duration: ${exercise.duration}'),
          Text('Instructions will go here'),
        ],
      ),
    );
  }
}
class Sixpack extends StatefulWidget{
  @override
  State<Sixpack> createState() => _SixpackState();
}

class _SixpackState extends State<Sixpack> {
  final List<Exercise> exercises = [
    Exercise(
      name: 'Crunches',
      duration: '30 s',
      imagePath: 'assets/images/crunches.png',
    ),
    Exercise(
      name: 'Side Plank Raises',
      duration: '30 s',
      imagePath: 'assets/images/sideplank.jpg',
    ),
    Exercise(
      name: 'Leg Lifts',
      duration: '30 s',
      imagePath: 'assets/images/leglifts.png',
    ),
    Exercise(
      name: 'Toe Touches',
      duration: '30 s',
      imagePath: 'assets/images/toetouch.png',
    ),
  ];
  double _selectedMinutes = 15; // Initialize with default time value (15 minutes)

  void _updateMinutes(double newMinutes) {
    setState(() {
      _selectedMinutes = newMinutes; // Update the time
    });
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Image.asset(
                  'assets/images/sixpack.png',
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
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      'Insance Six Pack',
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 28,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Ab workout that will get you a shredded six-pack in no time.',
                    style: TextStyle(fontSize: 16, color: Colors.black54),
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
                  SizedBox(height: 10),
                  Column(
                    children: exercises
                        .map((exercise) => ExerciseItem(exercise: exercise))
                        .toList(),
                  ),
                  SizedBox(height: 80), // Enough bottom padding so content doesn't clash with button
                ],
              ),
            ),
          ],
        ),
      ),

      // 🔥 fixed bottom button outside scrollview
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        child: SafeArea(
          top: false,
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => StartExercise()));
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
class ExerciseItem extends StatelessWidget {
  final Exercise exercise;

  const ExerciseItem({required this.exercise});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8),
      color: Colors.grey[100],
      child: InkWell(
        onTap: () {
          // Navigation based on exercise name
          switch(exercise.name) {
            case 'Crunches':
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Crunches(),
                ),
              );
              break;
            case 'Side Plank Raises':
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) => SidePlankRaises()));
              break;
            case 'Leg Lifts':
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) => LegLifts()));
              break;
            case 'Toe Touches':
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) => ToeTouches()));
              break;
          }
        },
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Row(
            children: [
              Image.asset(exercise.imagePath, width: 60, height: 60),
              SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(exercise.name,
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(exercise.duration),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
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

