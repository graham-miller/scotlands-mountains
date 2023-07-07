import 'package:flutter/material.dart';

class ListOrMapOfMountains extends StatefulWidget {
  final Widget list;
  final Widget map;

  const ListOrMapOfMountains(
      {super.key, required this.list, required this.map});

  @override
  State<ListOrMapOfMountains> createState() => _ListOrMapOfMountainsState();
}

class _ListOrMapOfMountainsState extends State<ListOrMapOfMountains>
    with SingleTickerProviderStateMixin {
  late final _tabController = TabController(length: 2, vsync: this);

  @override
  void initState() {
    _tabController.addListener(_tabswitched);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.removeListener(_tabswitched);
    super.dispose();
  }

  void _tabswitched() {
    ScaffoldMessenger.of(context).clearSnackBars();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          TabBar(
            controller: _tabController,
            tabs: const [
              Tab(text: 'List', icon: Icon(Icons.list)),
              Tab(text: 'Map', icon: Icon(Icons.map)),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [widget.list, widget.map],
            ),
          ),
        ],
      ),
    );
  }
}
