import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/widgets.dart';

class WindowTitleBar extends StatelessWidget {
  const WindowTitleBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WindowTitleBarBox(
        child: Row(
      children: [
        Expanded(child: MoveWindow()),
        Row(
          children: [
            MinimizeWindowButton(),
            MaximizeWindowButton(),
            CloseWindowButton(),
          ],
        )
      ],
    ));
  }
}
