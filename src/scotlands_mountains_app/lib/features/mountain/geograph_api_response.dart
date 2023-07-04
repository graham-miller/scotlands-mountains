class GeographApiSearchResponse {
  final String generator;
  final String title;
  final String description;
  final String link;
  final String syndicationUrl;
  final String? prevUrl;
  final String? nextUrl;
  final String icon;
  final String date;
  final List<GeographApiSearchResponseItem> items;

  const GeographApiSearchResponse._(
      {required this.generator,
      required this.title,
      required this.description,
      required this.link,
      required this.syndicationUrl,
      required this.prevUrl,
      required this.nextUrl,
      required this.icon,
      required this.date,
      required this.items});

  factory GeographApiSearchResponse.fromJson(dynamic json) {
    return GeographApiSearchResponse._(
        generator: json['generator'],
        title: json['title'],
        description: json['description'],
        link: json['link'],
        syndicationUrl: json['syndicationURL'],
        prevUrl: json.containsKey('prevURL') ? json['prevURL'] : null,
        nextUrl: json.containsKey('nextURL') ? json['nextURL'] : null,
        icon: json['icon'],
        date: json['date'],
        items: List.from(json['items'])
            .map((i) => GeographApiSearchResponseItem.fromJson(i))
            .toList());
  }
}

class GeographApiSearchResponseItem {
  final String title;
  final String description;
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
      this.thumbTag,
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

class GeographApiPhotoResponse {
  final String title;
  final String gridReference;
  final String profileLink;
  final String realName;
  final String imgServer;
  final String thumbnail;
  final String image;
  final List<String> sizeInfo;
  final String taken;
  final int submitted;
  final String? tags;
  final String comment;
  final String wgs84Lat;
  final String wgs84Long;

  GeographApiPhotoResponse._(
      {required this.title,
      required this.gridReference,
      required this.profileLink,
      required this.realName,
      required this.imgServer,
      required this.thumbnail,
      required this.image,
      required this.sizeInfo,
      required this.taken,
      required this.submitted,
      required this.tags,
      required this.comment,
      required this.wgs84Lat,
      required this.wgs84Long});

  factory GeographApiPhotoResponse.fromJson(dynamic json) {
    return GeographApiPhotoResponse._(
        title: json['title'],
        gridReference: json['grid_reference'],
        profileLink: json['profile_link'],
        realName: json['realname'],
        imgServer: json['imgserver'],
        thumbnail: json['thumbnail'],
        image: json['image'],
        sizeInfo: List.from(json['sizeinfo']),
        taken: json['taken'],
        submitted: json['submitted'],
        tags: json['tags'],
        comment: json['comment'],
        wgs84Lat: json['wgs84_lat'],
        wgs84Long: json['wgs84_long']);
  }
}
