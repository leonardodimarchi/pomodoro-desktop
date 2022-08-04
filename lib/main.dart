import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:pomodoro_desktop/home.dart';

void main() {
  runApp(const MyApp());
  doWhenWindowReady(() {
    appWindow.size = const Size(700, 600);
    appWindow.title = 'Pomodoro Desktop';
    appWindow.show();
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pomodoro Desktop',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const HomePage(),
    );
  }
}
