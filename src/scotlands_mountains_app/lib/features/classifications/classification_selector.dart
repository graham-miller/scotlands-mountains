import 'package:flutter/material.dart';

import '../../models/classification.dart';
import '../../repositories/classifications_repository.dart';

class ClassificationSelector extends StatefulWidget {
  final Function onClassificationSelected;

  const ClassificationSelector(
      {super.key, required this.onClassificationSelected});

  @override
  State<ClassificationSelector> createState() => _ClassificationSelectorState();
}

class _ClassificationSelectorState extends State<ClassificationSelector> {
  List<Classification> _classifications = List.empty();
  Classification? _selected;

  _ClassificationSelectorState() {
    _loadClassifications();
  }

  void _loadClassifications() async {
    final classifications = await ClassificationsRepository().getAll();

    setState(() {
      _classifications = classifications;
      _selected = classifications[0];
    });
  }

  @override
  void initState() {
    super.initState();
    _loadClassifications();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          DropdownButton<Classification>(
            value: _selected,
            icon: const Icon(Icons.arrow_drop_down),
            items: _classifications
                .map((c) => DropdownMenuItem<Classification>(
                    value: c, child: Text(c.name)))
                .toList(),
            onChanged: (value) => setState(
              () {
                widget.onClassificationSelected(value);
                _selected = value;
              },
            ),
          ),
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () => showDialog<String>(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: Text(_selected!.name),
                content: Text(_selected!.description),
                actions: <Widget>[
                  FilledButton(
                    child: const Text('Close'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
