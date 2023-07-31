import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:vector_math/vector_math.dart' hide Colors;

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
  final BuildContext _context;
  final Canvas _canvas;
  late final double _maxSize;
  late final Offset _center;
  late final double _radius;
  late final Paint _north;
  late final Paint _south;
  late final TextStyle _textN;
  late final TextStyle _textS;
  late final Paint _pivot;

  NeedleIteration(
      {required BuildContext context, required Canvas canvas, required size})
      : _canvas = canvas,
        _context = context {
    _maxSize = min(size.height, size.width);
    _center = Offset(size.width / 2, size.height / 2);
    _radius = (_maxSize - 64) / 2;
    _north = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;
    _south = Paint()
      ..color = Theme.of(_context).colorScheme.onBackground
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;
    _textN = TextStyle(
      color: Colors.white,
      fontSize: Theme.of(_context).textTheme.titleMedium!.fontSize,
    );
    _textS = TextStyle(
      color: Theme.of(_context).colorScheme.background,
      fontSize: Theme.of(_context).textTheme.titleMedium!.fontSize,
    );
    _pivot = Paint()
      ..color = Theme.of(_context).colorScheme.background
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 10;
  }

  void paint() {
    _drawEnd('N', _north, _textN);

    _canvas.save();
    _canvas.translate(_center.dx, _center.dy);
    _canvas.rotate(radians(180));
    _canvas.translate(-_center.dx, -_center.dy);

    _drawEnd('S', _south, _textS);

    _canvas.restore();

    _canvas.drawPoints(PointMode.points, [_center], _pivot);
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
