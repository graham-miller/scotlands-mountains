import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TitleLogo extends StatelessWidget {
  const TitleLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text(
          'Scotland\'s',
          style: TextStyle(fontSize: 24),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 10, 0, 10),
          child: SvgPicture.asset(
            'assets/logo.svg',
            height: 28,
            colorFilter: ColorFilter.mode(
                Theme.of(context).colorScheme.onBackground, BlendMode.srcIn),
          ),
        ),
        const Text(
          'ountains',
          style: TextStyle(fontSize: 24),
        ),
      ],
    );
  }
}
