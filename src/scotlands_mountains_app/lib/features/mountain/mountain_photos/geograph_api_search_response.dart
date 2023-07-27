import 'geograph_api_search_response_item.dart';

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
