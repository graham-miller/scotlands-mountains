import 'package:flutter/material.dart';

import 'open_close_button.dart';

class MapControls extends StatefulWidget {
  final void Function() onReset;
  final void Function() onSelectOutdoors;
  final void Function() onSelectSatellite;
  final void Function() onSelectStreets;

  const MapControls({
    super.key,
    required this.onReset,
    required this.onSelectOutdoors,
    required this.onSelectSatellite,
    required this.onSelectStreets,
  });

  @override
  State<MapControls> createState() => _MapControlsState();
}

class _MapControlsState extends State<MapControls>
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
            _buildButton(Icons.drive_eta_outlined, Axis.horizontal, 210,
                () => widget.onSelectStreets()),
            _buildButton(Icons.satellite_outlined, Axis.horizontal, 140,
                () => widget.onSelectSatellite()),
            _buildButton(Icons.map_outlined, Axis.horizontal, 70,
                () => widget.onSelectOutdoors()),
            _buildButton(Icons.zoom_in, Axis.vertical, 280, () {}),
            _buildButton(Icons.zoom_out, Axis.vertical, 210, () {}),
            _buildButton(Icons.explore_outlined, Axis.vertical, 140, () {}),
            _buildButton(
                Icons.home_outlined, Axis.vertical, 70, () => widget.onReset()),
            OpenCloseButton(
              onOpen: () => _controller.forward(),
              onClose: () => _controller.reverse(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(
      IconData icon, Axis axis, double openPosition, Function onPressed) {
    return Positioned(
      right: axis == Axis.vertical ? 6 : _animation.value * openPosition,
      bottom: axis == Axis.horizontal ? 6 : _animation.value * openPosition,
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
