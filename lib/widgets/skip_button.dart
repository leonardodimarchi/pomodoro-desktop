import 'package:flutter/material.dart';

class SkipButton extends StatefulWidget {
  final bool isActive;
  final void Function() onClick;

  const SkipButton({Key? key, required this.isActive, required this.onClick})
      : super(key: key);

  @override
  State<SkipButton> createState() => _SkipButtonState();
}

class _SkipButtonState extends State<SkipButton> with TickerProviderStateMixin {
  late AnimationController slideAnimationController;
  late Animation<Offset> slideAnimationOffset;

  @override
  void initState() {
    slideAnimationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    slideAnimationOffset =
        Tween<Offset>(begin: const Offset(0.0, 5.0), end: Offset.zero).animate(
            CurvedAnimation(
                parent: slideAnimationController, curve: Curves.elasticInOut));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isActive = widget.isActive;
    void Function() onClick = widget.onClick;

    if (isActive) {
      slideAnimationController.forward();
    } else {
      slideAnimationController.reverse();
    }

    return SlideTransition(
      position: slideAnimationOffset,
      child: AnimatedOpacity(
        opacity: isActive ? 1 : 0,
        duration: const Duration(milliseconds: 500),
        child: MouseRegion(
            cursor:
                isActive ? SystemMouseCursors.click : SystemMouseCursors.basic,
            child: GestureDetector(
              onTap: isActive ? onClick : null,
              child: const Icon(
                Icons.skip_next_rounded,
                color: Colors.red,
                size: 30,
              ),
            )),
      ),
    );
  }
}
