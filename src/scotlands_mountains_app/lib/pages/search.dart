import 'package:flutter/material.dart';
import 'package:scotlands_mountains_app/repositories/mountains_repository.dart';
import '../models/mountain.dart';
import '../widgets/app_scaffold.dart';
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
  bool _showMap = false;

  _SearchState();

  void _search(String term) async {
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
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: Column(
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
                            _search('');
                          },
                        )
                      : null),
              controller: _searchField,
              onChanged: (term) {
                _search(term);
              },
            ),
          ),
          Expanded(
              child: _showMap
                  ? MountainsMap(mountains: _mountains)
                  : MountainsList(mountains: _mountains)),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              label: 'List',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.map),
              label: 'Map',
            ),
          ],
          currentIndex: _showMap ? 1 : 0,
          onTap: (i) => setState(() {
                _showMap = i == 1;
              })),
    );
  }
}
