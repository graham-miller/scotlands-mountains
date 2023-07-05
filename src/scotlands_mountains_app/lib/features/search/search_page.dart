import 'package:flutter/material.dart';

import '../../repositories/mountains_repository.dart';
import 'search_term_highlighted_mountains_list.dart';
import '../../models/mountain.dart';
import '../map/mountains_map.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<Mountain> _mountains = List.empty();
  final _searchField = TextEditingController();

  _SearchPageState();

  @override
  void initState() {
    _searchField.addListener(_search);
    super.initState();
  }

  @override
  void dispose() {
    _searchField.removeListener(_search);
    super.dispose();
  }

  void _search() async {
    final term = _searchField.value.text;
    if (term.length > 2) {
      final mountains = await MountainsRepository().search(term);
      setState(() {
        _mountains = mountains;
      });
    } else {
      setState(() {
        _mountains = List.empty();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(33, 0, 40, 8),
              child: TextField(
                decoration: InputDecoration(
                    icon: const Icon(Icons.search),
                    suffixIcon: (_searchField.value.text) != ''
                        ? GestureDetector(
                            child: const Icon(Icons.clear),
                            onTap: () {
                              _searchField.clear();
                              _search();
                            },
                          )
                        : null),
                controller: _searchField,
              ),
            ),
            const TabBar(
              tabs: [
                Tab(text: 'List', icon: Icon(Icons.list)),
                Tab(text: 'Map', icon: Icon(Icons.map)),
              ],
            ),
            Expanded(
                child: TabBarView(children: [
              SearchTermHighlightedMountainsList(
                  mountains: _mountains, term: _searchField.value.text),
              MountainsMap(mountains: _mountains),
            ]))
          ],
        ));
  }
}