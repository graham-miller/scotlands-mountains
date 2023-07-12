class Forecast {
  final DateTime dataDate;
  final DateTime validFrom;
  final DateTime validTo;
  final DateTime createdDate;
  final String uri;
  final String area;
  final String risk;

  const Forecast._(
      {required this.dataDate,
      required this.validFrom,
      required this.validTo,
      required this.createdDate,
      required this.uri,
      required this.area,
      required this.risk});

  factory Forecast.fromJson(dynamic json) {
    return Forecast._(
        dataDate: DateTime.parse(json['DataDate'].toString()),
        validFrom: DateTime.parse(json['ValidFrom'].toString()),
        validTo: DateTime.parse(json['ValidTo'].toString()),
        createdDate: DateTime.parse(json['CreatedDate'].toString()),
        uri: json['URI'],
        area: json['Area'],
        risk: json['Risk']);
  }
}
