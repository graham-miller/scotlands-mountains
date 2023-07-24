import 'dart:convert';

import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'geograph_api_photo_response.dart';
import 'geograph_api_search_response.dart';
import '../../models/mountain.dart';
import 'photo.dart';

class GeographClient {
  static Future<List<Photo>> searchPhotos(Mountain mountain) async {
    final name = mountain.name.contains('(')
        ? mountain.name.substring(0, mountain.name.indexOf('(')).trim()
        : mountain.name;
    final String term = Uri.encodeComponent(name);
    final parts = mountain.gridRef.split(' ');
    final gridRef =
        parts[0] + parts[1].substring(0, 2) + parts[2].substring(0, 2);
    final url =
        'https://api.geograph.org.uk/syndicator.php?key=${dotenv.env['GEOGRAPH_API_KEY']}&text=$term+near+$gridRef&perpage=10&format=JSON';

    var file = await DefaultCacheManager().getSingleFile(url);
    const JsonDecoder decoder = JsonDecoder();
    final parsed = decoder.convert(await file.readAsString());
    final result = GeographApiSearchResponse.fromJson(parsed);

    return Future.wait(result.items.map((e) async =>
        Photo.fromGeographResponse(e, await _getPhotoInfo(e.guid))));
  }

  static Future<GeographApiPhotoResponse> _getPhotoInfo(String guid) async {
    final url =
        'https://api.geograph.org.uk/api/photo/$guid/${dotenv.env['GEOGRAPH_API_KEY']}?output=json';

    var file = await DefaultCacheManager().getSingleFile(url);
    const JsonDecoder decoder = JsonDecoder();
    final parsed = decoder.convert(await file.readAsString());
    var result = GeographApiPhotoResponse.fromJson(parsed);

    return result;
  }
}
