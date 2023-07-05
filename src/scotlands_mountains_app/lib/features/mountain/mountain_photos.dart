import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:photo_view/photo_view.dart';

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
  final _controller = CarouselController();
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
            carouselController: _controller,
            options: _options,
            itemCount: _photos.length,
            itemBuilder: (BuildContext context, int itemIndex,
                    int pageViewIndex) =>
                GestureDetector(
                    child: Image.network(_photos[itemIndex].imageUrl),
                    onTap: () {
                      showDialog<void>(
                        context: context,
                        builder: (BuildContext context) {
                          return Dialog.fullscreen(
                              backgroundColor: Colors.black,
                              child: Stack(
                                children: [
                                  PhotoView(
                                    imageProvider: NetworkImage(
                                        _photos[itemIndex].imageUrl),
                                  ),
                                  Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        IconButton(
                                          icon: const Icon(Icons.close),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ])
                                ],
                              ));
                        },
                      );
                    }),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: const Icon(Icons.chevron_left),
              onPressed: _index == 0
                  ? null
                  : () {
                      _controller.previousPage();
                    },
            ),
            Text('${_index + 1} of ${_photos.length}'),
            IconButton(
              icon: const Icon(Icons.chevron_right),
              onPressed: _index == _photos.length - 1
                  ? null
                  : () {
                      _controller.nextPage();
                    },
            ),
          ],
        ),
        ListTile(
          title: Text(_photos[_index].title),
          subtitle: RichText(
            text: TextSpan(
                style: TextStyle(
                    color: Theme.of(context).colorScheme.onBackground),
                text: 'Photo © ',
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
                  const TextSpan(text: ' ('),
                  TextSpan(
                    text: 'cc-by-sa/2.0',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Util.openInBrowser(_photos[_index].licenceUrl);
                      },
                  ),
                  const TextSpan(text: ')'),
                ]),
          ),
        ),
        ListTile(
          subtitle: Text(_photos[_index].description),
        ),
        ListTile(
          subtitle: RichText(
            text: TextSpan(
              style:
                  TextStyle(color: Theme.of(context).colorScheme.onBackground),
              //text: 'Source: ',
              children: [
                TextSpan(
                  text: _photos[_index].geographUrl,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Util.openInBrowser(_photos[_index].geographUrl);
                    },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void searchPhotos() async {
    setState(() => _photos.clear());

    // TODO remove any part of name in (..)
    final String term = Uri.encodeComponent(widget.mountain.name);
    final parts = widget.mountain.gridRef.split(' ');
    final gridRef =
        parts[0] + parts[1].substring(0, 2) + parts[2].substring(0, 2);
    final url =
        'https://api.geograph.org.uk/syndicator.php?key=${dotenv.env['GEOGRAPH_API_KEY']}&text=$term+near+$gridRef&perpage=10&format=JSON';

    final response = await _client.get(Uri.parse(url));

    const JsonDecoder decoder = JsonDecoder();
    final parsed = decoder.convert(response.body);
    final result = GeographApiSearchResponse.fromJson(parsed);

    var photos = await Future.wait(result.items.map((e) async =>
        Photo.fromGeographResponse(e, await getPhotoInfo(e.guid))));

    setState(() => _photos.addAll(photos));
  }

  Future<GeographApiPhotoResponse> getPhotoInfo(String guid) async {
    final url =
        'https://api.geograph.org.uk/api/photo/$guid/${dotenv.env['GEOGRAPH_API_KEY']}?output=json';
    final response = await _client.get(Uri.parse(url));

    const JsonDecoder decoder = JsonDecoder();
    final parsed = decoder.convert(response.body);
    var result = GeographApiPhotoResponse.fromJson(parsed);

    return result;
  }
}
