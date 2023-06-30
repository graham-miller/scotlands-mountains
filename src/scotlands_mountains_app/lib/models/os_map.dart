class OsMap {
  final int id;
  final String code;
  final double scale;
  final String name;
  final String isbn;
  final String publisher;
  final String series;

  const OsMap._(this.id, this.code, this.scale, this.name, this.isbn,
      this.publisher, this.series);

  factory OsMap(Map<String, dynamic> map) {
    return OsMap._(map['id'], map['code'], map['scale'], map['name'],
        map['isbn'], map['publisher'], map['series']);
  }
}
