import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import 'forecast.dart';
import 'forecast_area.dart';

class MetOfficeClient {
  static Future<List<Area>> getAreas() async {
    final url =
        'http://datapoint.metoffice.gov.uk/public/data/txt/wxfcs/mountainarea/json/capabilities?key=${dotenv.env['MET_OFFICE_API_KEY']}';

    final client = http.Client();
    final response = await client.get(Uri.parse(url));

    const JsonDecoder decoder = JsonDecoder();
    final parsed = decoder.convert(response.body);

    final areas = List<Area>.from(parsed['MountainForecastList']
            ['MountainForecast']
        .map((json) => Area.fromJson(json))
        .where((area) =>
            area.area.contains('Highlands') || area.area.contains('Grampian')));

    return areas;
  }

  static Future<Forecast> getForecast(Area area) async {
    final url = area.uri
        .replaceFirst('{format}', 'json')
        .replaceFirst('{key}', dotenv.env['MET_OFFICE_API_KEY']!);
    final client = http.Client();
    final response = await client.get(Uri.parse(url));

    const JsonDecoder decoder = JsonDecoder();
    final parsed = decoder.convert(response.body);
    final forecast = Forecast.fromJson(parsed['Report']);

    return forecast;
  }
}
