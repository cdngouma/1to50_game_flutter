import 'package:flutter/material.dart';

class WinPage extends StatelessWidget {
  const WinPage({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ?? <String, dynamic>{}) as Map;
    return Scaffold(
        backgroundColor: Colors.grey[900],
        body: Scaffold(
          backgroundColor: Colors.grey[900],
          appBar: AppBar(
              backgroundColor: Colors.grey[850],
              title: const Text("1 to 50 Game")
          ),
          body: Padding(
            padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "YOUR TIME",
                    style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.grey[600],
                        letterSpacing: 2.0
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  Text(
                    "${arguments['currentTime']}s",
                    style: const TextStyle(
                        color: Colors.amber,
                        fontSize: 50.0,
                        letterSpacing: 2.0
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Text(
                    "BEST TIME: ${arguments['bestTime']}s",
                    style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 15.0,
                        letterSpacing: 2.0
                    ),
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.popAndPushNamed(
                          context, "/game",
                          arguments: {"bestTime": arguments['bestTime']}
                      );
                    },
                    child: const Text(
                        "Try Again",
                        style: TextStyle(
                            fontSize: 15.0
                        )
                    ),
                  )
                ],
              ),
            ),
          ),
        )
    );
  }
}
