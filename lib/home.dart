import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pomodoro_desktop/widgets/window_title_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int secondsAmount = 25 * 60;
  bool isAtBreak = false;
  Timer? timer;

  void toggleTimer() {
    if (timer != null && timer!.isActive) {
      pause();

      if (isAtBreak) {
        setState(() {
          secondsAmount = 25 * 60;
          isAtBreak = false;
        });
      } else {
        setState(() {
          secondsAmount = 5 * 60;
          isAtBreak = false;
        });
      }
    } else {
      startTimer();
    }
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        secondsAmount--;
      });
    });
  }

  void pause() {
    timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    int minutes = (secondsAmount / 60).floor();
    int seconds = secondsAmount % 60;

    String showingTimer =
        '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';

    return Scaffold(
      body: Column(
        children: [
          const WindowTitleBar(),
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                showingTimer,
                style: Theme.of(context)
                    .textTheme
                    .displayLarge
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: toggleTimer,
                    child: Text(
                        (timer != null && timer!.isActive) ? 'Stop' : 'Start'),
                  ),
                ],
              )
            ],
          ))
        ],
      ),
    );
  }
}
