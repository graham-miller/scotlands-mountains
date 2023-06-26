import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../widgets/app_scaffold.dart';

class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        body: Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _buildAboutCard(context, const Text('Developed by Graham Miller')),
        _buildAboutCard(context, _buildDobihCardContent(context))
      ],
    ));
  }

  Widget _buildAboutCard(BuildContext context, Widget child) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
              child: Card(
                  child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: child,
          )))
        ],
      ),
    );
  }

  Column _buildDobihCardContent(BuildContext context) {
    return Column(
      children: [
        RichText(
            selectionColor: Colors.black,
            text: TextSpan(
                text: 'Mountain data taken from ',
                style:
                    TextStyle(color: Theme.of(context).colorScheme.onSecondary),
                children: [
                  TextSpan(
                    text: 'The Database of British and Irish Hills v17.5',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () async {
                        launchUrl(Uri.parse('http://hills-database.co.uk/'),
                            mode: LaunchMode.externalApplication);
                      },
                  ),
                  const TextSpan(text: ', licensed under '),
                  TextSpan(
                    text:
                        'Creative Commons Attribution 4.0 International Licence',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () async {
                        launchUrl(
                            Uri.parse(
                                'https://creativecommons.org/licenses/by/4.0/'),
                            mode: LaunchMode.externalApplication);
                      },
                  ),
                  const TextSpan(text: '.'),
                ])),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 8.0, 0, 0),
              child: Image.asset('assets/cc-by.png'),
            ),
          ],
        )
      ],
    );
  }
}
