import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../features/common/util.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 30, 0, 30),
              child: SvgPicture.asset(
                'assets/logo.svg',
                width: MediaQuery.of(context).size.width / 3,
                colorFilter: ColorFilter.mode(
                    Theme.of(context).colorScheme.onBackground,
                    BlendMode.srcIn),
              ),
            )
          ],
        ),
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Made with '),
            Icon(
              Icons.favorite_rounded,
              color: Colors.red,
            ),
            Text(' by Graham.'),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 32, 16, 0),
              child: Text('Acknowledgements',
                  style: TextStyle(
                      fontSize:
                          Theme.of(context).textTheme.titleMedium!.fontSize)),
            )
          ],
        ),
        Expanded(
          child: ListView(
            children: [
              _buildDobihListTile(context),
              _buildMapboxListTile(context),
              _buildGeographListTile(context),
              _buildWeatherListTile(context),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDobihListTile(BuildContext context) {
    return ListTile(
      title: const Text('Mountain data'),
      subtitle: RichText(
        text: TextSpan(
          text: '© ',
          style: TextStyle(color: Theme.of(context).colorScheme.onBackground),
          children: [
            TextSpan(
              text: 'The Database of British and Irish Hills v17.5',
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  Util.openInBrowser('http://hills-database.co.uk/');
                },
            ),
            const TextSpan(text: ' licensed under the '),
            TextSpan(
              text: 'Creative Commons Attribution 4.0 International Licence',
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  Util.openInBrowser(
                      'https://creativecommons.org/licenses/by/4.0/');
                },
            ),
            const TextSpan(text: '.'),
          ],
        ),
      ),
    );
  }

  Widget _buildMapboxListTile(BuildContext context) {
    return ListTile(
      title: const Text('Mapping'),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text('© '),
              GestureDetector(
                onTap: () =>
                    Util.openInBrowser('https://www.mapbox.com/about/maps/'),
                child: Text(
                  'Mapbox',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              const Text('© '),
              GestureDetector(
                onTap: () =>
                    Util.openInBrowser('http://www.openstreetmap.org/about/'),
                child: Text(
                  'OpenStreetMap',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              const Text('© '),
              GestureDetector(
                onTap: () => Util.openInBrowser('https://www.maxar.com/'),
                child: Text(
                  'Maxar',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildGeographListTile(BuildContext context) {
    return ListTile(
      title: const Text('Photographs'),
      subtitle: RichText(
        text: TextSpan(
          text: '© ',
          style: TextStyle(color: Theme.of(context).colorScheme.onBackground),
          children: [
            TextSpan(
              text: 'Geograph contributors',
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  Util.openInBrowser('https://www.geograph.org.uk/credits/');
                },
            ),
            const TextSpan(text: ' licensed under the '),
            TextSpan(
              text: 'Creative Commons Attribution-ShareAlike licence',
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  Util.openInBrowser(
                      'https://creativecommons.org/licenses/by-sa/2.0/');
                },
            ),
            const TextSpan(text: '.'),
          ],
        ),
      ),
    );
  }

  Widget _buildWeatherListTile(BuildContext context) {
    return ListTile(
      title: const Text('Weather'),
      subtitle: RichText(
        text: TextSpan(
          text: 'Contains public sector information licensed under the  ',
          style: TextStyle(color: Theme.of(context).colorScheme.onBackground),
          children: [
            TextSpan(
              text: 'Open Government Licence v3.0',
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  Util.openInBrowser(
                      'https://www.nationalarchives.gov.uk/doc/open-government-licence/version/3/');
                },
            ),
            const TextSpan(text: '.'),
          ],
        ),
      ),
    );
  }
}
