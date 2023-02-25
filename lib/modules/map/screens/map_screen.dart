import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:sowaste/core/themes/app_colors.dart';
import 'package:sowaste/modules/map/directions_model.dart';
import 'package:sowaste/modules/map/directions_repository.dart';
import 'package:sowaste/modules/map/widgets/around_widget.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController _googleMapController;
  Marker? _origin;
  Marker? _destination;
  Directions? _info;
  MapType? _mapType;
  static const _initialCameraPosition = CameraPosition(
    target: LatLng(10.82302, 106.62965),
    zoom: 11,
  );

  @override
  void dispose() {
    _googleMapController.dispose();
    super.dispose();
  }

  Future<LatLng> findDirectionsByAddress(String destinationAddress) async {
    final directions =
        await DirectionsRepository().getLatLngFromAddress(destinationAddress);
    return directions;
  }

  late bool _serviceEnabled;
  LocationData? _userLocation;
  late PermissionStatus _permissionGranted;
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
    });
  }

  void _onMapCreated(GoogleMapController controller) async {
    _googleMapController = controller;
    await _getUserLocation().then((value) {
      _googleMapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(
              _userLocation?.latitude ?? 0,
              _userLocation?.longitude ?? 0,
            ),
            zoom: 11,
          ),
        ),
      );
      _addMarker(LatLng(
        _userLocation?.latitude ?? 0,
        _userLocation?.longitude ?? 0,
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        // leading: const Icon(
        //   Icons.arrow_back_ios,
        //   color: AppColors.secondary,
        // ),
        title: const Text('Scrap Locations'),
        backgroundColor: Colors.white,
        titleTextStyle: const TextStyle(
          color: AppColors.primary,
          fontSize: 18.0,
          fontWeight: FontWeight.w600,
        ),
        actions: [
          if (_origin != null)
            TextButton(
              onPressed: () => _googleMapController.animateCamera(
                CameraUpdate.newCameraPosition(
                  CameraPosition(
                    target: _origin!.position,
                    zoom: 18,
                    tilt: 50.0,
                  ),
                ),
              ),
              style: TextButton.styleFrom(
                foregroundColor: AppColors.error,
                textStyle: const TextStyle(fontWeight: FontWeight.w600),
              ),
              child: const Text('ORIGIN'),
            ),
          if (_destination != null)
            TextButton(
              onPressed: () => _googleMapController.animateCamera(
                CameraUpdate.newCameraPosition(
                  CameraPosition(
                    target: _destination!.position,
                    zoom: 18,
                    tilt: 50.0,
                  ),
                ),
              ),
              style: TextButton.styleFrom(
                foregroundColor: AppColors.primary,
                textStyle: const TextStyle(fontWeight: FontWeight.w600),
              ),
              child: const Text('DEST'),
            ),
        ],
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          GoogleMap(
            zoomGesturesEnabled: true,
            buildingsEnabled: true,
            mapType: _mapType ?? MapType.hybrid,
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
            initialCameraPosition: _initialCameraPosition,
            onMapCreated: (controller) => _onMapCreated(controller),
            markers: {
              if (_origin != null) _origin as Marker,
              if (_destination != null) _destination as Marker,
            },
            polylines: {
              if (_info != null)
                Polyline(
                  polylineId: const PolylineId('overview_polyline'),
                  color: AppColors.primaryLight,
                  width: 8,
                  points: _info!.polylinePoints
                      .map((e) => LatLng(e.latitude, e.longitude))
                      .toList(),
                ),
            },
            onTap: _addMarker,
          ),
          if (_info != null)
            Positioned(
              bottom: 30.0,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 6.0,
                  horizontal: 12.0,
                ),
                decoration: BoxDecoration(
                  color: Colors.yellowAccent,
                  borderRadius: BorderRadius.circular(20.0),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      offset: Offset(0, 2),
                      blurRadius: 6.0,
                    )
                  ],
                ),
                child: Text(
                  '${_info!.totalDistance}, ${_info!.totalDuration}',
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          Positioned(
            bottom: 120.0,
            right: 16.0,
            child: FloatingActionButton(
              backgroundColor: Colors.white,
              onPressed: () {
                setState(() {
                  _mapType = _mapType == MapType.normal
                      ? MapType.hybrid
                      : MapType.normal;
                });
              },
              child: const Icon(
                Icons.map,
                color: Colors.black,
              ),
            ),
          ),
          Positioned(
              top: 10.0,
              left: 0,
              right: 0,
              child: Container(
                height: 50.0,
                width: 300.0,
                margin: const EdgeInsets.symmetric(horizontal: 10.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(100.0),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      offset: Offset(0, 2),
                      blurRadius: 6.0,
                    )
                  ],
                ),
                child: TextField(
                  style: const TextStyle(
                    fontSize: 15.0,
                    color: Colors.black,
                  ),
                  decoration: const InputDecoration(
                    hintText: 'Find your scrap locations',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(left: 15.0, top: 15.0),
                    // set fontsize
                    hintStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 15.0,
                    ),
                    prefixIcon: Icon(
                      Icons.search,
                      size: 24.0,
                    ),
                  ),
                  onChanged: (val) {
                    // write search input onChanged function
                  },
                  onSubmitted: (value) => findDirectionsByAddress(value),
                ),
              )),
          Positioned(
              top: 70,
              left: 10,
              right: 10,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Around(distance: 3),
                  Around(distance: 5),
                  Around(distance: 10),
                ],
              )),
          Positioned(
              bottom: 60.0,
              right: 16.0,
              child: FloatingActionButton(
                  backgroundColor: Colors.white,
                  onPressed: () => _googleMapController.animateCamera(
                        _info != null
                            ? CameraUpdate.newLatLngBounds(_info!.bounds, 100.0)
                            : CameraUpdate.newCameraPosition(CameraPosition(
                                target: _origin!.position, zoom: 11)),
                      ),
                  child: const Icon(Icons.center_focus_strong))),
        ],
      ),
    );
  }

  void _addMarker(LatLng pos) async {
    if (_origin == null || (_origin != null && _destination != null)) {
      // Origin is not set OR Origin/Destination are both set
      // Set origin
      setState(() {
        _origin = Marker(
          markerId: const MarkerId('origin'),
          infoWindow: const InfoWindow(title: 'Origin'),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
          position: pos,
        );
        // Reset destination
        _destination = null;

        // Reset info
        _info = null;
      });
    } else {
      // Origin is already set
      // Set destination
      setState(() {
        _destination = Marker(
          markerId: const MarkerId('destination'),
          infoWindow: const InfoWindow(title: 'Destination'),
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
          position: pos,
        );
      });

      // Get directions
      await DirectionsRepository()
          .getDirections(origin: _origin!.position, destination: pos)
          .then((value) => {setState(() => _info = value)});
    }
  }
}
