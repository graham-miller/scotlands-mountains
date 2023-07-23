import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class ForecastAreaMetadata {
  final int index;
  final String description;
  final LatLng center;
  final Polygon polygon;

  ForecastAreaMetadata(
      {required this.index,
      required this.description,
      required this.center,
      required this.polygon});
}

class AreaMapConstants {
  static Map<String, ForecastAreaMetadata> metadata = {
    'Northwest Highlands': ForecastAreaMetadata(
      index: 0,
      description:
          'Including Sutherland, Ben Wyvis, Wester Ross, The Cuillin, Glen Affric, Glen Shiel and Knoydart.',
      center: LatLng(57.6779, -5.2214),
      polygon: _polygon(_northwestHighlandsPoints),
    ),
    'North Grampian': ForecastAreaMetadata(
      index: 1,
      description:
          'Including North and Central Cairngorms, Monadhliath, Ben Alder, Creag Meagaidh, Loch Ericht and Loch Rannoch.',
      center: LatLng(57.1225, -4.0237),
      polygon: _polygon(_northGrampianPoints),
    ),
    'South Grampian and Southeast Highlands': ForecastAreaMetadata(
      index: 2,
      description:
          'Including South Cairngorms, east Aberdeenshire and Angus Hills, Ben Vrackie, Ben Lawers, Loch Tay and Ochils.',
      center: LatLng(56.6975, -3.3733),
      polygon: _polygon(_southGrampianAndSoutheastHiglands),
    ),
    'Southwest Highlands': ForecastAreaMetadata(
      index: 3,
      description:
          'Including Ben Nevis, Glen Coe and the rest of Lochaber, Argyll including the Isles, Loch Lomond, Trossachs and Arran.',
      center: LatLng(56.2051, -5.4379),
      polygon: _polygon(_southwestHighlands),
    )
  };

  static Polygon _polygon(List<List<double>> points) {
    return Polygon(
      points: points.map((i) => LatLng(i[1], i[0])).toList(),
      borderColor: Colors.red,
      borderStrokeWidth: 2,
      color: const Color.fromRGBO(0, 0, 0, 0.2),
      isFilled: true,
    );
  }

