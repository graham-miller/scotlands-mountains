import 'package:flutter/material.dart';

class AnimatedControl extends StatelessWidget {
  final Animation<double> animation;
  final Axis axis;
  final double openPosition;
  final Widget child;

  const AnimatedControl(
      {required this.animation,
      required this.axis,
      required this.openPosition,
      required this.child,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: animation.value > 0,
      child: Positioned(
        right: axis == Axis.vertical ? 4 : animation.value * openPosition,
        bottom: axis == Axis.horizontal ? 4 : animation.value * openPosition,
        child: child,
      ),
    );
  }
}
