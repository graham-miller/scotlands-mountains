import 'package:flutter/material.dart';
import 'package:scotlands_mountains_app/features/weather/areas_map.dart';

import 'areas_map_constants.dart';
import 'models/forecast_area.dart';

class AreaSelector extends StatelessWidget {
  final List<ForecastArea> forecastAreas;
  final void Function(ForecastArea?) onSelected;

  const AreaSelector(
      {required this.forecastAreas, required this.onSelected, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(32, 0, 32, 32),
      child: Material(
        elevation: 8,
        child: TapRegion(
          onTapOutside: (_) => onSelected(null),
          child: Container(
            color: Theme.of(context).colorScheme.background,
            child: Column(
              children: [
                AreasMap(
                  onSelected: (i) {
                    onSelected(forecastAreas[i]);
                  },
                ),
                ...forecastAreas.asMap().entries.map(
                  (entry) {
                    return ListTile(
                      title: Text('${entry.key + 1}. ${entry.value.area}'),
                      subtitle: Text(AreaMapConstants
                          .metadata[entry.value.area]!.description),
                      onTap: () {
                        onSelected(entry.value);
                      },
                    );
                  },
                ).toList(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
