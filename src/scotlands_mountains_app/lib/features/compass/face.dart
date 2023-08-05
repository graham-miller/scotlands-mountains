import 'dart:math';

import 'package:flutter/material.dart';
import 'package:vector_math/vector_math.dart' hide Colors;

import 'palette.dart';

class Face extends StatelessWidget {
  const Face({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: FacePainter(context: context),
    );
  }
}

class FacePainter extends CustomPainter {
  late final BuildContext context;

  FacePainter({required this.context});

  @override
  void paint(Canvas canvas, Size size) {
    FaceIteration(context: context, canvas: canvas, size: size).paint();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class FaceIteration {
  final Canvas _canvas;
  late final double _maxSize;
  late final Offset _center;
  late final double _radius;
  late final Palette _palette;

  FaceIteration(
      {required BuildContext context, required Canvas canvas, required size})
      : _canvas = canvas {
    _maxSize = min(size.height, size.width);
    _center = Offset(size.width / 2, size.height / 2);
    _radius = (_maxSize - 64) / 2;
    _palette = Palette(context);
  }

  void paint() {
    _canvas.drawCircle(_center, _radius, _palette.line);
    _paintOrientationLines();

    _canvas.save();
    for (int degrees = 0; degrees < 360; degrees++) {
      _paintTicks(degrees);
      _paintLabels(degrees);

      _canvas.translate(_center.dx, _center.dy);
      _canvas.rotate(radians(1));
      _canvas.translate(-_center.dx, -_center.dy);
    }

    _canvas.restore();
  }

  void _paintTicks(int degrees) {
    if (degrees % 20 == 0) {
      _canvas.drawLine(Offset(_center.dx, _center.dy - _radius),
          Offset(_center.dx, _center.dy - _radius + 15), _palette.line);
    } else if (degrees % 10 == 0) {
      _canvas.drawLine(Offset(_center.dx, _center.dy - _radius),
          Offset(_center.dx, _center.dy - _radius + 10), _palette.line);
    } else if (degrees % 2 == 0) {
      _canvas.drawLine(Offset(_center.dx, _center.dy - _radius),
          Offset(_center.dx, _center.dy - _radius + 5), _palette.faintLine);
    }
  }

  void _paintLabels(int degrees) {
    if (degrees % 10 == 0) {
      String? label;
      TextStyle textStyle = _palette.textLarge;
      if (degrees == 0) {
        label = 'N';
      } else if (degrees == 90) {
        textStyle = _palette.textSmall;
        label = 'E';
      } else if (degrees == 180) {
        label = 'S';
      } else if (degrees == 270) {
        textStyle = _palette.textSmall;
        label = 'W';
      } else if (degrees % 20 == 0) {
        textStyle = _palette.textSmall;
        label = degrees.toString();
      }
      if (label != null) {
        _writePointLabel(label, textStyle);
      }
    }
  }

  void _writePointLabel(String label, textStyle) {
    final textPainter = TextPainter(
      text: TextSpan(text: label, style: textStyle),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(
        _canvas,
        Offset(
            _center.dx - (textPainter.width / 2), _center.dy - _radius + 20));
  }

  void _paintOrientationLines() {
    final double radius = _radius - 60;
    const double allowanceForNeedle = 12;

    _paintOrientationArrow(radius, allowanceForNeedle);

    final spacing = (radius - allowanceForNeedle) / 3;
    for (var position = 1; position < 3; position++) {
      var height = sqrt(
          square(radius) - square((position * spacing) + allowanceForNeedle));
      _canvas.drawLine(
          Offset(_center.dx - (position * spacing) - allowanceForNeedle,
              _center.dy),
          Offset(_center.dx - (position * spacing) - allowanceForNeedle,
              _center.dy + height),
          _palette.faintLine);
      _canvas.drawLine(
          Offset(_center.dx + (position * spacing) + allowanceForNeedle,
              _center.dy),
          Offset(_center.dx + (position * spacing) + allowanceForNeedle,
              _center.dy + height),
          _palette.faintLine);
      _canvas.drawLine(
          Offset(_center.dx - (position * spacing) - allowanceForNeedle,
              _center.dy),
          Offset(_center.dx - (position * spacing) - allowanceForNeedle,
              _center.dy - height),
          _palette.faintRedLine);
      _canvas.drawLine(
          Offset(_center.dx + (position * spacing) + allowanceForNeedle,
              _center.dy),
          Offset(_center.dx + (position * spacing) + allowanceForNeedle,
              _center.dy - height),
          _palette.faintRedLine);
    }
  }

  void _paintOrientationArrow(double radius, double allowanceForNeedle) {
    _canvas.drawLine(
        Offset(_center.dx - allowanceForNeedle, _center.dy),
        Offset(_center.dx - allowanceForNeedle,
            _center.dy - sqrt(square(radius) - square(allowanceForNeedle))),
        _palette.redLine);
    _canvas.drawLine(
        Offset(_center.dx + allowanceForNeedle, _center.dy),
        Offset(_center.dx + allowanceForNeedle,
            _center.dy - sqrt(square(radius) - square(allowanceForNeedle))),
        _palette.redLine);

    _canvas.drawLine(
        Offset(_center.dx, _center.dy - radius - allowanceForNeedle),
        Offset(
            _center.dx - allowanceForNeedle - allowanceForNeedle,
            _center.dy -
                sqrt(square(radius) - square((4 * allowanceForNeedle)))),
        _palette.redLine);
    _canvas.drawLine(
        Offset(_center.dx, _center.dy - radius - 12),
        Offset(
            _center.dx + allowanceForNeedle + allowanceForNeedle,
            _center.dy -
                sqrt(square(radius) - square((4 * allowanceForNeedle)))),
        _palette.redLine);

    _canvas.drawLine(
        Offset(_center.dx - allowanceForNeedle, _center.dy),
        Offset(_center.dx - allowanceForNeedle,
            _center.dy + sqrt(square(radius) - square(allowanceForNeedle))),
        _palette.line);
    _canvas.drawLine(
        Offset(_center.dx + allowanceForNeedle, _center.dy),
        Offset(_center.dx + allowanceForNeedle,
            _center.dy + sqrt(square(radius) - square(allowanceForNeedle))),
        _palette.line);
  }

  num square(double d) => pow(d, 2);
}
