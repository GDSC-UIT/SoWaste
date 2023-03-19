import 'package:dio/dio.dart';
import 'package:latlong2/latlong.dart';
import 'package:sowaste/modules/map/map_constants.dart';
import 'package:sowaste/modules/map/map_model.dart';

class DirectionsRepository {
  static const String _baseUrl =
      "https://maps.googleapis.com/maps/api/directions/json?";
  final Dio _dio;
  DirectionsRepository({Dio? dio}) : _dio = dio ?? Dio();

  Future<Directions> getDirections({
    required LatLng origin,
    required LatLng destination,
  }) async {
    final response = await _dio.get(_baseUrl, queryParameters: {
      'origin': '${origin.latitude},${origin.longitude}',
      'destination': '${destination.latitude},${destination.longitude}',
      'key': GOOGLE_DIRECTION_API_KEY,
    });
    if (response.statusCode == 200) {
      return Directions.fromMap(response.data);
    }
    return throw Exception('Error getting directions');
  }
}
