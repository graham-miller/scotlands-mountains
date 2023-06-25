import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TitleLogo extends StatelessWidget {
  final Color color;

  const TitleLogo({super.key, required this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          'Scotland\'s',
          style: TextStyle(color: color, fontSize: 24),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 10, 0, 10),
          child: SvgPicture.asset(
            'assets/logo.svg',
            height: 28,
            colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
          ),
        ),
        Text(
          'ountains',
          style: TextStyle(color: color, fontSize: 24),
        ),
      ],
    );
  }
}
