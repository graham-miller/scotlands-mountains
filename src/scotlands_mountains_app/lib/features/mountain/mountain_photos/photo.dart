import '../../mountain_photos/geograph_api_photo_response.dart';
import '../../mountain_photos/geograph_api_search_response_item.dart';

class Photo {
  final String guid;
  final String title;
  final String description;
  final String geographUrl;
  final String author;
  final String authorUrl;
  final String reuseUrl;
  final String licenceUrl;
  final DateTime date;
  final String gridRef;
  final double lat;
  final double long;
  final String thumbUrl;
  final String imageUrl;

  Photo._(
      {required this.guid,
      required this.title,
      required this.description,
      required this.geographUrl,
      required this.author,
      required this.authorUrl,
      required this.reuseUrl,
      required this.licenceUrl,
      required this.date,
      required this.gridRef,
      required this.lat,
      required this.long,
      required this.thumbUrl,
      required this.imageUrl});

  factory Photo.fromGeographResponse(
      GeographApiSearchResponseItem item, GeographApiPhotoResponse photo) {
    return Photo._(
        guid: item.guid,
        title: photo.title,
        description: photo.comment,
        geographUrl: item.link,
        author: item.author,
        authorUrl: item.source,
        reuseUrl: 'https://www.geograph.org.uk/reuse.php?id=${item.guid}',
        licenceUrl: item.licence,
        date: DateTime.fromMicrosecondsSinceEpoch(item.date),
        gridRef: photo.gridReference,
        lat: double.parse(item.lat),
        long: double.parse(item.long),
        thumbUrl: photo.imgServer + photo.thumbnail,
        imageUrl: photo.imgServer + photo.image);
  }
}
