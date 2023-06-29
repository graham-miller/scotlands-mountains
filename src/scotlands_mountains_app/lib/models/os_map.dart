class OsMap {
  final int id;
  final String code;
  final double scale;
  final String? name;

  const OsMap._(this.id, this.code, this.scale, this.name);

  factory OsMap(Map<String, dynamic> map) {
    return OsMap._(map['id'], map['code'], map['scale'], map['name']);
  }
}
