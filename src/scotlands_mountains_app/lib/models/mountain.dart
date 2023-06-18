class Mountain {
  final int id;
  final double latitude;
  final double longitude;
  final String gridRef;
  final double height;
  final String? feature;
  final String? observations;
  final double drop;
  final String col;
  final double colHeight;
  final int? parentId;
  final List<String> aliases;
  final int? regionId;
  final int dobihId;
  final String name;

  const Mountain._(
      this.id,
      this.latitude,
      this.longitude,
      this.gridRef,
      this.height,
      this.feature,
      this.observations,
      this.drop,
      this.col,
      this.colHeight,
      this.parentId,
      this.aliases,
      this.regionId,
      this.dobihId,
      this.name);

  factory Mountain(Map<String, dynamic> map) {
    return Mountain._(
        map['id'],
        map['latitude'],
        map['longitude'],
        map['gridRef'],
        map['height'],
        map['feature'],
        map['observations'],
        map['drop'],
        map['col'],
        map['colHeight'],
        map['parentId'],
        List.empty(),
        map['regionId'],
        map['dobihId'],
        map['name']);
  }
}
