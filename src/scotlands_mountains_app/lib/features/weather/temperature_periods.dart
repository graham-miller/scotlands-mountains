import 'package:flutter/material.dart';

import 'models/forecast_model.dart';
import 'table/table_cell.dart';
import 'table/table_layout.dart';
import 'table/table_util.dart';

class TemperaturePeriods extends StatelessWidget {
  final List<Period> periods;

  const TemperaturePeriods({required this.periods, super.key});

  @override
  Widget build(BuildContext context) {
    final headerColumn = [
      const HeaderCell(text: 'Period'),
      ...periods[0].levels.map((p) => HeaderCell(text: p.height)),
      const HeaderCell(text: 'Freezing level'),
    ];

    final dataColumns = periods.map((p) => _buildPeriod(context, p)).toList();

    return TableLayout(headerColumn: headerColumn, dataColumns: dataColumns);
  }

  List<Widget> _buildPeriod(BuildContext context, Period period) {
    return [
      TextCell(text: TableUtil.formatTime(period.start)),
      ...period.levels.map((l) => TextCell(text: l.temperature)),
      TextCell(text: period.freezingLevel),
    ];
  }
}
