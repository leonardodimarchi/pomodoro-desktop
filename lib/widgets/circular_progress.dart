import 'package:flutter/material.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class CircularProgress extends StatelessWidget {
  final Widget Function(double) innerWidget;
  final double value;
  final double? max;
  final double? min;

  const CircularProgress({
    Key? key,
    required this.innerWidget,
    required this.value,
    this.max,
    this.min,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SleekCircularSlider(
      appearance: CircularSliderAppearance(
        size: 300,
        customColors: CustomSliderColors(
          trackColor: Colors.red,
          progressBarColor: Colors.red[900],
          hideShadow: true,
        ),
        customWidths: CustomSliderWidths(
          progressBarWidth: 40,
          trackWidth: 30
        ),
      ),
      innerWidget: innerWidget,
      initialValue: value,
      min: min ?? 0,
      max: max ?? 100,
    );
  }
}
