import 'package:flutter/material.dart';

class Palette {
  late final Color _primaryColor;
  late final Color _altColor;
  late final double _fontSizeLarge;
  late final double _fontSizeMedium;
  late final double _fontSizeSmall;

  Palette(BuildContext context) {
    _primaryColor = Theme.of(context).colorScheme.onBackground;
    _altColor = Theme.of(context).colorScheme.background;
    _fontSizeLarge = Theme.of(context).textTheme.titleLarge!.fontSize!;
    _fontSizeMedium = Theme.of(context).textTheme.titleMedium!.fontSize!;
    _fontSizeSmall = Theme.of(context).textTheme.titleSmall!.fontSize!;
  }

  late final Paint line = Paint()
    ..color = _primaryColor
    ..style = PaintingStyle.stroke
    ..strokeWidth = 3;

  late final faintLine = Paint()
    ..color = _primaryColor
    ..style = PaintingStyle.stroke
    ..strokeWidth = 1;

  late final redLine = Paint()
    ..color = Colors.red
    ..style = PaintingStyle.stroke
    ..strokeWidth = 3;

  late final faintRedLine = Paint()
    ..color = Colors.red
    ..style = PaintingStyle.stroke
    ..strokeWidth = 1;

  late final textLarge = TextStyle(
    color: _primaryColor,
    fontSize: _fontSizeLarge,
  );
  late final textSmall = TextStyle(
    color: _primaryColor,
    fontSize: _fontSizeSmall,
  );

  late final redFill = Paint()
    ..color = Colors.red
    ..style = PaintingStyle.fill
    ..strokeWidth = 1;

  late final fill = Paint()
    ..color = _primaryColor
    ..style = PaintingStyle.fill
    ..strokeWidth = 1;

  late final textMediumWhite = TextStyle(
    color: Colors.white,
    fontSize: _fontSizeMedium,
  );

  late final textMediumAlt = TextStyle(
    color: _altColor,
    fontSize: _fontSizeMedium,
  );

  late final thickRoundLine = Paint()
    ..color = _altColor
    ..style = PaintingStyle.stroke
    ..strokeCap = StrokeCap.round
    ..strokeWidth = 10;
}
