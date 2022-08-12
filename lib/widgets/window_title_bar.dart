import 'dart:io';

import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/widgets.dart';
import 'package:system_tray/system_tray.dart';

class WindowTitleBar extends StatelessWidget {
  const WindowTitleBar({Key? key}) : super(key: key);

  void closeApp() async {
    String path = Platform.isWindows
        ? 'assets/images/tray_icon.ico'
        : 'assets/images/tray_icon.png';

    final SystemTray systemTray = SystemTray();

    await systemTray.initSystemTray(
      title: "Pomodoro Tray",
      toolTip: "Pomodoro Desktop",
      iconPath: path,
    );

    final Menu menu = Menu();
    await menu.buildFrom([
      MenuItemLable(label: 'Show', onClicked: (menuItem) => appWindow.show()),
      MenuItemLable(label: 'Exit', onClicked: (menuItem) => appWindow.close()),
    ]);

    await systemTray.setContextMenu(menu);

    systemTray.registerSystemTrayEventHandler((String eventName) {
      if (eventName == kSystemTrayEventClick) {
        Platform.isWindows ? appWindow.show() : systemTray.popUpContextMenu();
      } else if (eventName == kSystemTrayEventRightClick) {
        Platform.isWindows ? systemTray.popUpContextMenu() : appWindow.show();
      }
    });

    appWindow.hide();
  }

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
            CloseWindowButton(onPressed: closeApp),
          ],
        )
      ],
    ));
  }
}
