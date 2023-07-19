import 'package:flutter/material.dart';

import 'models/forecast_area.dart';

class AreaSelector extends StatelessWidget {
  final List<ForecastArea> forecastAreas;
  final ForecastArea? selectedArea;
  final Function onSelected;

  const AreaSelector(
      {required this.forecastAreas,
      required this.selectedArea,
      required this.onSelected,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          DropdownButton<ForecastArea>(
            value: selectedArea,
            icon: const Icon(Icons.arrow_drop_down),
            items: forecastAreas
                .map((f) => DropdownMenuItem<ForecastArea>(
                      value: f,
                      child: Text(f.area),
                    ))
                .toList(),
            onChanged: (area) => onSelected(area),
          ),
        ],
      ),
    );
  }
}
