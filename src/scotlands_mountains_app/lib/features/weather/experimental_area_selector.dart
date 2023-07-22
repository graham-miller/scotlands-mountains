import 'package:flutter/material.dart';

import 'models/forecast_area.dart';

class ExperimentalAreaSelector extends StatefulWidget {
  final List<ForecastArea> forecastAreas;
  final ForecastArea? selectedArea;
  final Function onSelected;

  const ExperimentalAreaSelector(
      {required this.forecastAreas,
      required this.selectedArea,
      required this.onSelected,
      super.key});

  @override
  State<ExperimentalAreaSelector> createState() =>
      _ExperimentalAreaSelectorState();
}

class _ExperimentalAreaSelectorState extends State<ExperimentalAreaSelector> {
  final top = AppBar().preferredSize.height;
  OverlayEntry? _overlayEntry;

  void _openDropdown(BuildContext context) {
    _closeDropdown();

    _overlayEntry = OverlayEntry(builder: (BuildContext _) {
      return SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(32, top, 32, 32),
          child: Material(
            elevation: 8,
            child: Container(
              color: Theme.of(context).colorScheme.background,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  ...widget.forecastAreas.map(
                    (a) {
                      return FilledButton(
                        onPressed: () {
                          _closeDropdown();
                          widget.onSelected(a);
                        },
                        child: Text(a.area),
                      );
                    },
                  ).toList()
                ],
              ),
            ),
          ),
        ),
      );
    });

    Overlay.of(context, debugRequiredFor: widget).insert(_overlayEntry!);
  }

  void _closeDropdown() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  void dispose() {
    // Make sure to remove OverlayEntry when the widget is disposed.
    _closeDropdown();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: () => _openDropdown(context),
      child: const Text('open'),
    );
  }
}
