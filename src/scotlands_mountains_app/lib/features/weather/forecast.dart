import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'models/forecast_model.dart';
import 'precipitation_periods.dart';
import 'temperature_periods.dart';

class Forecast extends StatefulWidget {
  final ForecastModel forecast;

  const Forecast({required this.forecast, super.key});

  @override
  State<Forecast> createState() => _ForecastState();
}

class _ForecastState extends State<Forecast> with TickerProviderStateMixin {
  final DateFormat dateFormatter = DateFormat('E d LLL');
  bool _showEvening = true;
  TabController? _tabController;

  @override
  void initState() {
    _showEvening = widget.forecast.evening != null;
    _tabController = TabController(length: _showEvening ? 4 : 3, vsync: this);
    _tabController!.index = _showEvening ? 1 : 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          _buildTabBar(context),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                if (_showEvening) _buildEvening(context),
                _buildDay0(context),
                _buildDay1(context),
                _buildOutlook(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar(BuildContext context) {
    return TabBar(
      isScrollable: true,
      controller: _tabController,
      tabs: [
        if (_showEvening)
          Tab(text: dateFormatter.format(widget.forecast.evening!.validity)),
        Tab(text: dateFormatter.format(widget.forecast.days[0].validity)),
        Tab(text: dateFormatter.format(widget.forecast.days[1].validity)),
        const Tab(text: 'Outlook'),
      ],
    );
  }

  Widget _buildEvening(BuildContext context) {
    return SizedBox.expand(
      child: ListView(
        children: [
          ListTile(
            title: const Text('Evening summary'),
            subtitle: Text(widget.forecast.evening!.summary!),
          ),
        ],
      ),
    );
  }

  Widget _buildDay0(BuildContext context) {
    var day = widget.forecast.days[0];
    return SizedBox.expand(
      child: ListView(
        children: [
          ListTile(
            title: const Text('Headline'),
            subtitle: Text(day.headline!),
          ),
          ListTile(
            title: const Text('Weather (at 800m)'),
            subtitle:
                PrecipitationPeriods(periods: widget.forecast.days[0].periods),
          ),
          ListTile(
            title: const Text('Temperature (°C)'),
            subtitle:
                TemperaturePeriods(periods: widget.forecast.days[0].periods),
          ),
          ListTile(
            title: const Text('Summary'),
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

  Widget _buildDay1(BuildContext context) {
    var day = widget.forecast.days[1];
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
            title: Text(dateFormatter.format(widget.forecast.days[2].validity)),
            subtitle: Text(widget.forecast.days[2].summary!),
          ),
          ListTile(
            title: Text(dateFormatter.format(widget.forecast.days[3].validity)),
            subtitle: Text(widget.forecast.days[3].summary!),
          ),
          ListTile(
            title: Text(dateFormatter.format(widget.forecast.days[4].validity)),
            subtitle: Text(widget.forecast.days[4].summary!),
          ),
        ],
      ),
    );
  }
}
