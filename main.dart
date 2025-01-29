import 'package:flutter/material.dart';
import 'dart:async';

void main() => runApp(StopwatchApp());

class StopwatchApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: StopwatchHomePage(),
    );
  }
}

class StopwatchHomePage extends StatefulWidget {
  @override
  _StopwatchHomePageState createState() => _StopwatchHomePageState();
}

class _StopwatchHomePageState extends State<StopwatchHomePage> {
  late Timer _timer;
  int _milliseconds = 0;
  bool _isRunning = false;

  void _startStopwatch() {
    if (_isRunning) {
      _timer.cancel();
    } else {
      _timer = Timer.periodic(Duration(milliseconds: 10), _onTick);
    }
    setState(() {
      _isRunning = !_isRunning;
    });
  }

  void _onTick(Timer timer) {
    setState(() {
      _milliseconds++;
    });
  }

  void _resetStopwatch() {
    setState(() {
      _milliseconds = 0;
      _isRunning = false;
    });
    _timer.cancel();
  }

  String _formatTime(int milliseconds) {
    int minutes = (milliseconds / 6000).floor();
    int seconds = ((milliseconds % 6000) / 100).floor();
    int ms = milliseconds % 100;

    return "${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}:${ms.toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stopwatch'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _formatTime(_milliseconds),
              style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _startStopwatch,
                  child: Text(_isRunning ? 'Pause' : 'Start'),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: _resetStopwatch,
                  child: Text('Reset'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

