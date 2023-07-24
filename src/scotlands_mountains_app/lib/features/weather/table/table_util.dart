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

  static String metOfficeToYrCode(String code) {
    return _codeLookUp[code]!;
  }

  static final _codeLookUp = {
    '0': '01n',
    '1': '01d',
    '2': '03n',
    '3': '03d',
    '5': '15',
    '6': '15',
    '7': '4',
    '8': '4',
    '9': '40n',
    '10': '40d',
    '11': '46',
    '12': '9',
    '13': '41n',
    '14': '41d',
    '15': '10',
    '16': '42n',
    '17': '42d',
    '18': '47',
    '19': '42n',
    '20': '42d',
    '21': '47',
    '22': '44n',
    '23': '44d',
    '24': '49',
    '25': '45n',
    '26': '45d',
    '27': '50',
    '28': '06n',
    '29': '06d',
    '30': '22',
  };
}
