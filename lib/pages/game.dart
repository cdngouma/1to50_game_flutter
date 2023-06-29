import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:one_to_fifty/board.dart';

class Game extends StatefulWidget {
  @override
  State<Game> createState() => _Game();
}

class _Game extends State<Game> {
  Board board = Board();
  int nextNumber = 1;
  int currentTime = 0;
  int bestTime = 86400;

  Duration duration = Duration();
  Timer? timer;

  void startTimer(){
    timer = Timer.periodic(Duration(seconds: 1),(_) {
      setState(() {
        final seconds = duration.inSeconds + 1;
        if (seconds < 0){
          timer?.cancel();
        } else{
          duration = Duration(seconds: seconds);
        }
      });
    });
  }

  void stopTimer(){
    duration = Duration();
    setState(() => timer?.cancel());
  }

  int getTime() {
    final time = duration.inSeconds;
    currentTime = time;
    return time;
  }

  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ?? <String, dynamic>{}) as Map;
    print("======= ${bestTime} --> ${arguments['bestTime']}");
    if(arguments["bestTime"] != null) {
      bestTime = min(arguments["bestTime"], bestTime);
      setState(() {
        bestTime = bestTime;
      });
    }

    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        backgroundColor: Colors.grey[850],
        title: const Text("1 to 50 Game")
      ),
      body: Center(
        child: Expanded(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(30, 45, 30, 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Text(
                            "BEST TIME",
                            style: TextStyle(
                                color: Colors.grey[400],
                                letterSpacing: 2.0
                            )
                        ),
                        const SizedBox(height: 10),
                        Text(
                            arguments['bestTime'] != null ? "${bestTime}s" : "N/A",
                            style: const TextStyle(
                                color: Colors.amber,
                                fontSize: 20.0,
                                letterSpacing: 2.0
                            )
                        ),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Text(
                            "NEXT NUMBER",
                            style: TextStyle(
                                color: Colors.grey[400],
                                letterSpacing: 2.0
                            )
                        ),
                        const SizedBox(height: 10),
                        Text(
                            "${nextNumber}",
                            style: const TextStyle(
                                color: Colors.amber,
                                fontSize: 20.0,
                                letterSpacing: 2.0
                            )
                        ),
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 10.0),
                const Divider(height: 25.0, color: Colors.white12),
                const SizedBox(height: 10.0),

                // Main Game Grid
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 5,
                    children: board.gridIndices.map((idx) => InkWell(
                      onTap: () {
                          if(nextNumber == 1 && board.gridValues[idx] == 1) {
                            startTimer();
                          }

                          board.updateCell(idx);
                          setState(() {
                            nextNumber = board.nextNumber;
                          });

                          bool isCompleted = board.isCompleted();
                          if(isCompleted) {
                            setState(() {
                              bestTime = min(bestTime, currentTime);
                            });

                            bestTime = min(currentTime, bestTime);

                            stopTimer();

                            Navigator.popAndPushNamed(
                                context, "/win_page",
                                arguments: {"currentTime": currentTime, "bestTime": bestTime}
                            );
                          }
                        },
                      child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Container(
                            alignment: Alignment.center,
                            color: board.gridValues[idx] == 0 ? Colors.black54 : (board.gridValues[idx] ?? 0) > 25 ? Colors.amber : Colors.amber[300],
                            child: Text(
                                "${board.gridValues[idx] == 0 ? '' : board.gridValues[idx]}",
                                style: const TextStyle(
                                  fontSize: 25.0,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 2.0,
                                ),
                            ),
                          )
                      ),
                    )).toList(),
                  ),
                ),

                Column(
                  children: <Widget>[
                    Text("TIME", style: TextStyle(color: Colors.grey[400])),
                    Text(
                        "${getTime()}s",
                        style: TextStyle(color: Colors.grey[400], fontSize: 40.0))
                  ],
                )
              ],
            )
          ),
        ),
      ),
    );
  }
}