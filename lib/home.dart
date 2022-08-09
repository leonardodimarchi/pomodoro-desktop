import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pomodoro_desktop/widgets/window_title_bar.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

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
    } else {
      startTimer();
    }
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        secondsAmount--;

        if (secondsAmount == 0) {
          toggleMode();
        }
      });
    });
  }

  void toggleMode() {
    pause();

    if (isAtBreak) {
      setState(() {
        secondsAmount = 25 * 60;
        isAtBreak = false;
      });
    } else {
      setState(() {
        secondsAmount = 5 * 60;
        isAtBreak = true;
      });
    }
  }

  void pause() {
    setState(() {
      timer?.cancel();
    });
  }

  void skip() {
    showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: const Text('Please Confirm'),
            content: const Text('Are you sure you want to skip the round?'),
            actions: [
              TextButton(
                  onPressed: () {
                    toggleMode();

                    Navigator.of(context).pop();
                  },
                  child: const Text('Yes')),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('No'))
            ],
          );
        });
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
              SleekCircularSlider(
                appearance: CircularSliderAppearance(

                  customWidths: CustomSliderWidths(
                    progressBarWidth: 10,
                  ),
                ),
                innerWidget: (double value) {
                  return Center(child: Text(
                showingTimer,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),);
                },
                initialValue: double.parse(((isAtBreak ? 5 * 60 : 25 * 60) - secondsAmount).toString()),
                min: 0,
                max: isAtBreak ? 5 * 60 : 25 * 60
              ),
              Text(
                showingTimer,
                style: Theme.of(context)
                    .textTheme
                    .displayLarge
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30),
              Wrap(
                spacing: 30,
                direction: Axis.vertical,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: toggleTimer,
                    child: Text(
                        (timer != null && timer!.isActive) ? 'PAUSE' : 'START'),
                    style: ButtonStyle(
                        fixedSize:
                            MaterialStateProperty.all(const Size(200, 50)),
                        textStyle: MaterialStateProperty.resolveWith((states) {
                          return const TextStyle(
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2,
                          );
                        })),
                  ),
                  if (timer != null && timer!.isActive)
                    MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          onTap: skip,
                          child: const Icon(
                            Icons.skip_next_rounded,
                            color: Colors.red,
                            size: 30,
                          ),
                        ))
                ],
              )
            ],
          ))
        ],
      ),
    );
  }
}
