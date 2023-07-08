import 'package:flutter/material.dart';

import 'action_button.dart';
import 'open_close_button.dart';

class MapControls extends StatefulWidget {
  final void Function() onReset;
  final void Function() onSelectOutdoors;
  final void Function() onSelectSatellite;
  final void Function() onSelectStreets;
  final void Function() zoomIn;
  final void Function() zoomOut;
  final bool canZoomIn;
  final bool canZoomOut;

  const MapControls({
    super.key,
    required this.onReset,
    required this.onSelectOutdoors,
    required this.onSelectSatellite,
    required this.onSelectStreets,
    required this.zoomIn,
    required this.zoomOut,
    required this.canZoomIn,
    required this.canZoomOut,
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
            ActionButton(
              animation: _animation,
              icon: Icons.drive_eta_outlined,
              axis: Axis.horizontal,
              openPosition: 210,
              onPressed: () => widget.onSelectStreets(),
            ),
            ActionButton(
              animation: _animation,
              icon: Icons.satellite_outlined,
              axis: Axis.horizontal,
              openPosition: 140,
              onPressed: () => widget.onSelectSatellite(),
            ),
            ActionButton(
              animation: _animation,
              icon: Icons.map_outlined,
              axis: Axis.horizontal,
              openPosition: 70,
              onPressed: () => widget.onSelectOutdoors(),
            ),
            ActionButton(
              animation: _animation,
              icon: Icons.zoom_in,
              axis: Axis.vertical,
              openPosition: 280,
              enabled: widget.canZoomIn,
              onPressed: () => widget.zoomIn(),
            ),
            ActionButton(
              animation: _animation,
              icon: Icons.zoom_out,
              axis: Axis.vertical,
              openPosition: 210,
              enabled: widget.canZoomOut,
              onPressed: () => widget.zoomOut(),
            ),
            ActionButton(
              animation: _animation,
              icon: Icons.explore_outlined,
              axis: Axis.vertical,
              openPosition: 140,
              onPressed: () {},
            ),
            ActionButton(
              animation: _animation,
              icon: Icons.home_outlined,
              axis: Axis.vertical,
              openPosition: 70,
              onPressed: () => widget.onReset(),
            ),
            OpenCloseButton(
              onOpen: () => _controller.forward(),
              onClose: () => _controller.reverse(),
            ),
          ],
        ),
      ),
    );
  }
}
