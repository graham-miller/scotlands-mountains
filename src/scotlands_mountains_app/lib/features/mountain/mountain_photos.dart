import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import '../shared/util.dart';
import 'geograph_api_response.dart';
import '../../models/mountain.dart';
import 'models/photo.dart';

class MountainPhotos extends StatefulWidget {
  final client = http.Client();
  final Mountain mountain;

  MountainPhotos({super.key, required this.mountain});

  @override
  State<MountainPhotos> createState() => _MountainPhotosState();
}

class _MountainPhotosState extends State<MountainPhotos> {
  final _client = http.Client();
  final List<Photo> _photos = List.empty(growable: true);
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
              itemBuilder:
                  (BuildContext context, int itemIndex, int pageViewIndex) =>
                      Image.network(_photos[itemIndex].imageUrl)),
        ),
        ListTile(
          title: Text(_photos[_index].title),
        ),
        ListTile(
          subtitle: Text(_photos[_index].description),
        ),
        ListTile(
          subtitle: RichText(
            text: TextSpan(
              style:
                  TextStyle(color: Theme.of(context).colorScheme.onBackground),
              text: '© Copyright ',
              children: [
                TextSpan(
                  text: _photos[_index].author,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Util.openInBrowser(_photos[_index].authorUrl);
                    },
                ),
                const TextSpan(text: ' and licensed for '),
                TextSpan(
                  text: 'reuse',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Util.openInBrowser(_photos[_index].reuseUrl);
                    },
                ),
                const TextSpan(text: ' under this '),
                TextSpan(
                  text: 'Creative Commons Licence',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Util.openInBrowser(_photos[_index].licenceUrl);
                    },
                ),
                const TextSpan(text: '.'),
                const TextSpan(text: ' Source: '),
                TextSpan(
                  text: 'Geograph',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Util.openInBrowser(_photos[_index].geographUrl);
                    },
                ),
                const TextSpan(text: '.'),
              ],
            ),
          ),
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

    var photos = await Future.wait(result.items.map((e) async =>
        Photo.fromGeographResponse(e, await getPhotoInfo(e.guid))));

    setState(() => _photos.addAll(photos));
  }

  Future<GeographApiPhotoResponse> getPhotoInfo(String guid) async {
    final response = await _client.get(Uri.parse(
        'https://api.geograph.org.uk/api/photo/$guid/${dotenv.env['GEOGRAPH_API_KEY']}?output=json'));

    const JsonDecoder decoder = JsonDecoder();
    final parsed = decoder.convert(response.body);
    var result = GeographApiPhotoResponse.fromJson(parsed);

    return result;
  }
}
