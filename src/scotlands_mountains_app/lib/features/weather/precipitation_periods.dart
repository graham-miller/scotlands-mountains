import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:scotlands_mountains_app/features/weather/table/table_layout.dart';

import 'models/forecast_model.dart';
import 'table/table_cell.dart';
import 'table/table_util.dart';

class PrecipitationPeriods extends StatelessWidget {
  final List<Period> periods;

  const PrecipitationPeriods({required this.periods, super.key});

  @override
  Widget build(BuildContext context) {
    final headerColumn = [
      const HeaderCell(text: 'Period'),
      const HeaderCell(text: 'Weather'),
      const HeaderCell(text: 'Description'),
      const HeaderCell(text: 'Chance of rain'),
    ];

    final dataColumns = periods.map((p) => _buildPeriod(context, p)).toList();

    return TableLayout(headerColumn: headerColumn, dataColumns: dataColumns);
  }

  List<Widget> _buildPeriod(BuildContext context, Period period) {
    return [
      TextCell(text: TableUtil.formatTime(period.start)),
      WidgetCell(
          child: SvgPicture.asset(
              'assets/weather_icons/${period.weatherCode}.svg')),
      TextCell(
          text: TableUtil.formatWeatherDescription(period.weatherDescription)),
      TextCell(text: period.precipitationProbability),
    ];
  }
}
