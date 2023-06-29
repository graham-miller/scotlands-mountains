class Region {
  final int id;
  final String code;
  final String name;

  const Region._(this.id, this.code, this.name);

  factory Region(Map<String, dynamic> map) {
    return Region._(map['id'], map['code'], map['name']);
  }
}
