class Country {
  final int id;
  final bool isEnabled;
  final String name;

  const Country._(this.id, this.isEnabled, this.name);

  factory Country(Map<String, dynamic> map) {
    return Country._(map['id'], map['isEnabled'] == 1, map['name']);
  }
}
