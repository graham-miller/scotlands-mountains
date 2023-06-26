import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Hyperlink extends InlineSpan {
  String text;
  String url;

  Hyperlink({super.key, required this.text, required this.url});

  @override
  Widget build(BuildContext context) {
    return TextSpan(
      text: text,
      recognizer: TapGestureRecognizer()
        ..onTap = () async {
          launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
        },
    );
  }
}
