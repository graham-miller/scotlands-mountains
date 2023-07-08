import 'package:flutter/material.dart';

class ActionButton extends StatelessWidget {
  final Animation<double> animation;
  final IconData icon;
  final Axis axis;
  final double openPosition;
  final Function onPressed;

  const ActionButton(
      {required this.animation,
      required this.icon,
      required this.axis,
      required this.openPosition,
      required this.onPressed,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: axis == Axis.vertical ? 6 : animation.value * openPosition,
      bottom: axis == Axis.horizontal ? 6 : animation.value * openPosition,
      child: Material(
        color: const Color.fromRGBO(0, 0, 0, 0),
        child: Ink(
          decoration: const ShapeDecoration(
            color: Color.fromRGBO(255, 255, 255, 0.8),
            shape: CircleBorder(),
          ),
          child: IconButton(
            icon: Icon(icon),
            onPressed: () {
              onPressed();
            },
          ),
        ),
      ),
    );
  }
}
