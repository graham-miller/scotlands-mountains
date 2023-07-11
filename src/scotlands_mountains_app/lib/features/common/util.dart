import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class Util {
  static final _heightFormat = NumberFormat("#,###", "en_GB");

  static void openInBrowser(String url) async {
    launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
  }

  static String formatHeight(double height) {
    return '${_heightFormat.format(height)}m (${_heightFormat.format(height * 3.28084)}ft)';
  }
}
