import 'package:flutter/material.dart';
import 'package:one_to_fifty/pages/home.dart';
import 'package:one_to_fifty/pages/game.dart';
import 'package:one_to_fifty/pages/win_page.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      "/": (context) => Home(),
      "/game": (context) => Game(),
      "/win_page": (context) => WinPage()
    }
  ));
}
