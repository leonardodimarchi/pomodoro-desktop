import 'package:flutter/material.dart';

class SkipDialog extends StatelessWidget {
  final void Function() onPressed;

  const SkipDialog({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
            title: const Text('Please Confirm'),
            content: const Text('Are you sure you want to skip the round?'),
            actions: [
              TextButton(
                  onPressed: () {
                    onPressed();

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
  }
}