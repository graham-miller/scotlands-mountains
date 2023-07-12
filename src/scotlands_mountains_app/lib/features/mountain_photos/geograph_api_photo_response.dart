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
  final String tags;
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
        tags: json['tags'] ?? '',
        comment: json['comment'] ?? '',
        wgs84Lat: json['wgs84_lat'],
        wgs84Long: json['wgs84_long']);
  }
}