  static const _northGrampianPoints = [
    [-3.129, 57.441],
    [-3.119, 57.439],
    [-3.117, 57.438],
    [-3.111, 57.433],
    [-3.109, 57.428],
    [-3.106, 57.424],
    [-3.104, 57.411],
    [-3.1, 57.406],
    [-3.08, 57.387],
    [-3.085, 57.382],
    [-3.088, 57.375],
    [-3.088, 57.369],
    [-3.131, 57.32],
    [-3.112, 57.296],
    [-3.117, 57.275],
    [-3.148, 57.266],
    [-3.157, 57.25],
    [-3.147, 57.227],
    [-3.164, 57.216],
    [-3.225, 57.196],
    [-3.233, 57.176],
    [-3.225, 57.152],
    [-3.24, 57.123],
    [-3.498, 57.047],
    [-3.601, 57.001],
    [-3.688, 56.929],
    [-3.824, 56.913],
    [-4.008, 56.857],
    [-4.019, 56.846],
    [-4.024, 56.835],
    [-4.029, 56.828],
    [-4.037, 56.82],
    [-4.046, 56.816],
    [-4.051, 56.812],
    [-4.06, 56.809],
    [-4.072, 56.8],
    [-4.078, 56.793],
    [-4.073, 56.727],
    [-4.085, 56.713],
    [-4.107, 56.687],
    [-4.123, 56.675],
    [-4.14, 56.661],
    [-4.173, 56.658],
    [-4.209, 56.656],
    [-4.25, 56.653],
    [-4.326, 56.647],
    [-4.409, 56.649],
    [-4.466, 56.65],
    [-4.469, 56.65],
    [-4.489, 56.659],
    [-4.555, 56.684],
    [-4.572, 56.688],
    [-4.565, 56.692],
    [-4.574, 56.704],
    [-4.621, 56.725],
    [-4.637, 56.732],
    [-4.648, 56.732],
    [-4.653, 56.736],
    [-4.66, 56.739],
    [-4.67, 56.748],
    [-4.688, 56.759],
    [-4.695, 56.772],
    [-4.715, 56.78],
    [-4.725, 56.782],
    [-4.722, 56.789],
    [-4.714, 56.803],
    [-4.706, 56.816],
    [-4.704, 56.835],
    [-4.703, 56.847],
    [-4.701, 56.858],
    [-4.691, 56.873],
    [-4.688, 56.879],
    [-4.687, 56.88],
    [-4.684, 56.885],
    [-4.702, 56.884],
    [-4.759, 56.884],
    [-4.788, 56.883],
    [-4.816, 56.881],
    [-4.861, 56.878],
    [-4.889, 56.876],
    [-4.893, 56.877],
    [-4.899, 56.879],
    [-4.926, 56.886],
    [-4.951, 56.897],
    [-4.967, 56.907],
    [-4.976, 56.92],
    [-4.972, 56.931],
    [-4.97, 56.935],
    [-4.966, 56.941],
    [-4.892, 56.981],
    [-4.805, 57.044],
    [-4.547, 57.229],
    [-4.36, 57.377],
    [-4.347, 57.398],
    [-4.335, 57.409],
    [-4.304, 57.418],
    [-4.271, 57.426],
    [-4.222, 57.436],
    [-4.151, 57.446],
    [-4.143, 57.454],
    [-4.106, 57.461],
    [-4.063, 57.477],
    [-4.026, 57.49],
    [-3.99, 57.498],
    [-3.985, 57.5],
    [-3.975, 57.5],
    [-3.952, 57.505],
    [-3.938, 57.502],
    [-3.916, 57.503],
    [-3.896, 57.497],
    [-3.88, 57.497],
    [-3.853, 57.49],
    [-3.839, 57.489],
    [-3.831, 57.485],
    [-3.823, 57.486],
    [-3.788, 57.488],
    [-3.726, 57.492],
    [-3.658, 57.502],
    [-3.618, 57.504],
    [-3.594, 57.505],
    [-3.565, 57.505],
    [-3.525, 57.505],
    [-3.489, 57.501],
    [-3.463, 57.498],
    [-3.431, 57.49],
    [-3.41, 57.486],
    [-3.379, 57.483],
    [-3.36, 57.477],
    [-3.342, 57.475],
    [-3.321, 57.472],
    [-3.301, 57.466],
    [-3.289, 57.463],
    [-3.27, 57.457],
    [-3.256, 57.455],
    [-3.237, 57.456],
    [-3.192, 57.454],
    [-3.179, 57.454],
    [-3.173, 57.453],
    [-3.152, 57.45],
    [-3.142, 57.449],
    [-3.134, 57.444],
    [-3.129, 57.441]
  ];

