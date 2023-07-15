import 'dart:convert';

import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'forecast.dart';
import 'forecast_area.dart';

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

    return areas;
  }

  static Future<Forecast> getForecast(ForecastArea area) async {
    final url = area.uri
        .replaceFirst('{format}', 'json')
        .replaceFirst('{key}', dotenv.env['MET_OFFICE_API_KEY']!);

    var file = await DefaultCacheManager().getSingleFile(url);
    const JsonDecoder decoder = JsonDecoder();
    final parsed = decoder.convert(await file.readAsString());
    final forecast = Forecast.fromJson(parsed['Report']);

    return forecast;
  }
}
