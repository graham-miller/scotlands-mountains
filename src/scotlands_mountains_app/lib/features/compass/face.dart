import 'dart:math';

import 'package:flutter/material.dart';
import 'package:vector_math/vector_math.dart';

class Face extends StatelessWidget {
  const Face({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CustomPaint(
        painter: FacePainter(context: context),
      ),
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
  final BuildContext _context;
  final Canvas _canvas;
  late final double _maxSize;
  late final Offset _center;
  late final double _radius;
  late final Paint _line;
  late final Paint _faint;
  late final TextStyle _textLarge;
  late final TextStyle _textSmall;

  FaceIteration(
      {required BuildContext context, required Canvas canvas, required size})
      : _canvas = canvas,
        _context = context {
    _maxSize = min(size.height, size.width);
    _center = Offset(size.width / 2, size.height / 2);
    _radius = (_maxSize - 64) / 2;
    _line = Paint()
      ..color = Theme.of(_context).colorScheme.onBackground
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;
    _faint = Paint()
      ..color = Theme.of(_context).colorScheme.onBackground
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    _textLarge = TextStyle(
      color: Theme.of(_context).colorScheme.onBackground,
      fontSize: Theme.of(_context).textTheme.titleLarge!.fontSize,
    );
    _textSmall = TextStyle(
      color: Theme.of(_context).colorScheme.onBackground,
      fontSize: Theme.of(_context).textTheme.titleSmall!.fontSize,
    );
  }

  void paint() {
    _canvas.drawCircle(_center, _radius, _line);

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
          Offset(_center.dx, _center.dy - _radius + 15), _line);
    } else if (degrees % 10 == 0) {
      _canvas.drawLine(Offset(_center.dx, _center.dy - _radius),
          Offset(_center.dx, _center.dy - _radius + 10), _line);
    } else if (degrees % 2 == 0) {
      _canvas.drawLine(Offset(_center.dx, _center.dy - _radius),
          Offset(_center.dx, _center.dy - _radius + 5), _faint);
    }
  }

  void _paintLabels(int degrees) {
    if (degrees % 10 == 0) {
      String? label;
      TextStyle textStyle = _textLarge;
      if (degrees == 0) {
        label = 'N';
      } else if (degrees == 90) {
        textStyle = _textSmall;
        label = 'E';
      } else if (degrees == 180) {
        label = 'S';
      } else if (degrees == 270) {
        textStyle = _textSmall;
        label = 'W';
      } else if (degrees % 20 == 0) {
        textStyle = _textSmall;
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
}
