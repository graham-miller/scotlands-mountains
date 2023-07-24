import 'package:flutter/material.dart';

import 'animated_control.dart';

class Button extends StatelessWidget {
  final Animation<double> animation;
  final IconData icon;
  final Axis axis;
  final double openPosition;
  final Function onPressed;
  final bool enabled;

  const Button(
      {required this.animation,
      required this.icon,
      required this.axis,
      required this.openPosition,
      required this.onPressed,
      this.enabled = true,
      super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedControl(
      animation: animation,
      axis: axis,
      openPosition: openPosition,
      child: Material(
        color: const Color.fromRGBO(0, 0, 0, 0),
        child: Ink(
          decoration: const ShapeDecoration(
            color: Color.fromRGBO(255, 255, 255, 0.8),
            shape: CircleBorder(),
          ),
          child: IconButton(
            icon: Icon(icon),
            onPressed: enabled
                ? () {
                    onPressed();
                  }
                : null,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
