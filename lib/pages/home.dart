import 'dart:math';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 70.0,
                  child: const FittedBox(
                    fit: BoxFit.cover,
                    child: ImageIcon(
                      AssetImage("lib/assets/number-blocks.png"),
                      color: Colors.amber,
                    ),
                  ),
                ),
                const SizedBox(height: 15.0),
                Text(
                  "1 to 50",
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 20.0,
                    letterSpacing: 2.0,
                  ),
                ),
                const SizedBox(height: 50.0),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, "/game");
                    },
                    child: const Text(
                        "Play",
                        style: TextStyle(
                          fontSize: 15.0
                        )
                    ),
                )
              ],
            ),
          ),
        )
      )
    );
  }
}
