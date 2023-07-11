import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:one_to_fifty/main_game/logic.dart';

import 'game_cell.dart';

class Game extends StatefulWidget {
  const Game({super.key});

  @override
  State<Game> createState() => _Game();
}

class _Game extends State<Game> {
  GameLogic game = GameLogic();
  bool isCompleted = false;

  Duration duration = const Duration();
  Timer? timer;
  int currentTime = 0;
  int bestTime = 86400;

  void handleCellTappedEvent(int cellId) {
    // Start timer if the first cell was pressed
    if(game.nextNumber == 1 && game.getCellValue(cellId) == 1) {
      startTimer();
    }

    isCompleted = game.updateGameState(cellId);

    if(isCompleted) {
      bestTime = min(currentTime, bestTime);
      setState(() {
        isCompleted = isCompleted;
        bestTime = bestTime;
      });

      stopTimer();
      Navigator.popAndPushNamed(
          context, "/win_page",
          arguments: {
            "currentTime": currentTime,
            "bestTime": bestTime
          }
      );
    }
  }

  void startTimer(){
    timer = Timer.periodic(const Duration(seconds: 1),(_) {
      final seconds = duration.inSeconds + 1;
      if (seconds < 0){
        timer?.cancel();
      } else{
        duration = Duration(seconds: seconds);
        currentTime = duration.inSeconds;
        setState(() {
          currentTime = currentTime;
        });
      }
    });
  }

  void stopTimer(){
    duration = const Duration();
    timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ?? <String, dynamic>{}) as Map;
    if(arguments["bestTime"] != null) {
      bestTime = min(arguments["bestTime"], bestTime);
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
                            arguments['bestTime'] != null ? "${bestTime}s" : "-",
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
                            "${game.nextNumber}",
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
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                    children: game.getGridIds().map((idx) => CellWidget(
                        id: idx,
                        value: game.getCellValue(idx),
                        onCellTapped: (int id) {
                          handleCellTappedEvent(id);
                        }
                    )
                    ).toList(),
                  ),
                ),

                Column(
                  children: <Widget>[
                    Text("TIME", style: TextStyle(color: Colors.grey[400])),
                    Text(
                        "${currentTime}s",
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