class Forecast {
  final String location;
  final String issue;
  final DateTime issued;
  final String type;
  //final ParamUnits paramUnits;
  //final Evening evening;
  //final List<Day> days;

  const Forecast._(
      {required this.location,
      required this.issue,
      required this.issued,
      required this.type});

  factory Forecast.fromJson(dynamic json) {
    return Forecast._(
        location: json['Location'],
        issue: json['Issue'],
        issued: DateTime.parse(json['Issued'].toString()),
        type: json['Type']);
  }
}
