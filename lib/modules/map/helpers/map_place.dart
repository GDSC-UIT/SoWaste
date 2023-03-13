import 'package:dio/dio.dart';
import 'package:latlong2/latlong.dart';
import 'package:sowaste/modules/map/map_model.dart';

import '../map_constants.dart';

class MapHelper {
  static const String _searchUrl =
      'https://maps.googleapis.com/maps/api/place/nearbysearch/json?';
  final Dio _dio;
  MapHelper({Dio? dio}) : _dio = dio ?? Dio();
  Future<List<MapMarker>> searchPlaces(
      String searchText, int radius, LatLng location) async {
    final response = await _dio.get(_searchUrl, queryParameters: {
      // "radius": radius,
      "location": "${location.latitude},${location.longitude}",
      "keyword": searchText,
      "key": GOOGLE_PLACE_API_KEY,
      "rankby": "distance"
    }).catchError((e) {
      return throw Exception('Error getting directions');
    });
    if (response.data['status'] != 'OK') {
      return Future.error(response.data['error_message']);
    }
    if (response.data['status'] == 'ZERO_RESULTS') {
      return Future.error('No results found');
    }
    return response.data['results']
        .map<MapMarker>((place) => MapMarker(
              title: place['name'] ?? '',
              vicinity: place['vicinity'] ?? '',
              location: LatLng(
                place['geometry']['location']['lat'] ?? 0.0,
                place['geometry']['location']['lng'] ?? 0.0,
              ),
              rating: double.parse(place['rating'].toString()),
              placeId: place['place_id'] ?? '',
              isOpenNow: place['opening_hours'] != null
                  ? place['opening_hours']['open_now']
                  : false,
            ))
        .toList();
  }

  static const String _directionsUrl =
      'https://api.mapbox.com/directions/v5/mapbox/driving/';
  Future<double> getDirections(LatLng origin, LatLng destination) async {
    final String finalUrl =
        '$_directionsUrl${origin.longitude},${origin.latitude};${destination.longitude},${destination.latitude}?&access_token=$MAPBOX_ACCESS_TOKEN';
    final response = await _dio.get(finalUrl).catchError((e) {
      return throw Exception('Error getting directions');
    });
    if (response.data['code'] != "Ok") {
      return Future.error(response.data['message']);
    }
    return response.data['routes'][0]['distance'] / 1000;
    // MapDirect(
    //   weightName: response.data['routes'][0]['weight_name'],
    //   weight: response.data['routes'][0]['weight'],
    //   duration: response.data['routes'][0]['duration'],
    //   distance: response.data['routes'][0]['distance'],
    // );
  }
}
