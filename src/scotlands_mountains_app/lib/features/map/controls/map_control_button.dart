import 'package:flutter/material.dart';

class MapControlButton extends StatelessWidget {
  final Animation<double> animation;
  final IconData icon;
  final Axis axis;
  final double openPosition;
  final Function onPressed;
  final bool enabled;

  const MapControlButton(
      {required this.animation,
      required this.icon,
      required this.axis,
      required this.openPosition,
      required this.onPressed,
      this.enabled = true,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: animation.value > 0,
      child: Positioned(
        right: axis == Axis.vertical ? 4 : animation.value * openPosition,
        bottom: axis == Axis.horizontal ? 4 : animation.value * openPosition,
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
            ),
          ),
        ),
      ),
    );
  }
}
