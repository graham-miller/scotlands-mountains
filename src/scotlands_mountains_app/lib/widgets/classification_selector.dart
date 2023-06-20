import 'package:flutter/material.dart';

class ClassificationSelector extends StatefulWidget {
  const ClassificationSelector({super.key});

  @override
  State<ClassificationSelector> createState() => _ClassificationSelectorState();
}

class _ClassificationSelectorState extends State<ClassificationSelector> {
  var models = [
    Model(1, 'Munros', 'Descripition 1'),
    Model(2, 'Corbetts', 'Descripition 2'),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: DropdownMenu<Model>(
          textStyle: const TextStyle(fontSize: 20),
          inputDecorationTheme:
              const InputDecorationTheme(border: InputBorder.none),
          initialSelection: models[0],
          dropdownMenuEntries: models
              .map((e) => DropdownMenuEntry<Model>(value: e, label: e.name))
              .toList(),
          onSelected: (value) => print(value?.name),
        ));
  }
}

class Model {
  final int id;
  final String name;
  final String description;

  Model(this.id, this.name, this.description);
}
