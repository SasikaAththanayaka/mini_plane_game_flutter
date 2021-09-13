import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mini_plane/MyPlane.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static double planeYAxis = 0;
  double time = 0;
  double height = 0;
  double initialHeight = planeYAxis;
  bool gameHasStarted = false;

  void jump() {
    setState(() {
      time = 0;
      initialHeight = planeYAxis;
    });
  }

  void startGame() {
    gameHasStarted = true;
    Timer.periodic(Duration(milliseconds: 60), (timer) {
      time += 0.05;
      height = -4.9 * time * time + 2.8 * time;
      setState(() {
        planeYAxis = initialHeight - height;
      });
      if (planeYAxis > 1) {
        timer.cancel();
        gameHasStarted = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
              flex: 2,
              child: GestureDetector(
                onTap: () {
                  if (gameHasStarted) {
                    jump();
                  } else {
                    startGame();
                  }
                },
                child: AnimatedContainer(
                  alignment: Alignment(0, planeYAxis),
                  duration: Duration(milliseconds: 0),
                  color: Colors.blue,
                  child: MyPlane(),
                ),
              )),
          Container(
            height: 25.0,
            color: Colors.green,
          ),
          Expanded(
              child: Container(
            color: Colors.brown,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Score",
                      style: TextStyle(color: Colors.white, fontSize: 20.0),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      "0",
                      style: TextStyle(color: Colors.white, fontSize: 30.0),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Best",
                      style: TextStyle(color: Colors.white, fontSize: 20.0),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      "10",
                      style: TextStyle(color: Colors.white, fontSize: 30.0),
                    ),
                  ],
                )
              ],
            ),
          )),
        ],
      ),
    );
  }
}
