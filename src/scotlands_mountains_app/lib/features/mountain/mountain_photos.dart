import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'geograph_api_response.dart';
import '../../models/mountain.dart';

// Ref.: https://docs.flutter.dev/cookbook/networking/background-parsing
// Ref.: https://www.geograph.org.uk/help/api

class MountainPhotos extends StatefulWidget {
  final Mountain mountain;

  const MountainPhotos({super.key, required this.mountain});

  @override
  State<MountainPhotos> createState() => _MountainPhotosState();
}

class _MountainPhotosState extends State<MountainPhotos> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: fetchPhotos(http.Client()),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('An error has occurred!'),
            );
          } else if (snapshot.hasData) {
            return SingleChildScrollView(
              child: Column(
                  children: snapshot.data!.map((i) {
                var url = i.imgServer + i.image;
                return Image.network(url);
              }).toList()),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  Future<List<GeographApiPhotoResponse>> fetchPhotos(http.Client client) async {
    // TODO use compute

    const String apiKey = '441670a7e7';
    const String term = 'ben+nevis';

    final response = await client.get(Uri.parse(
        'https://api.geograph.org.uk/syndicator.php?key=$apiKey&text=$term&format=JSON'));

    const JsonDecoder decoder = JsonDecoder();
    final parsed = decoder.convert(response.body);
    final result = GeographApiSearchResponse.fromJson(parsed);

    var photos = await Future.wait(result.items.map((e) async {
      final response = await client.get(Uri.parse(
          'https://api.geograph.org.uk/api/photo/${e.guid}/$apiKey?output=json'));

      const JsonDecoder decoder = JsonDecoder();
      final parsed = decoder.convert(response.body);
      var result = GeographApiPhotoResponse.fromJson(parsed);

      return result;
    }));

    return photos;
  }
}
