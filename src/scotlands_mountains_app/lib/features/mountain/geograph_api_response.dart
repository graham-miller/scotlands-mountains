class GeographApiResponse {
  final String generator;
  final String title;
  final String description;
  final String link;
  final String syndicationURL;
  final String? prevURL;
  final String? nextURL;
  final String icon;
  final String date;
  final List<GeographApiResponseItem> items;

  const GeographApiResponse._(
      {required this.generator,
      required this.title,
      required this.description,
      required this.link,
      required this.syndicationURL,
      required this.prevURL,
      required this.nextURL,
      required this.icon,
      required this.date,
      required this.items});

  factory GeographApiResponse.fromJson(dynamic json) {
    return GeographApiResponse._(
        generator: json['generator'],
        title: json['title'],
        description: json['description'],
        link: json['link'],
        syndicationURL: json['syndicationURL'],
        prevURL: json.containsKey('prevURL') ? json['prevURL'] : null,
        nextURL: json.containsKey('nextURL') ? json['nextURL'] : null,
        icon: json['icon'],
        date: json['date'],
        items: List.from(json['items'])
            .map((i) => GeographApiResponseItem.fromJson(i))
            .toList());
  }
}

class GeographApiResponseItem {
  final String title;
  final String description;
  final String link;
  final String author;
  final String guid;
  final String source;
  final int date;
  final String imageTaken;
  final int dateUpdated;
  final String? tags;
  final String lat;
  final String long;
  final String thumb;
  final String thumbTag;
  final String licence;

  const GeographApiResponseItem._(
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

  factory GeographApiResponseItem.fromJson(dynamic json) {
    return GeographApiResponseItem._(
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
