// ignore_for_file: prefer_interpolation_to_compose_strings

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GetUserCurrentLocationScreen extends StatefulWidget {
  const GetUserCurrentLocationScreen({super.key});

  @override
  State<GetUserCurrentLocationScreen> createState() =>
      _GetUserCurrentLocationScreenState();
}


class _GetUserCurrentLocationScreenState
    extends State<GetUserCurrentLocationScreen> {
  final Completer<GoogleMapController> _controller = Completer();

  static CameraPosition _kGooglePlex = const CameraPosition(
    target: LatLng(24.9596, 67.2252),
    zoom: 14,
  );

  final List<Marker> _markers = <Marker>[
    const Marker(
      markerId: MarkerId('1'),
      position: LatLng(24.9596, 67.2252),
      infoWindow: InfoWindow(title: "The title of the marker"),
    )
  ];

  loadData() {
    getUserCurrentLocation().then(
      (value) async {
        debugPrint("My Current Location");
        debugPrint(
            value.latitude.toString() + " " + value.longitude.toString());
        _markers.add(
          Marker(
              markerId: const MarkerId('2'),
              position: LatLng(value.latitude, value.longitude),
              infoWindow: const InfoWindow(title: "My Current Location")),
        );

        CameraPosition cameraPosition = CameraPosition(
          zoom: 14,
          target: LatLng(value.latitude, value.longitude),
        );

        final GoogleMapController controller = await _controller.future;
        controller
            .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
        setState(() {});
      },
    );
  }

  // Position = Coordinates/Latitude/Longitude
  Future<Position> getUserCurrentLocation() async {
    Geolocator.requestPermission().then((value) {}).onError(
      (error, stackTrace) {
        debugPrint("Error" + error.toString());
      },
    );
    return await Geolocator.getCurrentPosition();
  }

 
 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        mapType: MapType.satellite,
        initialCameraPosition: _kGooglePlex,
        markers: Set<Marker>.of(_markers),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          getUserCurrentLocation().then(
            (value) async {
              debugPrint("My Current Location");
              debugPrint(
                  value.latitude.toString() + " " + value.longitude.toString());
              _markers.add(
                Marker(
                    markerId: const MarkerId('2'),
                    position: LatLng(value.latitude, value.longitude),
                    infoWindow: const InfoWindow(title: "My Current Location")),
              );

              CameraPosition cameraPosition = CameraPosition(
                zoom: 14,
                target: LatLng(value.latitude, value.longitude),
              );

              final GoogleMapController controller = await _controller.future;
              controller.animateCamera(
                  CameraUpdate.newCameraPosition(cameraPosition));
              setState(() {});
            },
          );
        },
        child: const Icon(Icons.local_activity),
      ),
    );
  }
}
