// import 'package:latlong2/latlong.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:latlong2/latlong.dart';

class MapMarker {
  final String? title;
  final String? vicinity;
  final LatLng location;
  final double? rating;
  final String? placeId;
  final bool? isOpenNow;
  MapMarker({
    required this.title,
    required this.vicinity,
    required this.location,
    required this.rating,
    required this.placeId,
    required this.isOpenNow,
  });
}

class MapDirect {
  final String? weightName;
  final double? weight;
  final double? duration;
  final double? distance;
  MapDirect({
    required this.weightName,
    required this.weight,
    required this.duration,
    required this.distance,
  });
}

class Directions {
  final List<PointLatLng> polylinePoints;
  final String totalDistance;
  final String totalDuration;

  const Directions({
    required this.polylinePoints,
    required this.totalDistance,
    required this.totalDuration,
  });

  factory Directions.fromMap(Map<String, dynamic> map) {
    if ((map['routes'] as List).isEmpty) return throw Exception('No routes');

    final data = Map<String, dynamic>.from(map['routes'][0]);

    String distance = '';
    String duration = '';

    if ((data['legs'] as List).isNotEmpty) {
      distance = data['legs'][0]['distance']['text'];
      duration = data['legs'][0]['duration']['text'];
    }

    print('distance: $distance');

    return Directions(
        polylinePoints: PolylinePoints()
            .decodePolyline(data['overview_polyline']['points']),
        totalDistance: distance,
        totalDuration: duration);
  }
}
