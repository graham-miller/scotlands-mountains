import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import 'forecast.dart';

class MetOfficeClient {
  static Future<List<Forecast>> getForecasts() async {
    final url =
        'http://datapoint.metoffice.gov.uk/public/data/txt/wxfcs/mountainarea/json/capabilities?key=${dotenv.env['MET_OFFICE_API_KEY']}';

    final client = http.Client();
    final response = await client.get(Uri.parse(url));

    const JsonDecoder decoder = JsonDecoder();
    final parsed = decoder.convert(response.body);

    final forecasts = List<Forecast>.from(parsed['MountainForecastList']
            ['MountainForecast']
        .map((json) => Forecast.fromJson(json))
        .where((f) =>
            f.area.contains('Highlands') || f.area.contains('Grampian')));

    return forecasts;
  }
}
