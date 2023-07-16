import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
    with TickerProviderStateMixin {
  final DateFormat dateFormatter = DateFormat('E d LLL');
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
          _tabController!.index = _showEvening ? 1 : 0;
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
            isScrollable: true,
            controller: _tabController,
            tabs: <Widget>[
              if (_showEvening)
                Tab(text: dateFormatter.format(_forecast!.evening!.validity)),
              Tab(text: dateFormatter.format(_forecast!.days[0].validity)),
              Tab(text: dateFormatter.format(_forecast!.days[1].validity)),
              const Tab(text: 'Outlook'),
            ],
          ),
        if (_forecast != null)
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: <Widget>[
                if (_showEvening) _buildEvening(context),
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
    return SizedBox.expand(
      child: ListView(
        children: [
          ListTile(
            title: const Text('Evening summary'),
            subtitle: Text(_forecast!.evening!.summary!),
          ),
        ],
      ),
    );
  }

  Widget _buildDay0(BuildContext context) {
    var day = _forecast!.days[0];
    return SizedBox.expand(
      child: ListView(
        children: [
          ListTile(
            title: const Text('Headline'),
            subtitle: Text(day.headline!),
          ),
          const ListTile(
            title: Text('Weather'),
          ),
          _buildPeriods(context),
          ListTile(
            subtitle: Text(day.weather!),
          ),
          ListTile(
            title: const Text('View'),
            subtitle: Text(day.view!),
          ),
          ListTile(
            title: const Text('Confidence'),
            subtitle: Text(day.confidence!),
          ),
          ListTile(
            title: const Text('Cloud free summits'),
            subtitle: Text(day.cloudFreeHillTop!),
          ),
          ListTile(
            title: const Text('Visibility'),
            subtitle: Text(day.visibility!),
          ),
        ],
      ),
    );
  }

  Widget _buildPeriods(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: SizedBox(
        height: 150,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            ..._forecast!.days[0].periods
                .map(
                  (p) => Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Text('${p.start.hour}:00'),
                          Text(p.weatherCode),
                          Text(p.weatherDescription),
                          Text(p.precipitationProbability),
                        ],
                      ),
                    ),
                  ),
                )
                .toList()
          ],
        ),
      ),
    );
  }

  Widget _buildDay1(BuildContext context) {
    var day = _forecast!.days[1];
    return SizedBox.expand(
      child: ListView(
        children: [
          ListTile(
            title: const Text('Weather'),
            subtitle: Text(day.weather!),
          ),
          ListTile(
            title: Text('Temperature (${day.temperature!.glen})'),
            subtitle: Text(day.temperature!.glenTemperature),
          ),
          ListTile(
            title: Text('Temperature (${day.temperature!.levelHeight})'),
            subtitle: Text(day.temperature!.levelTemperature),
          ),
          ListTile(
            title: const Text('Freezing level'),
            subtitle: Text(day.temperature!.freezingLevel),
          ),
          ListTile(
            title: const Text('Wind'),
            subtitle: Text(day.wind!),
          ),
          ListTile(
            title: const Text('Hill cloud'),
            subtitle: Text(day.hillCloud!),
          ),
          ListTile(
            title: const Text('Visibility'),
            subtitle: Text(day.visibility!),
          ),
        ],
      ),
    );
  }

  Widget _buildOutlook(BuildContext context) {
    return SizedBox.expand(
      child: ListView(
        children: [
          ListTile(
            title: Text(dateFormatter.format(_forecast!.days[2].validity)),
            subtitle: Text(_forecast!.days[2].summary!),
          ),
          ListTile(
            title: Text(dateFormatter.format(_forecast!.days[3].validity)),
            subtitle: Text(_forecast!.days[3].summary!),
          ),
          ListTile(
            title: Text(dateFormatter.format(_forecast!.days[4].validity)),
            subtitle: Text(_forecast!.days[4].summary!),
          ),
        ],
      ),
    );
  }
}
