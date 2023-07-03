import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import 'geograph_api_response.dart';
import '../../models/mountain.dart';

// Ref.: https://docs.flutter.dev/cookbook/networking/background-parsing
// Ref.: https://www.geograph.org.uk/help/api

class MountainPhotos extends StatefulWidget {
  final client = http.Client();
  final Mountain mountain;

  MountainPhotos({super.key, required this.mountain});

  @override
  State<MountainPhotos> createState() => _MountainPhotosState();
}

class _MountainPhotosState extends State<MountainPhotos> {
  final _client = http.Client();
  final List<GeographApiPhotoResponse> _photos = List.empty(growable: true);
  late final CarouselOptions _options;

  int _index = 0;

  @override
  void initState() {
    super.initState();
    _options = CarouselOptions(
        enableInfiniteScroll: false,
        enlargeCenterPage: true,
        onPageChanged: (i, r) {
          setState(() => _index = i);
        });

    searchPhotos();
  }

  @override
  void didUpdateWidget(covariant MountainPhotos oldWidget) {
    super.didUpdateWidget(oldWidget);
    searchPhotos();
  }

  @override
  Widget build(BuildContext context) {
    if (_photos.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
          child: CarouselSlider.builder(
              options: _options,
              itemCount: _photos.length,
              itemBuilder: (BuildContext context, int itemIndex,
                      int pageViewIndex) =>
                  Image.network(
                      _photos[itemIndex].imgServer + _photos[itemIndex].image)),
        ),
        ListTile(
          title: Text(_photos[_index].title),
        ),
        ListTile(
          subtitle: Text(_photos[_index].comment),
        ),
        ListTile(
          subtitle: Text(
              '© Copyright David Dixon and licensed for reuse under this Creative Commons Licence. https://www.geograph.org.uk/photo/${_photos[_index].guid}'),
// https://www.geograph.org.uk/profile/43729
// https://www.geograph.org.uk/reuse.php?id=5470523
        ),
      ],
    );
  }

  void searchPhotos() async {
    setState(() => _photos.clear());

    final String escapedTerm =
        Uri.encodeComponent(widget.mountain.name.replaceAll(' ', '+'));

    final response = await _client.get(Uri.parse(
        'https://api.geograph.org.uk/syndicator.php?key=${dotenv.env['GEOGRAPH_API_KEY']}&text=$escapedTerm&format=JSON'));

    const JsonDecoder decoder = JsonDecoder();
    final parsed = decoder.convert(response.body);
    final result = GeographApiSearchResponse.fromJson(parsed);

    var photos = await Future.wait(
        result.items.map((e) async => await getPhotoInfo(e.guid)));

    setState(() => _photos.addAll(photos));
  }

  Future<GeographApiPhotoResponse> getPhotoInfo(String guid) async {
    final response = await _client.get(Uri.parse(
        'https://api.geograph.org.uk/api/photo/$guid/${dotenv.env['GEOGRAPH_API_KEY']}?output=json'));

    const JsonDecoder decoder = JsonDecoder();
    final parsed = decoder.convert(response.body);
    var result = GeographApiPhotoResponse.fromJson(parsed, guid);

    return result;
  }
}
