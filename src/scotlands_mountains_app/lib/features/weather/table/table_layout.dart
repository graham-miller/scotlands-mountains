import 'package:flutter/material.dart';
import 'package:linked_scroll_controller/linked_scroll_controller.dart';

class TableLayout extends StatefulWidget {
  final List<Widget> headerColumn;
  final List<List<Widget>> dataColumns;
  final LinkedScrollControllerGroup scrollGroup;

  const TableLayout(
      {required this.headerColumn,
      required this.dataColumns,
      super.key,
      required this.scrollGroup});

  @override
  State<TableLayout> createState() => _TableLayoutState();
}

class _TableLayoutState extends State<TableLayout> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = widget.scrollGroup.addAndGet();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: SingleChildScrollView(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [...widget.headerColumn],
            ),
            Flexible(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                controller: _scrollController,
                child: Row(
                  children: [
                    ...widget.dataColumns.map(
                      (c) => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: c,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
