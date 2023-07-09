import 'package:flutter/material.dart';

import 'map_controls_facade.dart';
import 'action_button.dart';
import 'open_close_button.dart';

class MapControls extends StatefulWidget {
  final MapControlsFacade mapControlsFacade;

  const MapControls({
    super.key,
    required this.mapControlsFacade,
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
              onPressed: () => widget.mapControlsFacade.selectStreets(),
            ),
            ActionButton(
              animation: _animation,
              icon: Icons.satellite_outlined,
              axis: Axis.horizontal,
              openPosition: 140,
              onPressed: () => widget.mapControlsFacade.selectSatellite(),
            ),
            ActionButton(
              animation: _animation,
              icon: Icons.map_outlined,
              axis: Axis.horizontal,
              openPosition: 70,
              onPressed: () => widget.mapControlsFacade.selectOutdoors(),
            ),
            ActionButton(
              animation: _animation,
              icon: Icons.zoom_in,
              axis: Axis.vertical,
              openPosition: 280,
              enabled: widget.mapControlsFacade.canZoomIn,
              onPressed: () => widget.mapControlsFacade.zoomIn(),
            ),
            ActionButton(
              animation: _animation,
              icon: Icons.zoom_out,
              axis: Axis.vertical,
              openPosition: 210,
              enabled: widget.mapControlsFacade.canZoomOut,
              onPressed: () => widget.mapControlsFacade.zoomOut(),
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
              onPressed: () => widget.mapControlsFacade.reset(),
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
