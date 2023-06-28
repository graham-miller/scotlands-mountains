import 'package:flutter/material.dart';
import 'package:scotlands_mountains_app/repositories/mountains_repository.dart';
import '../models/mountain.dart';
import '../widgets/map/mountains_map.dart';
import '../widgets/mountains_list.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  List<Mountain> _mountains = List.empty();
  final _searchField = TextEditingController();

  _SearchState();

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
            const TabBar(
              tabs: [
                Tab(text: 'List', icon: Icon(Icons.list)),
                Tab(text: 'Map', icon: Icon(Icons.map)),
              ],
            ),
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
            Expanded(
                child: TabBarView(children: [
              MountainsList(mountains: _mountains),
              MountainsMap(mountains: _mountains),
            ]))
          ],
        ));
  }
}
