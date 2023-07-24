import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../common/util.dart';

class LicensesPage extends StatelessWidget {
  const LicensesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _buildAboutCard(context, _buildDobihCardContent(context)),
        _buildAboutCard(context, _buildMetOfficeCardContent(context))
      ],
    );
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
              ),
            ),
          ),
        ],
      ),
    );
  }

  Column _buildDobihCardContent(BuildContext context) {
    return Column(
      children: [
        RichText(
          text: TextSpan(
            text: 'Mountain data taken from ',
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
              const TextSpan(text: ', licensed under '),
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
      ],
    );
  }

  Widget _buildMetOfficeCardContent(BuildContext context) {
    return RichText(
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
    );
  }
}