  static const _northwestHighlandsPoints = [
    [-4.222, 57.436],
    [-4.271, 57.426],
    [-4.304, 57.418],
    [-4.335, 57.409],
    [-4.347, 57.398],
    [-4.36, 57.377],
    [-4.547, 57.229],
    [-4.805, 57.044],
    [-4.892, 56.981],
    [-4.966, 56.941],
    [-4.98, 56.945],
    [-5.003, 56.95],
    [-5.005, 56.95],
    [-5.019, 56.953],
    [-5.028, 56.954],
    [-5.036, 56.952],
    [-5.043, 56.953],
    [-5.056, 56.959],
    [-5.07, 56.965],
    [-5.097, 56.969],
    [-5.125, 56.971],
    [-5.155, 56.972],
    [-5.203, 56.977],
    [-5.228, 56.978],
    [-5.283, 56.975],
    [-5.299, 56.97],
    [-5.321, 56.968],
    [-5.36, 56.96],
    [-5.41, 56.955],
    [-5.438, 56.954],
    [-5.52, 56.954],
    [-5.571, 56.953],
    [-5.622, 56.951],
    [-5.656, 56.951],
    [-5.676, 56.952],
    [-5.712, 56.954],
    [-5.759, 56.957],
    [-5.767, 56.956],
    [-5.777, 56.956],
    [-5.789, 56.958],
    [-5.793, 56.96],
    [-5.802, 56.968],
    [-5.818, 56.976],
    [-5.825, 56.98],
    [-5.832, 56.983],
    [-5.838, 56.984],
    [-5.857, 56.992],
    [-5.941, 57.014],
    [-5.989, 57.027],
    [-6.004, 57.038],
    [-6.046, 57.082],
    [-6.061, 57.097],
    [-6.077, 57.101],
    [-6.219, 57.13],
    [-6.404, 57.173],
    [-6.612, 57.293],
    [-6.69, 57.337],
    [-6.764, 57.356],
    [-6.804, 57.391],
    [-6.818, 57.425],
    [-6.808, 57.45],
    [-6.797, 57.479],
    [-6.738, 57.525],
    [-6.636, 57.607],
    [-6.358, 57.698],
    [-6.297, 57.698],
    [-6.282, 57.687],
    [-6.253, 57.674],
    [-6.21, 57.646],
    [-5.977, 57.5],
    [-5.9, 57.45],
    [-5.887, 57.442],
    [-5.869, 57.446],
    [-5.862, 57.454],
    [-5.845, 57.469],
    [-5.763, 57.6],
    [-5.709, 57.685],
    [-5.706, 57.691],
    [-5.71, 57.696],
    [-5.732, 57.706],
    [-5.793, 57.734],
    [-5.804, 57.735],
    [-5.814, 57.739],
    [-5.818, 57.744],
    [-5.818, 57.747],
    [-5.813, 57.851],
    [-5.81, 57.854],
    [-5.806, 57.855],
    [-5.736, 57.882],
    [-5.641, 57.918],
    [-5.615, 57.928],
    [-5.611, 57.929],
    [-5.606, 57.928],
    [-5.603, 57.926],
    [-5.588, 57.915],
    [-5.566, 57.897],
    [-5.549, 57.881],
    [-5.54, 57.875],
    [-5.532, 57.876],
    [-5.525, 57.878],
    [-5.274, 57.959],
    [-5.269, 57.961],
    [-5.268, 57.964],
    [-5.271, 57.966],
    [-5.292, 57.977],
    [-5.327, 57.997],
    [-5.379, 58.025],
    [-5.422, 58.049],
    [-5.441, 58.06],
    [-5.446, 58.062],
    [-5.452, 58.064],
    [-5.454, 58.066],
    [-5.454, 58.067],
    [-5.453, 58.068],
    [-5.45, 58.069],
    [-5.342, 58.113],
    [-5.338, 58.114],
    [-5.336, 58.118],
    [-5.336, 58.122],
    [-5.328, 58.277],
    [-5.328, 58.281],
    [-5.322, 58.284],
    [-5.31, 58.284],
    [-5.264, 58.286],
    [-5.136, 58.29],
    [-5.124, 58.289],
    [-5.116, 58.29],
    [-5.113, 58.293],
    [-5.111, 58.301],
    [-5.027, 58.593],
    [-5.025, 58.606],
    [-5.023, 58.614],
    [-5.022, 58.622],
    [-5.021, 58.627],
    [-5.019, 58.636],
    [-5.018, 58.641],
    [-5.016, 58.645],
    [-5.011, 58.647],
    [-5.005, 58.647],
    [-4.997, 58.646],
    [-4.991, 58.645],
    [-4.98, 58.644],
    [-4.967, 58.642],
    [-4.25, 58.533],
    [-4.233, 58.53],
    [-4.229, 58.53],
    [-4.225, 58.528],
    [-4.22, 58.525],
    [-4.214, 58.517],
    [-4.138, 58.425],
    [-4.103, 58.382],
    [-4.069, 58.34],
    [-4.015, 58.274],
    [-4.006, 58.263],
    [-4.003, 58.259],
    [-4.006, 58.258],
    [-4.01, 58.256],
    [-4.017, 58.254],
    [-4.195, 58.183],
    [-4.229, 58.17],
    [-4.234, 58.167],
    [-4.247, 58.167],
    [-4.365, 58.161],
    [-4.381, 58.16],
    [-4.393, 58.158],
    [-4.465, 58.131],
    [-4.508, 58.115],
    [-4.518, 58.111],
    [-4.522, 58.105],
    [-4.52, 58.101],
    [-4.512, 58.089],
    [-4.496, 58.064],
    [-4.467, 58.02],
    [-4.45, 58.008],
    [-4.427, 57.997],
    [-4.337, 57.954],
    [-4.31, 57.941],
    [-4.323, 57.928],
    [-4.347, 57.872],
    [-4.396, 57.742],
    [-4.482, 57.515],
    [-4.491, 57.489],
    [-4.461, 57.477],
    [-4.372, 57.471],
    [-4.335, 57.455],
    [-4.299, 57.444],
    [-4.222, 57.436]
  ];

