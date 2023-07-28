import 'dart:collection';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:vector_math/vector_math.dart';

class CompassPainter extends CustomPainter {
  late final Paint line;
  late final Paint faint;
  late final TextStyle textLarge;
  late final TextStyle textSmall;

  CompassPainter(BuildContext context) {
    line = Paint()
      ..color = Theme.of(context).colorScheme.onBackground
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;
    faint = Paint()
      ..color = Theme.of(context).colorScheme.onBackground
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    textLarge = TextStyle(
      color: Theme.of(context).colorScheme.onBackground,
      fontSize: Theme.of(context).textTheme.titleLarge!.fontSize,
    );
    textSmall = TextStyle(
      color: Theme.of(context).colorScheme.onBackground,
      fontSize: Theme.of(context).textTheme.titleSmall!.fontSize,
    );
  }

  @override
  void paint(Canvas canvas, Size size) {
    final maxSize = min(size.height, size.width);
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (maxSize - 64) / 2;

    canvas.drawCircle(center, radius, line);
    canvas.drawPoints(PointMode.points, [center], line);

    canvas.save();

    for (int degrees = 0; degrees < 360; degrees++) {
      canvas.translate(center.dx, center.dy);
      canvas.rotate(radians(1));
      canvas.translate(-center.dx, -center.dy);

      if (degrees % 20 == 0) {
        canvas.drawLine(Offset(center.dx, center.dy - radius),
            Offset(center.dx, center.dy - radius + 15), line);
      } else if (degrees % 10 == 0) {
        canvas.drawLine(Offset(center.dx, center.dy - radius),
            Offset(center.dx, center.dy - radius + 10), line);
      } else if (degrees % 2 == 0) {
        canvas.drawLine(Offset(center.dx, center.dy - radius),
            Offset(center.dx, center.dy - radius + 5), faint);
      }

      if (degrees % 10 == 0) {
        String? label;
        TextStyle textStyle = textLarge;
        if (degrees == 0) {
          label = 'N';
        } else if (degrees == 90) {
          textStyle = textSmall;
          label = 'E';
        } else if (degrees == 180) {
          label = 'S';
        } else if (degrees == 270) {
          textStyle = textSmall;
          label = 'W';
        } else if (degrees % 20 == 0) {
          textStyle = textSmall;
          label = degrees.toString();
        }
        if (label != null) {
          _writePointLabel(canvas, label, center, radius, textStyle);
        }
      }
    }

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }

  void _writePointLabel(
      Canvas canvas, String label, Offset center, double radius, textStyle) {
    final textPainter = TextPainter(
      text: TextSpan(text: label, style: textStyle),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(canvas,
        Offset(center.dx - (textPainter.width / 2), center.dy - radius + 20));
  }
}

class Compass extends StatelessWidget {
  const Compass({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CustomPaint(
        painter: CompassPainter(context),
      ),
    );
  }
}
