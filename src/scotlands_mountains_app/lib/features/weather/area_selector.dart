import 'package:flutter/material.dart';

import 'models/forecast_area.dart';

class AreaSelector extends StatefulWidget {
  final List<ForecastArea> forecastAreas;
  final ForecastArea? selectedArea;
  final Function onSelected;

  const AreaSelector(
      {required this.forecastAreas,
      required this.selectedArea,
      required this.onSelected,
      super.key});

  @override
  State<AreaSelector> createState() => _AreaSelectorState();
}

class _AreaSelectorState extends State<AreaSelector> {
  final _description = {
    'Southwest Highlands':
        'Including Ben Nevis, Glen Coe and the rest of Lochaber, Argyll including the Isles, Loch Lomond, Trossachs and Arran.',
    'South Grampian and Southeast Highlands':
        'Including South Cairngorms, east Aberdeenshire and Angus Hills, Ben Vrackie, Ben Lawers, Loch Tay and Ochils.',
    'North Grampian':
        'Including North and Central Cairngorms, Monadhliath, Ben Alder, Creag Meagaidh, Loch Ericht and Loch Rannoch.',
    'Northwest Highlands':
        'Including Sutherland, Ben Wyvis, Wester Ross, The Cuillin, Glen Affric, Glen Shiel and Knoydart.',
  };
  final top = AppBar().preferredSize.height;
  OverlayEntry? _overlayEntry;

  void _openDropdown(BuildContext context) {
    _closeDropdown();

    _overlayEntry = OverlayEntry(builder: (BuildContext _) {
      return SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(32, top, 32, 32),
          child: Material(
            elevation: 8,
            child: TapRegion(
              onTapOutside: (_) => _closeDropdown(),
              child: Container(
                color: Theme.of(context).colorScheme.background,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ...widget.forecastAreas.map(
                      (a) {
                        return ListTile(
                          title: Text(a.area),
                          subtitle: Text(_description[a.area]!),
                          onTap: () {
                            _closeDropdown();
                            widget.onSelected(a);
                          },
                        );
                      },
                    ).toList()
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });

    Overlay.of(context, debugRequiredFor: widget).insert(_overlayEntry!);
  }

  void _closeDropdown() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  void dispose() {
    // Make sure to remove OverlayEntry when the widget is disposed.
    _closeDropdown();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 16, 8, 8),
          child: TapRegion(
            onTapInside: (_) => _openDropdown(context),
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
                        widget.selectedArea?.area ?? ' ',
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
