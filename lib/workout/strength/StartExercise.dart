import 'package:flutter/material.dart';
import 'dart:async';

class CrunchesWorkoutPage extends StatefulWidget {
  @override
  _ExerciseTimerScreenState createState() => _ExerciseTimerScreenState();
}

class _ExerciseTimerScreenState extends State<CrunchesWorkoutPage> {
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
            timer.cancel();
            Navigator.pop(context);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // GIF Background
          SizedBox.expand(
            child: Image.asset(
              'assets/gifs/crunches.gif',
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
                // Status Text ("Get Ready"/"Crunches")
                Text(
                  _isReadyPhase ? 'Get Ready' : 'Crunches',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                // Timer
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

          // Pause Button (bottom right)
          Positioned(
            right: 20,
            bottom: 40,
            child: FloatingActionButton(
              onPressed: _togglePause,
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