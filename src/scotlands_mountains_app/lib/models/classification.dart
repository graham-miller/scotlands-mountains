class Classification {
  final int id;
  final int? displayOrder;
  final int isActive;
  final String nameSingular;
  final String description;
  final String name;

  const Classification._(
    this.id,
    this.name,
    this.displayOrder,
    this.isActive,
    this.nameSingular,
    this.description,
  );

  factory Classification(Map<String, dynamic> map) {
    return Classification._(map['id'], map['name'], map['displayOrder'],
        map['isActive'], map['nameSingular'], map['description']);
  }
}