  static const _southGrampianAndSoutheastHiglands = [
    [-4.195, 56.252],
    [-4.219, 56.252],
    [-4.241, 56.259],
    [-4.265, 56.267],
    [-4.273, 56.277],
    [-4.277, 56.292],
    [-4.286, 56.298],
    [-4.302, 56.303],
    [-4.313, 56.307],
    [-4.321, 56.317],
    [-4.318, 56.336],
    [-4.319, 56.35],
    [-4.306, 56.36],
    [-4.296, 56.364],
    [-4.283, 56.374],
    [-4.279, 56.383],
    [-4.287, 56.396],
    [-4.298, 56.408],
    [-4.308, 56.413],
    [-4.321, 56.417],
    [-4.332, 56.426],
    [-4.336, 56.436],
    [-4.337, 56.445],
    [-4.331, 56.458],
    [-4.326, 56.466],
    [-4.336, 56.471],
    [-4.428, 56.517],
    [-4.458, 56.523],
    [-4.487, 56.533],
    [-4.496, 56.537],
    [-4.503, 56.541],
    [-4.503, 56.566],
    [-4.502, 56.592],
    [-4.499, 56.629],
    [-4.466, 56.65],
    [-4.409, 56.649],
    [-4.326, 56.647],
    [-4.25, 56.653],
    [-4.209, 56.656],
    [-4.173, 56.658],
    [-4.14, 56.661],
    [-4.123, 56.675],
    [-4.107, 56.687],
    [-4.085, 56.713],
    [-4.073, 56.727],
    [-4.078, 56.793],
    [-4.072, 56.8],
    [-4.06, 56.809],
    [-4.051, 56.812],
    [-4.046, 56.816],
    [-4.037, 56.82],
    [-4.029, 56.828],
    [-4.024, 56.835],
    [-4.019, 56.846],
    [-4.008, 56.857],
    [-3.824, 56.913],
    [-3.688, 56.929],
    [-3.601, 57.001],
    [-3.498, 57.047],
    [-3.24, 57.123],
    [-3.225, 57.152],
    [-3.233, 57.176],
    [-3.225, 57.196],
    [-3.164, 57.216],
    [-3.147, 57.227],
    [-3.157, 57.25],
    [-3.148, 57.266],
    [-3.117, 57.275],
    [-3.112, 57.296],
    [-3.131, 57.32],
    [-3.088, 57.369],
    [-3.088, 57.375],
    [-3.085, 57.382],
    [-3.08, 57.387],
    [-3.1, 57.406],
    [-3.104, 57.411],
    [-3.106, 57.424],
    [-3.109, 57.428],
    [-3.111, 57.433],
    [-3.117, 57.438],
    [-3.119, 57.439],
    [-3.129, 57.441],
    [-3.051, 57.453],
    [-2.986, 57.459],
    [-2.901, 57.462],
    [-2.844, 57.464],
    [-2.798, 57.461],
    [-2.75, 57.454],
    [-2.685, 57.444],
    [-2.64, 57.437],
    [-2.606, 57.431],
    [-2.588, 57.423],
    [-2.583, 57.411],
    [-2.57, 57.382],
    [-2.54, 57.313],
    [-2.512, 57.248],
    [-2.505, 57.176],
    [-2.513, 57.17],
    [-2.587, 57.116],
    [-2.637, 57.08],
    [-2.654, 57.067],
    [-2.665, 57.059],
    [-2.67, 57.056],
    [-2.672, 57.048],
    [-2.661, 57.04],
    [-2.571, 56.976],
    [-2.549, 56.96],
    [-2.539, 56.953],
    [-2.54, 56.942],
    [-2.554, 56.932],
    [-2.606, 56.893],
    [-2.619, 56.758],
    [-2.853, 56.644],
    [-2.884, 56.449],
    [-2.886, 56.377],
    [-2.883, 56.363],
    [-2.871, 56.352],
    [-2.878, 56.338],
    [-2.866, 56.312],
    [-2.851, 56.284],
    [-2.849, 56.274],
    [-2.849, 56.255],
    [-2.857, 56.237],
    [-2.883, 56.227],
    [-2.929, 56.223],
    [-3.037, 56.203],
    [-3.114, 56.164],
    [-3.283, 56.116],
    [-3.424, 56.089],
    [-3.543, 56.096],
    [-3.714, 56.109],
    [-3.815, 56.139],
    [-3.937, 56.148],
    [-3.977, 56.163],
    [-4.052, 56.185],
    [-4.116, 56.213],
    [-4.168, 56.229],
    [-4.177, 56.246],
    [-4.195, 56.252]
  ];

