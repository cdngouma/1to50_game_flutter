import 'package:flutter/material.dart';
import 'package:one_to_fifty/landing_page/landing_page.dart';
import 'package:one_to_fifty/main_game/main_game.dart';
import 'package:one_to_fifty/display_score/display_score.dart';

void main() {
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        "/": (context) => Home(),
        "/game": (context) => const Game(),
        "/win_page": (context) => const WinPage()
      }
  ));
}
