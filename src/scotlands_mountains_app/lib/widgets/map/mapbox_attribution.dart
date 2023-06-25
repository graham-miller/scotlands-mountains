import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

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
                      onPressed: () async {
                        launchUrl(
                            Uri.parse('https://www.mapbox.com/about/maps/'),
                            mode: LaunchMode.externalApplication);
                      }),
                  TextButton(
                      child: const Text('© OpenStreetMap'),
                      onPressed: () async {
                        launchUrl(
                            Uri.parse('http://www.openstreetmap.org/about/'),
                            mode: LaunchMode.externalApplication);
                      }),
                  TextButton(
                      child: const Text('Improve this map'),
                      onPressed: () async {
                        launchUrl(
                            Uri.parse('https://www.mapbox.com/map-feedback/'),
                            mode: LaunchMode.externalApplication);
                      })
                ],
              ),
              actions: <Widget>[
                TextButton(
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
