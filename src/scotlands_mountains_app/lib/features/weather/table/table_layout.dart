import 'package:flutter/material.dart';

class TableLayout extends StatelessWidget {
  final List<Widget> headerColumn;
  final List<List<Widget>> dataColumns;

  const TableLayout(
      {required this.headerColumn, required this.dataColumns, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: SingleChildScrollView(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [...headerColumn],
            ),
            Flexible(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    ...dataColumns.map(
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
