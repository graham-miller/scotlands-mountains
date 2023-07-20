import 'package:flutter/material.dart';

import 'models/forecast_model.dart';
import 'table/table_cell.dart';
import 'table/table_layout.dart';
import 'table/table_util.dart';

class TemperaturePeriods extends StatefulWidget {
  final List<Period> periods;

  const TemperaturePeriods({required this.periods, super.key});

  @override
  State<TemperaturePeriods> createState() => _TemperaturePeriodsState();
}

class _TemperaturePeriodsState extends State<TemperaturePeriods> {
  bool _showFeelsLike = false;

  @override
  Widget build(BuildContext context) {
    final headerColumn = [
      const HeaderCell(text: 'Period'),
      ...widget.periods[0].levels.map((p) => HeaderCell(text: p.height)),
      const HeaderCell(text: 'Freezing level'),
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
          if (!_showFeelsLike)
            FilledButton(
              onPressed: () {},
              child: const Text('Temperature'),
            ),
          if (!_showFeelsLike)
            TextButton(
              onPressed: () {
                setState(() {
                  _showFeelsLike = true;
                });
              },
              child: const Text('Feels like'),
            ),
          if (_showFeelsLike)
            TextButton(
              onPressed: () {
                setState(() {
                  _showFeelsLike = false;
                });
              },
              child: const Text('Temperature'),
            ),
          if (_showFeelsLike)
            FilledButton(
              onPressed: () {},
              child: const Text('Feels like'),
            ),
          const Text(' (°C)')
        ],
      ),
    );
  }

  List<Widget> _buildPeriod(BuildContext context, Period period) {
    return [
      TextCell(text: TableUtil.formatTime(period.start)),
      if (!_showFeelsLike)
        ...period.levels.map((l) => TextCell(text: l.temperature)),
      if (_showFeelsLike)
        ...period.levels.map((l) => TextCell(text: l.feelsLike)),
      TextCell(text: period.freezingLevel),
    ];
  }
}
