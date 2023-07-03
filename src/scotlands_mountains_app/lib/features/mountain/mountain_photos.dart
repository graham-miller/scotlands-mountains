import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
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
        future: searchPhotos(widget.mountain.name, http.Client()),
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

  Future<List<GeographApiPhotoResponse>> searchPhotos(
      String term, http.Client client) async {
    final String escapedTerm = Uri.encodeComponent(term.replaceAll(' ', '+'));

    final response = await client.get(Uri.parse(
        'https://api.geograph.org.uk/syndicator.php?key=${dotenv.env['GEOGRAPH_API_KEY']}&text=$escapedTerm&format=JSON'));

    const JsonDecoder decoder = JsonDecoder();
    final parsed = decoder.convert(response.body);
    final result = GeographApiSearchResponse.fromJson(parsed);

    var photos = await Future.wait(
        result.items.map((e) async => await getPhotoInfo(e.guid, client)));

    return photos;
  }

  Future<GeographApiPhotoResponse> getPhotoInfo(
      String guid, http.Client client) async {
    final response = await client.get(Uri.parse(
        'https://api.geograph.org.uk/api/photo/$guid/${dotenv.env['GEOGRAPH_API_KEY']}?output=json'));

    const JsonDecoder decoder = JsonDecoder();
    final parsed = decoder.convert(response.body);
    var result = GeographApiPhotoResponse.fromJson(parsed);

    return result;
  }
}
