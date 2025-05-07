import 'package:flutter/material.dart';
import 'dart:async';

class StartExercise extends StatefulWidget {
  @override
  _SequentialWorkoutPageState createState() => _SequentialWorkoutPageState();
}

class _SequentialWorkoutPageState extends State<StartExercise> {
  List<Map<String, String>> exercises = [
    {
      'title': 'Crunches',
      'gif': 'assets/gifs/crunches.gif',
    },
    {
      'title': 'Side Plank Raises',
      'gif': 'assets/gifs/sideplank.gif',
    },
    {
      'title': 'Leg Raises',
      'gif': 'assets/gifs/LegRaises.gif',
    },
    {
      'title': 'Toe Touches',
      'gif': 'assets/gifs/ToeTouches.gif',
    },
  ];

  int _currentExerciseIndex = 0;
  int _secondsRemaining = 5;
  bool _isReadyPhase = true;
  bool _isPaused = false;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
          (Timer timer) {
        if (_isPaused) return;

        if (_secondsRemaining < 1) {
          if (_isReadyPhase) {
            setState(() {
              _isReadyPhase = false;
              _secondsRemaining = 30;
            });
          } else {
            _goToNextExercise();
          }
        } else {
          setState(() {
            _secondsRemaining--;
          });
        }
      },
    );
  }

  void _togglePause() {
    setState(() {
      _isPaused = !_isPaused;
      if (!_isPaused && _timer == null) {
        _startTimer();
      }
    });
  }

  void _goToNextExercise() {
    if (_currentExerciseIndex < exercises.length - 1) {
      setState(() {
        _currentExerciseIndex++;
        _resetExercise();
      });
    } else {
      // all exercises done
      _timer?.cancel();
      Navigator.pop(context);
    }
  }

  void _resetExercise() {
    _isReadyPhase = true;
    _secondsRemaining = 5;
    _isPaused = false;
  }

  @override
  Widget build(BuildContext context) {
    var currentExercise = exercises[_currentExerciseIndex];

    return Scaffold(
      body: Stack(
        children: [
          // GIF Background
          SizedBox.expand(
            child: Image.asset(
              currentExercise['gif']!,
              fit: BoxFit.fitWidth,
              errorBuilder: (context, error, stackTrace) => Container(
                color: Colors.blue,
              ),
            ),
          ),

          // Dark overlay
          Container(
            color: Colors.black.withOpacity(0.3),
          ),

          // Bottom Left Content Group
          Positioned(
            left: 20,
            bottom: 40,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _isReadyPhase ? 'Get Ready' : currentExercise['title']!,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  '0:${_secondsRemaining.toString().padLeft(2, '0')}',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          // Next & Pause Buttons (bottom right)
          Positioned(
            right: 20,
            bottom: 110,
            child: FloatingActionButton(
              onPressed: _goToNextExercise,
              heroTag: 'nextBtn',
              child: Icon(
                Icons.skip_next,
                size: 28,
              ),
              backgroundColor: Colors.green.withOpacity(0.8),
              elevation: 4,
              mini: true,
            ),
          ),

          Positioned(
            right: 20,
            bottom: 40,
            child: FloatingActionButton(
              onPressed: _togglePause,
              heroTag: 'pauseBtn',
              child: Icon(
                _isPaused ? Icons.play_arrow : Icons.pause,
                size: 28,
              ),
              backgroundColor: Colors.blue.withOpacity(0.8),
              elevation: 4,
              mini: true,
            ),
          ),
        ],
      ),
    );
  }
}
