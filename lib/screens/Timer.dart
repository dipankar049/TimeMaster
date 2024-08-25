import 'package:flutter/material.dart';
import 'dart:async';

class TimerScreen extends StatefulWidget {
  @override
  _TimerScreenState createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  int totalTimeInSeconds = 60; 
  int remainingTimeInSeconds = 60;
  Timer? timer;
  bool isPaused = false;
  final TextEditingController customTime = TextEditingController();
  int? customMin = 5;

  void startTimer() {
    if (timer != null && timer!.isActive) return;

    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (remainingTimeInSeconds > 0) {
          remainingTimeInSeconds--;
        } else {
          timer.cancel();
        }
      });
    });
  }

  void setTime() {
    resetTimer();
    setState(() {
      customMin = int.tryParse(customTime.text);
      totalTimeInSeconds = customMin! * 60;
      remainingTimeInSeconds = customMin! * 60;
    });
  }

  void pauseOrResumeTimer() {
    setState(() {
      if (isPaused) {
        startTimer(); 
        isPaused = false;
      } else {
        timer?.cancel(); 
        isPaused = true;
      }
    });
  }

  void resetTimer() {
    timer?.cancel();
    setState(() {
      remainingTimeInSeconds = totalTimeInSeconds;
      isPaused = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Flutter Timer'),
      // ),
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              _formatTime(remainingTimeInSeconds),
              style: const TextStyle(fontSize: 48,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>
              [
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed:
                      timer?.isActive == true ? pauseOrResumeTimer : startTimer,
                  child: Text(
                    timer?.isActive == true ? 'Pause' : 
                    (isPaused ? 'Resume' : 'Start'),
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
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                  SizedBox(
                    width: 160,
                    height: 34,
                    child: TextField(
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                      controller: customTime,
                      decoration: const InputDecoration(
                        labelText: "Time(min)",
                        labelStyle: TextStyle(
                          color: Colors.white,
                        ),
                        border: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white), // Unfocused border color
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white, width: 2.0), // Border color when focused
                        ),
                      ),
                    ),
                  ),

                const SizedBox(width: 20),
                SizedBox(
                  height: 34,
                  width: 80,
                  child: ElevatedButton(
                    onPressed: setTime,
                    style: ButtonStyle(
                      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0), // Adjust the radius here
                        ),
                      ),
                      // backgroundColor: WidgetStateProperty<>,
                      side: WidgetStateProperty.all<BorderSide>(
                        const BorderSide(color: Colors.black), // Adjust the color and width
                      ),
                    ),
                    child: const Text('Set',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _formatTime(int totalSeconds) {
    int minutes = totalSeconds ~/ 60;
    int seconds = totalSeconds % 60;

    String minutesStr = minutes.toString().padLeft(2, '0');
    String secondsStr = seconds.toString().padLeft(2, '0');

    return "$minutesStr:$secondsStr";
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }
}
