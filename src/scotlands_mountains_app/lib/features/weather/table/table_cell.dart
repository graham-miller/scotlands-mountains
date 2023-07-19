import 'package:flutter/material.dart';

class TextCell extends StatelessWidget {
  final String text;

  const TextCell({required this.text, super.key});

  @override
  Widget build(BuildContext context) {
    return Cell(
      background: Theme.of(context).colorScheme.secondaryContainer,
      child: Text(
        text,
        style: TextStyle(
            color: Theme.of(context).colorScheme.onSecondaryContainer),
        textAlign: TextAlign.center,
      ),
    );
  }
}

class WidgetCell extends StatelessWidget {
  final Widget child;

  const WidgetCell({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return Cell(
      background: Theme.of(context).colorScheme.secondaryContainer,
      child: child,
    );
  }
}

class HeaderCell extends StatelessWidget {
  final String text;

  const HeaderCell({required this.text, super.key});

  @override
  Widget build(BuildContext context) {
    return Cell(
      background: Theme.of(context).colorScheme.primaryContainer,
      child: Text(
        text,
        style:
            TextStyle(color: Theme.of(context).colorScheme.onPrimaryContainer),
        textAlign: TextAlign.center,
      ),
    );
  }
}

class Cell extends StatelessWidget {
  final Color background;
  final Widget child;

  const Cell({super.key, required this.background, required this.child});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width: 100,
      child: Padding(
        padding: const EdgeInsets.only(right: 4, bottom: 4),
        child: Container(
          color: background,
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Center(child: child),
          ),
        ),
      ),
    );
  }
}
