import 'package:flutter/material.dart';

import '../classifications/mountains_list.dart';

class SearchTermHighlightedMountainsList extends MountainsList {
  final String term;

  const SearchTermHighlightedMountainsList(
      {super.key, required mountains, required this.term})
      : super(mountains: mountains);

  @override
  Widget getName(String name, BuildContext context) {
    final style = TextStyle(
        color: Theme.of(context).colorScheme.onSecondaryContainer,
        backgroundColor: Theme.of(context).colorScheme.secondaryContainer);
    final List<TextSpan> segments = List.empty(growable: true);

    var remaining = name;
    final regex = RegExp(term, caseSensitive: false);

    while (remaining.isNotEmpty) {
      var start = remaining.indexOf(regex);
      if (start >= 0) {
        if (start != 0) {
          segments.add(TextSpan(text: remaining.substring(0, start)));
        }
        segments.add(TextSpan(
            text: remaining.substring(start, start + term.length),
            style: style));
        remaining = remaining.substring(start + term.length);
      } else {
        segments.add(TextSpan(text: remaining));
        remaining = '';
      }
    }

    return RichText(
      text: TextSpan(
          text: '',
          style: TextStyle(color: Theme.of(context).colorScheme.onBackground),
          children: segments),
    );
  }
}
