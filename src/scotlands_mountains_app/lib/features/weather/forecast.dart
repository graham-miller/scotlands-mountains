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
  // final Temperature? temperature;
  // final List<Period>? Periods;

  const Day._(
      {required this.validity,
      required this.headline,
      required this.confidence,
      required this.view,
      required this.cloudFreeHillTop,
      required this.weather,
      required this.visibility,
      required this.summary,
      required this.hazards});

  factory Day.fromJson(dynamic json) {
    final hazards =
        json['Hazards']?['Hazard'].map((j) => Hazard.fromJson(j)).toList();

    return Day._(
        validity: DateTime.parse(json['Validity'].toString()),
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
                .toList()));
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
