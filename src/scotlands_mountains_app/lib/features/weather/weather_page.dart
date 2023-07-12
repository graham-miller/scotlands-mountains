import 'package:flutter/material.dart';
import 'package:scotlands_mountains_app/features/weather/met_office_client.dart';

import 'forecast.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  List<Forecast> _forecasts = List.empty();

  @override
  void initState() {
    MetOfficeClient.getForecasts().then((forecasts) => setState(() {
          _forecasts = forecasts;
        }));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_forecasts.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    return ListView(
      children: [
        ..._forecasts.map((f) {
          return Text(f.area);
        }).toList(),
      ],
    );
  }
}
