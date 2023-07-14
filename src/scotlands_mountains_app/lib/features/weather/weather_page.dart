import 'package:flutter/material.dart';
import 'package:scotlands_mountains_app/features/weather/forecast.dart';
import 'package:scotlands_mountains_app/features/weather/met_office_client.dart';

import 'forecast_area.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  List<Area> _forecastAreas = List.empty();
  Area? _selectedArea;
  Forecast? _forecast;

  @override
  void initState() {
    _loadAreas();
    super.initState();
  }

  void _loadAreas() {
    MetOfficeClient.getAreas().then((areas) => setState(() {
          _forecastAreas = areas;
        }));
  }

  _loadForecast(Area? area) {
    setState(() => _selectedArea = area);

    if (_selectedArea != null) {
      MetOfficeClient.getForecast(_selectedArea!)
          .then((forecast) => setState(() {
                _forecast = forecast;
              }));
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_forecastAreas.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    return ListView(
      children: [
        _buildAreaSelector(),
        _forecast == null
            ? const SizedBox.shrink()
            : Text('${_forecast!.location} - ${_forecast!.type}')
      ],
    );
  }

  Padding _buildAreaSelector() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          DropdownButton<Area>(
            value: _selectedArea,
            icon: const Icon(Icons.arrow_drop_down),
            items: _forecastAreas
                .map((f) => DropdownMenuItem<Area>(
                      value: f,
                      child: Text(f.area),
                    ))
                .toList(),
            onChanged: (area) => _loadForecast(area),
          ),
        ],
      ),
    );
  }
}
