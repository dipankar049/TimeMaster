import 'package:flutter/material.dart';
import 'dart:async';

class StopWatchScreen extends StatefulWidget {
  @override
  State<StopWatchScreen> createState() => _HomePageState();
}

class _HomePageState extends State<StopWatchScreen> {
  late Stopwatch stopwatch;
  late Timer timer;

  @override
  void initState() {
    super.initState();
    stopwatch = Stopwatch();
  }

  void startTimer() {
    timer = Timer.periodic(Duration(milliseconds: 100), (timer) {
      setState(() {});
    });
    stopwatch.start();
  }

  void stopTimer() {
    stopwatch.stop();
  }

  void resetTimer() {
    stopTimer();
    stopwatch.reset();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body:  Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              _formatTime(stopwatch.elapsedMilliseconds),
              style: const TextStyle(fontSize: 48, color: Colors.white),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: stopwatch.isRunning ? stopTimer : startTimer,
                  style: ButtonStyle(
                    
                  ),
                  child: Text(stopwatch.isRunning ? 'Pause' : 
                  (stopwatch.elapsedMilliseconds == 0 ? 'Start' : 'Resume'),
                  style: const TextStyle(color: Colors.black),
                  ),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: resetTimer,
                  child: const Text('Reset',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _formatTime(int milliseconds) {
    int hundreds = (milliseconds / 10).truncate();
    int seconds = (hundreds / 100).truncate();
    int minutes = (seconds / 60).truncate();

    String hundredsStr = (hundreds % 100).toString().padLeft(2, '0');
    String secondsStr = (seconds % 60).toString().padLeft(2, '0');
    String minutesStr = minutes.toString().padLeft(2, '0');

    return "$minutesStr:$secondsStr.$hundredsStr";
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }
}
