import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sowaste/modules/map/directions_model.dart';

import '.env.dart';

class DirectionsRepository {
  static const String _baseUrl =
      "https://maps.googleapis.com/maps/api/directions/json?";
  static const String _searchUrl =
      "https://maps.googleapis.com/maps/api/geocode/json?";
  final Dio _dio;
  DirectionsRepository({Dio? dio}) : _dio = dio ?? Dio();

  Future<Directions> getDirections({
    required LatLng origin,
    required LatLng destination,
  }) async {
    final response = await _dio.get(_baseUrl, queryParameters: {
      'origin': '${origin.latitude},${origin.longitude}',
      'destination': '${destination.latitude},${destination.longitude}',
      'key': googleAPIKey,
    });
    if (response.statusCode == 200) {
      print(response.data);
      return Directions.fromMap(response.data);
    }
    return throw Exception('Error getting directions');
  }

  Future<LatLng> getLatLngFromAddress(String address) async {
    final response = await _dio.get(_searchUrl, queryParameters: {
      'address': address,
      'key': googleAPIKey,
    });
    if (response.statusCode == 200) {
      return LatLng(
        response.data['results'][0]['geometry']['location']['lat'],
        response.data['results'][0]['geometry']['location']['lng'],
      );
    }
    return throw Exception('Error getting directions');
  }
}
