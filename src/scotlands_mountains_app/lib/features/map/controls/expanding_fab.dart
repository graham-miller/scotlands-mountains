import 'package:flutter/material.dart';

import 'layer_selector.dart';
import 'map_interactions.dart';
import 'button.dart';
import 'rotation_toggle.dart';

class ExpandingFab extends StatefulWidget {
  final MapInteractions mapInteractions;

  const ExpandingFab({
    super.key,
    required this.mapInteractions,
  });

  @override
  State<ExpandingFab> createState() => _ExpandingFabState();
}

class _ExpandingFabState extends State<ExpandingFab>
    with SingleTickerProviderStateMixin {
  late Animation<double> _animation;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        duration: const Duration(milliseconds: 200), vsync: this);
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller)
      ..addListener(() {
        setState(() {
          // The state that has changed here is the animation object’s value.
        });
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox.expand(
        child: Stack(
          alignment: Alignment.bottomRight,
          children: [
            ..._buildAnimatedControls(),
            ..._buildOpenCloseButton(),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildAnimatedControls() {
    return [
      LayerSelector(
        animation: _animation,
        mapInteractions: widget.mapInteractions,
        axis: Axis.horizontal,
        openPosition: 70,
      ),
      Button(
        animation: _animation,
        icon: Icons.zoom_in,
        axis: Axis.vertical,
        openPosition: 280,
        enabled: widget.mapInteractions.canZoomIn,
        onPressed: () => widget.mapInteractions.zoomIn(),
      ),
      Button(
        animation: _animation,
        icon: Icons.zoom_out,
        axis: Axis.vertical,
        openPosition: 210,
        enabled: widget.mapInteractions.canZoomOut,
        onPressed: () => widget.mapInteractions.zoomOut(),
      ),
      RotationToggle(
        animation: _animation,
        axis: Axis.vertical,
        openPosition: 140,
        mapInteractions: widget.mapInteractions,
      ),
      Button(
        animation: _animation,
        icon: Icons.home_outlined,
        axis: Axis.vertical,
        openPosition: 70,
        onPressed: () => widget.mapInteractions.reset(),
      ),
    ];
  }

  List<Widget> _buildOpenCloseButton() {
    return [
      Visibility(
        visible: _animation.value == 1,
        child: Opacity(
          opacity: _animation.value,
          child: FloatingActionButton(
            onPressed: () {
              _controller.reverse();
            },
            child: const Icon(Icons.close),
          ),
        ),
      ),
      Visibility(
        visible: _animation.value == 0,
        child: Opacity(
          opacity: 1 - _animation.value,
          child: FloatingActionButton(
            onPressed: () {
              _controller.forward();
            },
            child: const Icon(Icons.settings),
          ),
        ),
      ),
    ];
  }
}
