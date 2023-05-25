import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class BreathingImportanceScreen extends StatelessWidget {
  const BreathingImportanceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text('Importance of Breathing Exercises'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16),
            _buildBenefitItem(
              'Reduces stress and anxiety',
              'Breathing exercises are a natural way to reduce stress and anxiety. By focusing on your breath and slowing it down, you can calm your mind and body.',
              Icons.favorite_border,
              Colors.pink,
            ),
            SizedBox(height: 16),
            _buildBenefitItem(
              'Improves focus and concentration',
              'Breathing exercises can help improve your focus and concentration by increasing the amount of oxygen to your brain.',
              Icons.lightbulb_outline,
              Colors.yellow[700]!,
            ),
            SizedBox(height: 16),
            _buildBenefitItem(
              'Boosts immunity',
              'Deep breathing exercises have been shown to boost the immune system by increasing the production of white blood cells.',
              Icons.medical_services_outlined,
              Colors.green,
            ),
            SizedBox(height: 16),
            _buildBenefitItem(
              'Improves sleep',
              'Breathing exercises can help you sleep better by promoting relaxation and reducing stress and anxiety.',
              Icons.nightlight_round,
              Colors.blue,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBenefitItem(
      String title, String description, IconData iconData, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            blurRadius: 10,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                iconData,
                color: color,
                size: 24,
              ),
              SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  color: color,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Text(
            description,
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
/////////////////////////////////////////////////

class BreathingExercise extends StatefulWidget {
  @override
  _BreathingExerciseState createState() => _BreathingExerciseState();
}

class _BreathingExerciseState extends State<BreathingExercise> {
  Timer? _timer;
  int _secondsRemaining = 5;
  int _breathingPhase = 0;
  int _currentRound = 1;
  int _totalRounds = 5;
  bool _isPlayButtonDisabled = false;

  @override
  void initState() {
    super.initState();
    _breathingPhase = 0;
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _secondsRemaining = 5;
    _isPlayButtonDisabled = true;
    _timer = Timer.periodic(Duration(seconds: 1), (_) {
      setState(() {
        _secondsRemaining--;
        if (_secondsRemaining <= 0) {
          _timer?.cancel();
          if (_breathingPhase < 2) {
            _breathingPhase++;
            _secondsRemaining = 5;
            _startTimer();
          } else {
            _breathingPhase = 0;
            _currentRound++;
            if (_currentRound > _totalRounds) {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text("Congratulations!"),
                    content: Text("You have completed the breathing exercise."),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          _stopTimer();
                        },
                        child: Text("OK"),
                      ),
                    ],
                  );
                },
              );
            }
            else {
              _secondsRemaining = 5;
              _startTimer();
            }
          }
        }
      });
    });
  }

  void _stopTimer() {
    setState(() {
      _timer?.cancel();
      _breathingPhase = 0;
      _secondsRemaining = 5;
      _currentRound = 1;
      _isPlayButtonDisabled = false;
    });
  }

  String _getDisplayText() {
    if (_breathingPhase == 0) {
      return 'Inhale for $_secondsRemaining seconds';
    } else if (_breathingPhase == 1) {
      return 'Hold for $_secondsRemaining seconds';
    } else {
      return 'Exhale for $_secondsRemaining seconds';
    }
  }

  String _getRoundText() {
    return 'Round $_currentRound of $_totalRounds';
  }

  Color _getCircleColor() {
    if (_breathingPhase == 0) {
      return Colors.green;
    } else if (_breathingPhase == 1) {
      return Colors.yellow;
    } else {
      return Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
        title: Text('Breathing Exercise'),
    backgroundColor: Colors.indigo,
    elevation: 0,
    ),
    body: Padding(
    padding: const EdgeInsets.all(32.0),
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
    Expanded(
    child: Container(
    decoration: BoxDecoration(
    shape: BoxShape.circle,
    border: Border.all(color: Colors.white, width: 8),
    boxShadow: [
    BoxShadow(
    color: _getCircleColor().withOpacity(0.5),
    blurRadius: 50,
    spreadRadius: 10,
    ),
    ],
    ),
    child: Padding(
    padding: const EdgeInsets.all(32.5),
    child: Stack(children: [
      CircularProgressIndicator(
        strokeWidth: 20,
        backgroundColor: Colors.grey[200],
        valueColor:
        AlwaysStoppedAnimation<Color>(_getCircleColor()),
        value: _secondsRemaining / 5,
      ),
      Center(
        child: Text(
          _getDisplayText(),
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 40),
        ),
      ),
    ]),
    ),
    ),
    ),
      SizedBox(height: 32),
      Text(
        _getRoundText(),
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 24),
      ),
      SizedBox(height: 16),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FloatingActionButton(
            onPressed: _isPlayButtonDisabled ? null : _startTimer,
            backgroundColor: Colors.green,
            child: Icon(Icons.play_arrow),
          ),
          SizedBox(width: 32),
          FloatingActionButton(
            onPressed: _stopTimer,
            backgroundColor: Colors.red,
            child: Icon(Icons.stop),
          ),
        ],
      ),
    ],
    ),
    ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.settings),
              ),
              IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) => BreathingImportanceScreen(),
                    ),
                  );
                },
                icon: Icon(Icons.info_outline),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) => BreathingImportanceScreen(),
            ),
          );
        },
        child: Icon(Icons.info_outline),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
