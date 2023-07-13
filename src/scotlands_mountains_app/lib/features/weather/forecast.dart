import 'package:scotlands_mountains_app/features/weather/weather_page.dart';

class Forecast {
  final String location;
  final String issue;
  final DateTime issued;
  final String type;
  final Units units;
  final Day? evening;
  final List<Day> days;

  const Forecast._(
      {required this.location,
      required this.issue,
      required this.issued,
      required this.type,
      required this.units,
      required this.evening,
      required this.days});

  factory Forecast.fromJson(dynamic json) {
    return Forecast._(
        location: json['Location'],
        issue: json['Issue'],
        issued: DateTime.parse(json['Issued'].toString()),
        type: json['Type'],
        units: Units.fromJson(json['ParamUnits']),
        evening: Day.fromJson(json['Evening']),
        days: List<Day>.from(
            json['Days']['Day'].map((j) => Day.fromJson(j)).toList()));
  }
}

class Units {
  final String windSpeed;
  final String maxGust;
  final String temperature;
  final String feelsLike;

  const Units._(
      {required this.windSpeed,
      required this.maxGust,
      required this.temperature,
      required this.feelsLike});

  factory Units.fromJson(dynamic json) {
    return Units._(
        windSpeed: json['WindSpeed'],
        maxGust: json['MaxGust'],
        temperature: json['Temperature'],
        feelsLike: json['FeelsLike']);
  }
}

class Day {
  final DateTime validity;
  final String? headline;
  final String? confidence;
  final String? view;
  final String? cloudFreeHillTop;
  final String? weather;
  final String? visibility;
  final String? summary;
  final List<Hazard> hazards;
  final Temperature? temperature;
  final List<Period> periods;

  const Day._(
      {required this.validity,
      required this.headline,
      required this.confidence,
      required this.view,
      required this.cloudFreeHillTop,
      required this.weather,
      required this.visibility,
      required this.summary,
      required this.hazards,
      required this.temperature,
      required this.periods});

  factory Day.fromJson(dynamic json) {
    final validity = DateTime.parse(json['Validity'].toString());

    return Day._(
        validity: validity,
        headline: json['Headline'],
        confidence: json['Confidence'],
        view: json['View'],
        cloudFreeHillTop: json['CloudFreeHillTop'],
        weather: json['Weather'],
        visibility: json['Visibility'],
        summary: json['Summary'],
        hazards: json['Hazards'] == null
            ? List<Hazard>.empty()
            : List<Hazard>.from(json['Hazards']?['Hazard']
                .map((j) => Hazard.fromJson(j))
                .toList()),
        temperature: json['Temperature'] == null
            ? null
            : Temperature.fromJson(json['Temperature']),
        periods: json['Periods'] == null
            ? List<Period>.empty()
            : List<Period>.from(json['Periods']['Period']
                .map((j) => Period.fromJson(j, validity))));
  }
}

class Hazard {
  final String type;
  final String likelihood;

  const Hazard._({required this.type, required this.likelihood});

  factory Hazard.fromJson(dynamic json) {
    return Hazard._(
        type: json['Element']['\$'], likelihood: json['Likelihood']['\$']);
  }
}

class Temperature {
  final String levelHeight;
  final String levelTemperature;
  final String glen;
  final String glenTemperature;
  final String freezingLevel;

  const Temperature._(
      {required this.levelHeight,
      required this.levelTemperature,
      required this.glen,
      required this.glenTemperature,
      required this.freezingLevel});

  factory Temperature.fromJson(dynamic json) {
    return Temperature._(
        levelHeight: json['Peak']['Level'],
        levelTemperature: json['Peak']['\$'],
        glen: json['Valley']['Title'],
        glenTemperature: json['Valley']['\$'],
        freezingLevel: json['Freezing']);
  }
}

class Period {
  final DateTime start;
  final DateTime end;
  final String weatherCode;
  final String weatherDescription;
  final String precipitationProbability;
  final String freezingLevel;
  final List<Level> levels;

  const Period._(
      {required this.start,
      required this.end,
      required this.weatherCode,
      required this.weatherDescription,
      required this.precipitationProbability,
      required this.freezingLevel,
      required this.levels});

  factory Period.fromJson(dynamic json, DateTime date) {
    final start =
        json['Start'].toString().split(':').map((i) => int.parse(i)).toList();
    final end =
        json['End'].toString().split(':').map((i) => int.parse(i)).toList();

    return Period._(
        start: date.add(Duration(hours: start[0], minutes: start[1])),
        end: date.add(Duration(hours: end[0], minutes: end[1])),
        weatherCode: json['SignificantWeather']['Code'],
        weatherDescription: json['SignificantWeather']['\$'],
        precipitationProbability: json['Precipitation']['Probability'],
        freezingLevel: json['FreezingLevel'],
        levels: List<Level>.from(
            json['Height'].map((j) => Level.fromJson(j)).toList()));
  }
}
