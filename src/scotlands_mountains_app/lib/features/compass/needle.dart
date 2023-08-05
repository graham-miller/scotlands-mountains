import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:vector_math/vector_math.dart' hide Colors;

import 'palette.dart';

class Needle extends StatelessWidget {
  const Needle({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: NeedlePainter(context: context),
    );
  }
}

class NeedlePainter extends CustomPainter {
  late final BuildContext context;

  NeedlePainter({required this.context});

  @override
  void paint(Canvas canvas, Size size) {
    NeedleIteration(context: context, canvas: canvas, size: size).paint();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class NeedleIteration {
  final Canvas _canvas;
  late final double _maxSize;
  late final Offset _center;
  late final double _radius;
  late final Palette _palette;

  NeedleIteration(
      {required BuildContext context, required Canvas canvas, required size})
      : _canvas = canvas {
    _maxSize = min(size.height, size.width);
    _center = Offset(size.width / 2, size.height / 2);
    _radius = (_maxSize - 64) / 2;
    _palette = Palette(context);
  }

  void paint() {
    _drawEnd('N', _palette.redFill, _palette.textMediumWhite);

    _canvas.save();
    _canvas.translate(_center.dx, _center.dy);
    _canvas.rotate(radians(180));
    _canvas.translate(-_center.dx, -_center.dy);

    _drawEnd('S', _palette.fill, _palette.textMediumAlt);

    _canvas.restore();

    _canvas.drawPoints(PointMode.points, [_center], _palette.thickRoundLine);
  }

  void _drawEnd(String label, Paint paint, TextStyle textStyle) {
    _canvas.drawPath(
        Path()
          ..addPolygon([
            _center,
            Offset(_center.dx + 7, _center.dy),
            Offset(_center.dx + 7, _center.dy - _radius + 65),
            Offset(_center.dx, _center.dy - _radius + 55),
            Offset(_center.dx - 7, _center.dy - _radius + 65),
            Offset(_center.dx - 7, _center.dy),
          ], true),
        paint);

    final textPainterS = TextPainter(
      text: TextSpan(text: label, style: textStyle),
      textDirection: TextDirection.ltr,
    );
    textPainterS.layout();
    textPainterS.paint(
        _canvas,
        Offset(
            _center.dx - (textPainterS.width / 2), _center.dy - _radius + 65));
  }
}
