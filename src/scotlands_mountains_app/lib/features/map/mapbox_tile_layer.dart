import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_map/flutter_map.dart';

enum Layer { streets, satelliteStreets, satellite, outdoors }

class MapboxTileLayer extends TileLayer {
  static final Map<Layer, TileLayer> layers = {
    Layer.streets: MapboxTileLayer(styleId: 'streets-v12'),
    Layer.satelliteStreets: MapboxTileLayer(styleId: 'satellite-streets-v12'),
    Layer.satellite: MapboxTileLayer(styleId: 'satellite-v9'),
    Layer.outdoors: MapboxTileLayer(styleId: 'outdoors-v12'),
  };

  MapboxTileLayer({super.key, required styleId})
      : super(
            urlTemplate:
                //'https://api.mapbox.com/styles/v1/mapbox/$styleId/tiles/512/{z}/{x}/{y}@2x?access_token=${dotenv.env['MAPBOX_PUBLIC_ACCESS_TOKEN']}');
                'https://api.mapbox.com/styles/v1/mapbox/$styleId/tiles/256/{z}/{x}/{y}?access_token=${dotenv.env['MAPBOX_PUBLIC_ACCESS_TOKEN']}');
}

/*
https://docs.mapbox.com/api/maps/styles/
https://docs.mapbox.com/api/maps/static-tiles/
*/