class TableUtil {
  static String formatTime(DateTime dateTime) {
    if (dateTime.hour == 0) {
      return 'Midnight';
    } else if (dateTime.hour == 12) {
      return 'Midday';
    } else if (dateTime.hour > 12) {
      return '${dateTime.hour - 12}pm';
    } else {
      return '${dateTime.hour}am';
    }
  }

  static String formatWeatherDescription(String s) {
    return s.replaceAll(' (night)', '');
  }
}
