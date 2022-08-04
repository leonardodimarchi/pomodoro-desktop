import 'package:flutter/material.dart';
import 'package:pomodoro_desktop/widgets/window_title_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const WindowTitleBar(),
          Column(
            children: [
              const Text('25:00'),
              Row(
                children: [
                  TextButton(onPressed: () {}, child: const Text('Start')),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
