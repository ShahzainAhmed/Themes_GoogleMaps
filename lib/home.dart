import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // this controller will give you a lot of access to many fields in future
  final Completer<GoogleMapController> _controller = Completer();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(24.949399722210245, 67.18624017907798),
    zoom: 14, // default zoom is 14
  );

  final List<Marker> _marker = [];
  final List<Marker> _list = const [
    Marker(
      markerId: MarkerId('1'),
      position: LatLng(24.949399722210245, 67.18624017907798),
      infoWindow: InfoWindow(title: "Current location"),
    ),
    Marker(
      markerId: MarkerId('2'),
      position: LatLng(24.94882305462028, 67.18456722596076),
      infoWindow: InfoWindow(title: "Building 110"),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _marker.addAll(_list);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.location_disabled_outlined),
        onPressed: () async {
          GoogleMapController controller = await _controller.future;
          controller.animateCamera(
            CameraUpdate.newCameraPosition(
              const CameraPosition(
                target: LatLng(24.949399722210245, 67.18624017907798),
                zoom: 14,
              ),
            ),
          );
          setState(() {});
        },
      ),
      appBar: AppBar(
        title: const Text("Google Maps Flutter"),
      ),
      body: GoogleMap(
        initialCameraPosition: _kGooglePlex,
        markers: Set<Marker>.of(_marker),
        mapType: MapType.satellite,
        // myLocationButtonEnabled: true,
        // myLocationEnabled: true,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }
}
