class GeographApiSearchResponseItem {
  final String title;
  final String? description;
  final String link;
  final String author;
  final String guid;
  final String source;
  final int date;
  final String? imageTaken;
  final int dateUpdated;
  final String? tags;
  final String lat;
  final String long;
  final String thumb;
  final String? thumbTag;
  final String licence;

  const GeographApiSearchResponseItem._(
      {required this.title,
      required this.description,
      required this.link,
      required this.author,
      required this.guid,
      required this.source,
      required this.date,
      required this.imageTaken,
      required this.dateUpdated,
      required this.tags,
      required this.lat,
      required this.long,
      required this.thumb,
      required this.thumbTag,
      required this.licence});

  factory GeographApiSearchResponseItem.fromJson(dynamic json) {
    return GeographApiSearchResponseItem._(
        title: json['title'],
        description: json['description'],
        link: json['link'],
        author: json['author'],
        guid: json['guid'],
        source: json['source'],
        date: json['date'] as int,
        imageTaken: json['imageTaken'],
        dateUpdated: json['dateUpdated'] as int,
        tags: json['tags'] as String?,
        lat: json['lat'],
        long: json['long'],
        thumb: json['thumb'],
        thumbTag: json['thumbTag'],
        licence: json['licence']);
  }
}
