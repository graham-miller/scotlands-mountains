import 'package:flutter/material.dart';

import 'animated_control.dart';
import 'map_interactions.dart';

class RotationToggle extends StatefulWidget {
  final Animation<double> animation;
  final Axis axis;
  final double openPosition;
  final MapInteractions mapInteractions;

  const RotationToggle(
      {required this.animation,
      required this.axis,
      required this.openPosition,
      required this.mapInteractions,
      super.key});

  @override
  State<RotationToggle> createState() => _RotationToggleState();
}

class _RotationToggleState extends State<RotationToggle> {
  @override
  Widget build(BuildContext context) {
    return AnimatedControl(
      animation: widget.animation,
      axis: widget.axis,
      openPosition: widget.openPosition,
      child: Material(
        color: const Color.fromRGBO(0, 0, 0, 0),
        child: Ink(
          decoration: const ShapeDecoration(
            color: Color.fromRGBO(255, 255, 255, 0.8),
            shape: CircleBorder(),
          ),
          child: IconButton(
            icon: Icon(widget.mapInteractions.canRotate
                ? Icons.explore_off_outlined
                : Icons.explore_outlined),
            onPressed: () {
              widget.mapInteractions.canRotate
                  ? widget.mapInteractions.disableRotation()
                  : widget.mapInteractions.enableRotation();
              setState(() {});
            },
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
