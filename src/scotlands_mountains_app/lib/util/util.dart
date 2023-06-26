import 'package:url_launcher/url_launcher.dart';

class Util {
  static void openInBrowser(String url) async {
    launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
  }
}
