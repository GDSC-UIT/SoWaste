import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:geocoding/geocoding.dart' as geo;
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:sowaste/core/themes/app_colors.dart';
import 'package:sowaste/modules/map/helpers/map_place.dart';
import 'package:sowaste/modules/map/map_constants.dart';
import 'package:sowaste/modules/map/map_model.dart';
import 'package:sowaste/modules/map/map_repository.dart';
import 'package:url_launcher/url_launcher.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> with TickerProviderStateMixin {
  late List<LatLng> latlngList;
  List<MapMarker> mapMarkers = [];
  final mapHelper = MapHelper();
  final pageController = PageController();
  int selectedIndex = 0;
  late final MapController mapController;
  late LatLng currentLocation;
  late bool _serviceEnabled;
  LocationData? _userLocation;
  late PermissionStatus _permissionGranted;
  int radius = 5000;
  Future<void> _getUserLocation() async {
    Location location = Location();

    // Check if location service is enable
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    final _locationData = await location.getLocation();
    setState(() {
      _userLocation = _locationData;
      currentLocation =
          LatLng(_locationData.latitude!, _locationData.longitude!);
      geo
          .placemarkFromCoordinates(
              _locationData.latitude!, _locationData.longitude!)
          .catchError((e) {
        return null;
      });
    });
  }

  double distance = 0;
  Directions? destination;
  bool joined = false;

  @override
  void initState() {
    // TODO: implement initState
    _getUserLocation().then((value) async {
      mapController = MapController();
      await initMarkers();
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _userLocation != null
            ? Stack(
                children: [
                  Center(
                    child: FlutterMap(
                      mapController: mapController,
                      options: MapOptions(
                        center: currentLocation,
                        zoom: 12.0,
                      ),
                      children: [
                        TileLayer(
                          urlTemplate:
                              "https://api.mapbox.com/styles/v1/tuankietcoder/{mapStyleId}/tiles/256/{z}/{x}/{y}@2x?access_token={accessToken}",
                          additionalOptions: const {
                            'mapStyleId': MAPBOX_STYLE_ID,
                            'accessToken': MAPBOX_ACCESS_TOKEN,
                          },
                        ),
                        PolylineLayer(
                          polylines: [
                            Polyline(
                              points: destination != null
                                  ? destination!.polylinePoints
                                      .map((e) =>
                                          LatLng(e.latitude, e.longitude))
                                      .toList()
                                  : [],
                              strokeWidth: 4.0,
                              color: Colors.red,
                            ),
                          ],
                        ),
                        MarkerLayer(markers: [
                          Marker(
                            height: 40,
                            width: 40,
                            point: currentLocation,
                            builder: (_) {
                              return GestureDetector(
                                onTap: () {
                                  _animatedMapMove(currentLocation, 11.5);
                                },
                                child: const AnimatedScale(
                                  duration: Duration(milliseconds: 500),
                                  scale: 1,
                                  child: AnimatedOpacity(
                                    duration: Duration(milliseconds: 500),
                                    opacity: 1,
                                    child: Icon(
                                      Icons.my_location_sharp,
                                      color: Colors.red,
                                      size: 30,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                          for (int i = 0; i < mapMarkers.length; i++)
                            Marker(
                              height: 40,
                              width: 40,
                              point: mapMarkers[i].location ?? currentLocation,
                              builder: (_) {
                                return GestureDetector(
                                  onTap: () async {
                                    joined = true;
                                    selectedIndex == i
                                        ? _animatedMapMove(
                                            mapMarkers[selectedIndex]
                                                    .location ??
                                                currentLocation,
                                            11.5)
                                        : null;
                                    await mapHelper
                                        .getDirections(
                                            currentLocation,
                                            mapMarkers[i].location ??
                                                currentLocation)
                                        .then((value) {
                                      distance = value;
                                    });
                                    await getPolyline(mapMarkers[i].location ??
                                            currentLocation)
                                        .then((value) {
                                      setState(() {
                                        selectedIndex = i;
                                      });
                                      pageController.animateToPage(
                                        selectedIndex,
                                        duration:
                                            const Duration(milliseconds: 50),
                                        curve: Curves.easeInOut,
                                      );
                                    });
                                  },
                                  child: AnimatedScale(
                                    duration: const Duration(milliseconds: 500),
                                    scale: selectedIndex == i ? 1 : 0.7,
                                    child: AnimatedOpacity(
                                      duration:
                                          const Duration(milliseconds: 500),
                                      opacity: selectedIndex == i ? 1 : 0.5,
                                      child: const Icon(
                                        Icons.location_on,
                                        color: AppColors.primaryDark,
                                        size: 40,
                                        shadows: [
                                          BoxShadow(
                                            color: AppColors.primaryLight,
                                            blurRadius: 5,
                                            spreadRadius: 1,
                                            offset: Offset(0, 0),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                        ]),
                      ],
                    ),
                  ),
                  joined
                      ? Positioned(
                          left: 0,
                          right: 0,
                          bottom: 20,
                          height: MediaQuery.of(context).size.height * 0.35,
                          child: PageView.builder(
                            controller: pageController,
                            onPageChanged: (value) async {
                              selectedIndex = value;
                              _animatedMapMove(
                                  mapMarkers[value].location ?? currentLocation,
                                  11.5);
                              await mapHelper
                                  .getDirections(
                                      currentLocation,
                                      mapMarkers[value].location ??
                                          currentLocation)
                                  .then((value) {
                                distance = value;
                              });
                              await getPolyline(mapMarkers[value].location ??
                                  currentLocation);
                              setState(() {});
                            },
                            itemCount: mapMarkers.length ?? 0,
                            itemBuilder: (_, index) {
                              final item = mapMarkers[index];

                              // setState(() {});
                              return Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Container(
                                      padding: const EdgeInsets.all(16),
                                      decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.grey
                                                    .withOpacity(0.5),
                                                spreadRadius: 1,
                                                blurRadius: 5,
                                                offset: const Offset(0, 3))
                                          ],
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                  child: RatingBar.builder(
                                                initialRating: item.rating!
                                                    .ceil()
                                                    .toDouble(),
                                                minRating: 0,
                                                direction: Axis.horizontal,
                                                itemCount: 5,
                                                itemPadding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 4.0),
                                                itemBuilder: (context, _) =>
                                                    const Icon(
                                                  Icons.star,
                                                  color: Colors.yellow,
                                                ),
                                                unratedColor:
                                                    const Color.fromRGBO(
                                                        240, 240, 240, 1),
                                                ignoreGestures: true,
                                                onRatingUpdate:
                                                    (double value) {},
                                              )),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Flexible(
                                                child: SizedBox(
                                                  width: 240,
                                                  child: Text(item.title ?? '',
                                                      style: const TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      )),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Flexible(
                                                  child: SizedBox(
                                                      width: 200,
                                                      child: Text(
                                                        item.vicinity ?? '',
                                                        style: const TextStyle(
                                                          fontSize: 15,
                                                        ),
                                                      ))),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Flexible(
                                                  child: SizedBox(
                                                      width: 200,
                                                      child: Text(
                                                        item.isOpenNow!
                                                            ? 'Openning'
                                                            : 'Closed',
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontSize: 18,
                                                          color: item.isOpenNow!
                                                              ? AppColors
                                                                  .primaryDark
                                                              : Colors.red,
                                                        ),
                                                      ))),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    const Icon(
                                                      Icons.directions_outlined,
                                                      color:
                                                          AppColors.primaryDark,
                                                      size: 20,
                                                    ),
                                                    const SizedBox(
                                                      width: 10,
                                                    ),
                                                    Align(
                                                        alignment: Alignment
                                                            .bottomRight,
                                                        child: Text(
                                                            '${destination != null ? destination!.totalDistance : 0}')),
                                                  ]),
                                            ],
                                          ),
                                          TextButton(
                                            onPressed: () async {
                                              String url = MAP_PLACE +
                                                  (item.placeId ?? '');
                                              final uri = Uri.parse(url);
                                              await launchUrl(uri,
                                                      mode: LaunchMode
                                                          .externalApplication)
                                                  .catchError((e) => print(e));
                                            },
                                            style: TextButton.styleFrom(
                                              foregroundColor: Colors.white,
                                              backgroundColor:
                                                  AppColors.primaryDark,
                                              disabledForegroundColor:
                                                  Colors.grey,
                                              shape:
                                                  const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(5),
                                                ),
                                              ),
                                            ),
                                            child: const Text('Direct'),
                                          ),
                                        ],
                                      )));
                            },
                          ),
                        )
                      : const SizedBox(),
                ],
              )
            : const Center(
                child: CircularProgressIndicator(),
              ));
  }

  void _animatedMapMove(LatLng destLocation, double destZoom) {
    // Create some tweens. These serve to split up the transition from one location to another.
    // In our case, we want to split the transition be<tween> our current map center and the destination.
    final latTween = Tween<double>(
        begin: mapController.center.latitude, end: destLocation.latitude);
    final lngTween = Tween<double>(
        begin: mapController.center.longitude, end: destLocation.longitude);
    final zoomTween = Tween<double>(begin: mapController.zoom, end: destZoom);

    // Create a animation controller that has a duration and a TickerProvider.
    var controller = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    // The animation determines what path the animation will take. You can try different Curves values, although I found
    // fastOutSlowIn to be my favorite.
    Animation<double> animation =
        CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn);

    controller.addListener(() {
      mapController.move(
        LatLng(latTween.evaluate(animation), lngTween.evaluate(animation)),
        zoomTween.evaluate(animation),
      );
    });

    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.dispose();
      } else if (status == AnimationStatus.dismissed) {
        controller.dispose();
      }
    });

    controller.forward();
  }

  Future<void> getPolyline(LatLng des) async {
    await DirectionsRepository()
        .getDirections(origin: currentLocation, destination: des)
        .then((value) => {destination = value});
  }

  Future<void> onRadiusChanged(int value) async {
    selectedIndex = 0;
    destination = null;
    radius = value;
    await initMarkers();
    await mapHelper
        .getDirections(currentLocation,
            mapMarkers[selectedIndex].location ?? currentLocation)
        .then((value) => {distance = value})
        .catchError((e) {});
    setState(() {});
  }

  Future<String> initMarkers() async {
    try {
      final List<MapMarker> places = await mapHelper.searchPlaces(
          'recycling center', radius, currentLocation);
      mapMarkers = places;
      return Future.value('success');
    } catch (error) {
      setState(() {
        mapMarkers = [];
      });
      return error.toString();
    }
  }
}
