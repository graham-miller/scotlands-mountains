import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'forecast.dart';

class TemperaturePeriods extends StatelessWidget {
  final List<Period> periods;

  const TemperaturePeriods({required this.periods, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: SingleChildScrollView(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeaderCell(context, 'Period'),
                ...periods[0]
                    .levels
                    .map((p) => _buildHeaderCell(context, p.height)),
                _buildHeaderCell(context, 'Freezing level'),
              ],
            ),
            Flexible(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    ...periods.map(
                      (p) => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [_buildPeriod(context, p)],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildPeriod(BuildContext context, Period period) {
    var time = '';
    if (period.start.hour == 0) {
      time = 'Midnight';
    } else if (period.start.hour == 12) {
      time = 'Midday';
    } else if (period.start.hour > 12) {
      time = '${period.start.hour - 12}pm';
    } else {
      time = '${period.start.hour}am';
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildDataCell(context, time),
        ...period.levels.map((l) => _buildDataCell(context, l.temperature)),
        _buildDataCell(context, period.freezingLevel),
      ],
    );
  }

  Widget _buildDataCell(BuildContext context, String value) {
    return _buildCell(
      Text(
        value,
        style: TextStyle(
            color: Theme.of(context).colorScheme.onSecondaryContainer),
        textAlign: TextAlign.center,
      ),
      Theme.of(context).colorScheme.secondaryContainer,
    );
  }

  Widget _buildHeaderCell(BuildContext context, String value) {
    return _buildCell(
      Text(
        value,
        style:
            TextStyle(color: Theme.of(context).colorScheme.onPrimaryContainer),
        textAlign: TextAlign.center,
      ),
      Theme.of(context).colorScheme.primaryContainer,
    );
  }

  Widget _buildCell(Widget child, Color background) {
    return SizedBox(
      height: 60,
      width: 100,
      child: Padding(
        padding: const EdgeInsets.only(right: 4, bottom: 4),
        child: Container(
          color: background,
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Center(child: child),
          ),
        ),
      ),
    );
  }
}
