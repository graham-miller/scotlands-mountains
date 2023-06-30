import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_map/flutter_map.dart';

class MapboxTileLayer extends TileLayer {
  MapboxTileLayer({super.key, required styleId})
      : super(
            urlTemplate:
                'https://api.mapbox.com/styles/v1/mapbox/$styleId/tiles/512/{z}/{x}/{y}@2x?access_token=${dotenv.env['MAPBOX_PUBLIC_ACCESS_TOKEN']}');
}

/*
https://docs.mapbox.com/api/maps/styles/
https://docs.mapbox.com/api/maps/static-tiles/
*/