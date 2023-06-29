class Mountain {
  final int id;
  final String name;
  final double latitude;
  final double longitude;
  final String gridRef;
  final double height;
  final String? feature;
  final String? observations;
  final double drop;
  final String col;
  final double colHeight;
  final int dobihId;

  Mountain._(
      this.id,
      this.name,
      this.latitude,
      this.longitude,
      this.gridRef,
      this.height,
      this.feature,
      this.observations,
      this.drop,
      this.col,
      this.colHeight,
      this.dobihId);

  Mountain(Map<String, dynamic> map)
      : this._(
            map['id'],
            map['name'],
            map['latitude'],
            map['longitude'],
            map['gridRef'],
            map['height'],
            map['feature'],
            map['observations'],
            map['drop'],
            map['col'],
            map['colHeight'],
            map['dobihId']);
}
