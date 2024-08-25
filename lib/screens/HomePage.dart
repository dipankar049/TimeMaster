import 'package:flutter/material.dart';
import 'package:stop_watch/screens/StopWatch.dart';
import 'package:stop_watch/screens/Timer.dart';

class HomePage extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 20,
        backgroundColor: Colors.black,
        bottom: const TabBar(
          indicatorColor: Colors.white,
          dividerHeight: 0,
          labelStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
          tabs: [
            Tab(text: 'StopWatch',),
            Tab(text: 'Timer'),
          ],
        ),
      ),
      backgroundColor: Colors.black,
      body: TabBarView(
        children: [ 
          Center(
            child: StopWatchScreen(),
          ),
          Center(
            child: TimerScreen(),
          )
        ],
      )
    );
  }
}