  static const _southwestHighlands = [
    [-5.056, 56.959],
    [-5.048, 56.956],
    [-5.043, 56.953],
    [-5.036, 56.952],
    [-5.028, 56.954],
    [-5.019, 56.953],
    [-5.006, 56.951],
    [-5.005, 56.95],
    [-5.003, 56.95],
    [-4.98, 56.945],
    [-4.966, 56.941],
    [-4.97, 56.935],
    [-4.972, 56.931],
    [-4.976, 56.92],
    [-4.967, 56.907],
    [-4.951, 56.897],
    [-4.926, 56.886],
    [-4.899, 56.879],
    [-4.893, 56.877],
    [-4.889, 56.876],
    [-4.861, 56.878],
    [-4.816, 56.881],
    [-4.759, 56.884],
    [-4.702, 56.884],
    [-4.684, 56.885],
    [-4.687, 56.88],
    [-4.688, 56.879],
    [-4.691, 56.873],
    [-4.701, 56.858],
    [-4.703, 56.847],
    [-4.704, 56.835],
    [-4.706, 56.816],
    [-4.714, 56.803],
    [-4.722, 56.789],
    [-4.725, 56.782],
    [-4.715, 56.78],
    [-4.695, 56.772],
    [-4.688, 56.759],
    [-4.67, 56.748],
    [-4.66, 56.739],
    [-4.653, 56.736],
    [-4.648, 56.732],
    [-4.637, 56.732],
    [-4.621, 56.725],
    [-4.574, 56.704],
    [-4.565, 56.692],
    [-4.572, 56.688],
    [-4.555, 56.684],
    [-4.489, 56.659],
    [-4.469, 56.65],
    [-4.466, 56.65],
    [-4.499, 56.629],
    [-4.502, 56.592],
    [-4.503, 56.566],
    [-4.503, 56.541],
    [-4.496, 56.537],
    [-4.487, 56.533],
    [-4.458, 56.523],
    [-4.428, 56.517],
    [-4.336, 56.471],
    [-4.326, 56.466],
    [-4.331, 56.458],
    [-4.337, 56.445],
    [-4.336, 56.436],
    [-4.332, 56.426],
    [-4.321, 56.417],
    [-4.308, 56.413],
    [-4.298, 56.408],
    [-4.287, 56.396],
    [-4.279, 56.383],
    [-4.283, 56.374],
    [-4.296, 56.364],
    [-4.306, 56.36],
    [-4.319, 56.35],
    [-4.318, 56.336],
    [-4.321, 56.317],
    [-4.313, 56.307],
    [-4.302, 56.303],
    [-4.286, 56.298],
    [-4.277, 56.292],
    [-4.273, 56.277],
    [-4.265, 56.267],
    [-4.241, 56.259],
    [-4.219, 56.252],
    [-4.195, 56.252],
    [-4.223, 56.211],
    [-4.25, 56.17],
    [-4.254, 56.167],
    [-4.278, 56.15],
    [-4.283, 56.145],
    [-4.297, 56.125],
    [-4.309, 56.116],
    [-4.353, 56.099],
    [-4.383, 56.082],
    [-4.404, 56.058],
    [-4.422, 56.045],
    [-4.445, 56.037],
    [-4.469, 56.022],
    [-4.48, 56.013],
    [-4.551, 55.99],
    [-4.58, 55.98],
    [-4.621, 55.968],
    [-4.665, 55.966],
    [-4.716, 55.963],
    [-4.775, 55.96],
    [-4.802, 55.958],
    [-4.811, 55.957],
    [-4.828, 55.957],
    [-4.846, 55.952],
    [-4.856, 55.944],
    [-4.877, 55.892],
    [-4.882, 55.868],
    [-4.88, 55.819],
    [-4.843, 55.777],
    [-4.845, 55.758],
    [-4.845, 55.751],
    [-4.847, 55.741],
    [-4.854, 55.726],
    [-4.866, 55.698],
    [-4.882, 55.679],
    [-4.927, 55.627],
    [-5.092, 55.437],
    [-5.117, 55.425],
    [-5.165, 55.411],
    [-5.636, 55.276],
    [-5.666, 55.271],
    [-5.723, 55.271],
    [-5.745, 55.271],
    [-5.791, 55.275],
    [-5.807, 55.277],
    [-5.83, 55.287],
    [-5.851, 55.308],
    [-5.856, 55.325],
    [-5.855, 55.37],
    [-5.851, 55.395],
    [-5.845, 55.42],
    [-5.798, 55.589],
    [-5.801, 55.614],
    [-5.816, 55.626],
    [-5.843, 55.626],
    [-5.899, 55.617],
    [-6.11, 55.579],
    [-6.283, 55.553],
    [-6.352, 55.551],
    [-6.396, 55.554],
    [-6.429, 55.563],
    [-6.461, 55.572],
    [-6.484, 55.586],
    [-6.526, 55.632],
    [-6.547, 55.658],
    [-6.562, 55.681],
    [-6.574, 55.707],
    [-6.579, 55.723],
    [-6.575, 55.746],
    [-6.55, 55.782],
    [-6.524, 55.821],
    [-6.483, 55.867],
    [-6.463, 55.882],
    [-6.421, 55.901],
    [-6.352, 55.924],
    [-6.206, 55.971],
    [-6.098, 56.01],
    [-5.99, 56.052],
    [-5.919, 56.084],
    [-5.877, 56.105],
    [-5.858, 56.12],
    [-5.86, 56.128],
    [-5.861, 56.133],
    [-5.873, 56.139],
    [-5.892, 56.145],
    [-5.99, 56.168],
    [-6.225, 56.23],
    [-6.326, 56.254],
    [-6.397, 56.27],
    [-6.441, 56.28],
    [-6.48, 56.291],
    [-6.487, 56.294],
    [-6.494, 56.305],
    [-6.496, 56.312],
    [-6.489, 56.332],
    [-6.467, 56.377],
    [-6.453, 56.41],
    [-6.425, 56.478],
    [-6.383, 56.585],
    [-6.374, 56.609],
    [-6.357, 56.626],
    [-6.308, 56.665],
    [-6.23, 56.736],
    [-6.192, 56.759],
    [-6.171, 56.773],
    [-6.144, 56.776],
    [-6.118, 56.777],
    [-6.091, 56.778],
    [-6.048, 56.782],
    [-6.023, 56.787],
    [-5.982, 56.8],
    [-5.975, 56.805],
    [-5.964, 56.819],
    [-5.96, 56.851],
    [-5.951, 56.886],
    [-5.93, 56.915],
    [-5.909, 56.93],
    [-5.871, 56.954],
    [-5.848, 56.978],
    [-5.844, 56.981],
    [-5.838, 56.984],
    [-5.832, 56.983],
    [-5.825, 56.98],
    [-5.818, 56.976],
    [-5.802, 56.968],
    [-5.793, 56.96],
    [-5.789, 56.958],
    [-5.777, 56.956],
    [-5.767, 56.956],
    [-5.759, 56.957],
    [-5.712, 56.954],
    [-5.676, 56.952],
    [-5.656, 56.951],
    [-5.622, 56.951],
    [-5.571, 56.953],
    [-5.52, 56.954],
    [-5.438, 56.954],
    [-5.41, 56.955],
    [-5.36, 56.96],
    [-5.321, 56.968],
    [-5.299, 56.97],
    [-5.283, 56.975],
    [-5.228, 56.978],
    [-5.203, 56.977],
    [-5.155, 56.972],
    [-5.125, 56.971],
    [-5.097, 56.969],
    [-5.07, 56.965],
    [-5.056, 56.959]
  ];
}
