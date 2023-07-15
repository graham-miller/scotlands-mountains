import 'package:flutter/material.dart';
import 'package:scotlands_mountains_app/features/weather/forecast.dart';
import 'package:scotlands_mountains_app/features/weather/met_office_client.dart';

import 'area_selector.dart';
import 'forecast_area.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage>
    with SingleTickerProviderStateMixin {
  List<ForecastArea> _forecastAreas = List.empty();
  ForecastArea? _selectedArea;
  Forecast? _forecast;
  bool _showEvening = true;
  TabController? _tabController;

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
        _showEvening = forecast.evening != null;
        setState(() {
          _tabController =
              TabController(length: _showEvening ? 4 : 3, vsync: this);
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
        if (_forecast != null)
          TabBar(
            controller: _tabController,
            tabs: <Widget>[
              if (_forecast!.evening != null) const Tab(text: 'Evening'),
              const Tab(text: 'Day 0'),
              const Tab(text: 'Day 1'),
              const Tab(text: 'Outlook'),
            ],
          ),
        if (_forecast != null)
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: <Widget>[
                if (_forecast!.evening != null) _buildEvening(context),
                _buildDay0(context),
                _buildDay1(context),
                _buildOutlook(context),
              ],
            ),
          ),
        if (_selectedArea != null && _forecast == null)
          const Expanded(
            child: Center(child: CircularProgressIndicator()),
          ),
      ],
    );
  }

  Widget _buildEvening(BuildContext context) {
    return const SizedBox.expand(
      child: Text('Evening'),
    );
  }

  Widget _buildDay0(BuildContext context) {
    return const SizedBox.expand(
      child: Text('Day 0'),
    );
  }

  Widget _buildDay1(BuildContext context) {
    return const SizedBox.expand(
      child: Text('Day 1'),
    );
  }

  Widget _buildOutlook(BuildContext context) {
    return const SizedBox.expand(
      child: Text('Outlook'),
    );
  }
}
