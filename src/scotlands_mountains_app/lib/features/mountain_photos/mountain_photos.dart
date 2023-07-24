import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

import 'geograph_client.dart';
import '../common/util.dart';
import '../../models/mountain.dart';
import 'photo.dart';

class MountainPhotos extends StatefulWidget {
  final Mountain mountain;

  const MountainPhotos({super.key, required this.mountain});

  @override
  State<MountainPhotos> createState() => _MountainPhotosState();
}

class _MountainPhotosState extends State<MountainPhotos> {
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
      },
    );

    _searchPhotos();
  }

  @override
  void didUpdateWidget(covariant MountainPhotos oldWidget) {
    super.didUpdateWidget(oldWidget);
    _searchPhotos();
  }

  @override
  Widget build(BuildContext context) {
    if (_photos.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    return ListView(
      children: [
        _buildPhotoViewer(),
        _buildPhotoNavigator(),
        ..._buildPhotoDescription(),
      ],
    );
  }

  Widget _buildPhotoViewer() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
      child: CarouselSlider.builder(
        carouselController: _controller,
        options: _options,
        itemCount: _photos.length,
        itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) =>
            GestureDetector(
          child: CachedNetworkImage(
            imageUrl: _photos[itemIndex].imageUrl,
            placeholder: (context, url) =>
                const Center(child: CircularProgressIndicator()),
            errorWidget: (context, url, error) =>
                const Center(child: Icon(Icons.error)),
          ),
          onTap: () {
            showDialog<void>(
              context: context,
              builder: (BuildContext context) {
                return Dialog.fullscreen(
                  backgroundColor: Colors.black,
                  child: Stack(
                    children: [
                      PhotoView(
                        maxScale: 2.0,
                        imageProvider: CachedNetworkImageProvider(
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
                        ],
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildPhotoNavigator() {
    return Row(
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
    );
  }

  List<Widget> _buildPhotoDescription() {
    return [
      ListTile(
        title: Text(_photos[_index].title),
        subtitle: RichText(
          text: TextSpan(
            style: TextStyle(color: Theme.of(context).colorScheme.onBackground),
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
            ],
          ),
        ),
      ),
      ListTile(
        subtitle: Text(_photos[_index].description),
      ),
      ListTile(
        subtitle: RichText(
          text: TextSpan(
            style: TextStyle(color: Theme.of(context).colorScheme.onBackground),
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
    ];
  }

  void _searchPhotos() async {
    setState(() => _photos.clear());

    var photos = await GeographClient.searchPhotos(widget.mountain);

    setState(() => _photos.addAll(photos));
  }
}
