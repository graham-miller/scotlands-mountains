import 'dart:convert';

import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'models/forecast_model.dart';
import 'models/forecast_area.dart';

class MetOfficeClient {
  static Future<List<ForecastArea>> getAreas() async {
    final url =
        'http://datapoint.metoffice.gov.uk/public/data/txt/wxfcs/mountainarea/json/capabilities?key=${dotenv.env['MET_OFFICE_API_KEY']}';

    var file = await DefaultCacheManager().getSingleFile(url);
    const JsonDecoder decoder = JsonDecoder();
    final parsed = decoder.convert(await file.readAsString());

    final areas = List<ForecastArea>.from(parsed['MountainForecastList']
            ['MountainForecast']
        .map((json) => ForecastArea.fromJson(json))
        .where((area) =>
            area.area.contains('Highlands') || area.area.contains('Grampian')));

    return _sort(areas);
  }

  static Future<ForecastModel> getForecast(ForecastArea area) async {
    final url = area.uri
        .replaceFirst('{format}', 'json')
        .replaceFirst('{key}', dotenv.env['MET_OFFICE_API_KEY']!);

    var file = await DefaultCacheManager().getSingleFile(url);
    const JsonDecoder decoder = JsonDecoder();
    final parsed = decoder.convert(await file.readAsString());
    final forecast = ForecastModel.fromJson(parsed['Report']);

    return forecast;
  }

  static List<ForecastArea> _sort(List<ForecastArea> areas) {
    areas.sort((a, b) => _order[a.area]!.compareTo(_order[b.area]!));
    return areas;
  }

  static final _order = {
    'Northwest Highlands': 0,
    'North Grampian': 1,
    'South Grampian and Southeast Highlands': 2,
    'Southwest Highlands': 3,
  };
}
