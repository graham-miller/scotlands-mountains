import 'package:flutter/material.dart';
import "dart:math" show pi;

import 'models/forecast_model.dart';
import 'table/table_cell.dart';
import 'table/table_layout.dart';
import 'table/table_util.dart';

class WindPeriods extends StatefulWidget {
  final List<Period> periods;

  const WindPeriods({required this.periods, super.key});

  @override
  State<WindPeriods> createState() => _WindPeriodsState();
}

class _WindPeriodsState extends State<WindPeriods> {
  bool _showGusts = false;

  @override
  Widget build(BuildContext context) {
    final headerColumn = [
      const HeaderCell(text: 'Period'),
      ...widget.periods[0].levels.map((p) => HeaderCell(text: p.height)),
    ];

    final dataColumns =
        widget.periods.map((p) => _buildPeriod(context, p)).toList();

    return ListTile(
        title: _buildToggle(context),
        subtitle:
            TableLayout(headerColumn: headerColumn, dataColumns: dataColumns));
  }

  Widget _buildToggle(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          if (!_showGusts)
            FilledButton(
              onPressed: () {},
              child: const Text('Wind'),
            ),
          if (!_showGusts)
            TextButton(
              onPressed: () {
                setState(() {
                  _showGusts = true;
                });
              },
              child: const Text('Max gusts'),
            ),
          if (_showGusts)
            TextButton(
              onPressed: () {
                setState(() {
                  _showGusts = false;
                });
              },
              child: const Text('Wind'),
            ),
          if (_showGusts)
            FilledButton(
              onPressed: () {},
              child: const Text('Max gusts'),
            ),
          const Text(' (mph)')
        ],
      ),
    );
  }

  List<Widget> _buildPeriod(BuildContext context, Period period) {
    return [
      TextCell(text: TableUtil.formatTime(period.start)),
      ...period.levels.map(
        (l) => WidgetCell(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Transform.rotate(
                    angle: _getIconRotate(l.windDirection),
                    child: const Icon(Icons.navigation, size: 16),
                  ),
                  Text(' ${l.windDirection}')
                ],
              ),
              Text(_showGusts ? l.maxGust : l.windSpeed),
            ],
          ),
        ),
      )
    ];
  }

  double _getIconRotate(String direction) {
    switch (direction) {
      case 'N':
        return _degreesToRadians(180);
      case 'NE':
        return _degreesToRadians(225);
      case 'NW':
        return _degreesToRadians(135);
      case 'E':
        return _degreesToRadians(270);
      case 'W':
        return _degreesToRadians(90);
      case 'S':
        return _degreesToRadians(0);
      case 'SE':
        return _degreesToRadians(315);
      default:
        return _degreesToRadians(45);
    }
  }

  double _degreesToRadians(double degrees) {
    return 2 * pi / 360 * degrees;
  }
}
