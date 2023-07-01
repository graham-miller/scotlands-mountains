import 'package:flutter/material.dart';

import '../shared/util.dart';

class MapboxAttribution extends StatelessWidget {
  const MapboxAttribution({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        GestureDetector(
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset('assets/mapbox-logo-white.png', height: 25),
              ),
              const Icon(Icons.info_outline, color: Colors.white)
            ],
          ),
          onTap: () => showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: Image.asset('assets/mapbox-logo-black.png', height: 25),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextButton(
                      child: const Text('© Mapbox'),
                      onPressed: () {
                        Util.openInBrowser(
                            'https://www.mapbox.com/about/maps/');
                      }),
                  TextButton(
                      child: const Text('© OpenStreetMap'),
                      onPressed: () {
                        Util.openInBrowser(
                            'http://www.openstreetmap.org/about/');
                      }),
                  TextButton(
                      child: const Text('Improve this map'),
                      onPressed: () {
                        Util.openInBrowser(
                            'https://www.mapbox.com/map-feedback/');
                      })
                ],
              ),
              actions: <Widget>[
                FilledButton(
                  child: const Text('Close'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
