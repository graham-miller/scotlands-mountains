import 'package:flutter/material.dart';

import 'models/forecast_area.dart';

class SelectedArea extends StatelessWidget {
  final ForecastArea? selectedArea;
  final Function onTap;

  const SelectedArea(
      {required this.selectedArea, required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 16, 8, 8),
          child: TapRegion(
            onTapInside: (_) => onTap(),
            child: Container(
              decoration: BoxDecoration(
                  border: Border(
                bottom: BorderSide(
                    width: 0.25,
                    style: BorderStyle.solid,
                    color: Theme.of(context).colorScheme.onBackground),
              )),
              width: MediaQuery.of(context).size.width - 64,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 4, 0, 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Flexible(
                      child: Text(
                        selectedArea?.area ?? 'Select forecast area...',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize:
                              Theme.of(context).textTheme.titleMedium!.fontSize,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const Icon(Icons.arrow_drop_down)
                  ],
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
