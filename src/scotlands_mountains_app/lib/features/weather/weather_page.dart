import 'package:flutter/material.dart';

import 'area_selector.dart';
import 'forecast.dart';
import 'models/forecast_area.dart';
import 'models/forecast_model.dart';
import 'met_office_client.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage>
    with TickerProviderStateMixin {
  List<ForecastArea> _forecastAreas = List.empty();
  ForecastArea? _selectedArea;
  ForecastModel? _forecast;

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

  _loadForecast(ForecastArea? area) {
    setState(() => _selectedArea = area);

    if (_selectedArea != null) {
      MetOfficeClient.getForecast(_selectedArea!).then((forecast) {
        setState(() {
          _forecast = forecast;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_forecastAreas.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        AreaSelector(
          forecastAreas: _forecastAreas,
          selectedArea: _selectedArea,
          onSelected: (area) => _loadForecast(area),
        ),
        if (_forecast != null) Forecast(forecast: _forecast!),
        if (_selectedArea != null && _forecast == null)
          const Expanded(
            child: Center(child: CircularProgressIndicator()),
          ),
      ],
    );
  }
}
