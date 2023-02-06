import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PolylineScreen extends StatefulWidget {
  const PolylineScreen({super.key});

  @override
  State<PolylineScreen> createState() => _PolylineScreenState();
}

class _PolylineScreenState extends State<PolylineScreen> {
  Completer<GoogleMapController> _controller = Completer();

  CameraPosition kGooglePlex = const CameraPosition(
    target: LatLng(25.410475, 68.364542),
    zoom: 14,
  );
  Set<Marker> _markers = {};
  Set<Polyline> _polyline = {};
  List<LatLng> latLng = [
    const LatLng(25.410475, 68.364542), // current location
    const LatLng(25.410265116664323, 68.36553394842564),
    const LatLng(25.410963330834264, 68.36403592758683), // drop-off location
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    for (int i = 0; i < latLng.length; i++) {
      _markers.add(
        Marker(
          markerId: MarkerId(i.toString()),
          position: latLng[i],
          infoWindow: const InfoWindow(
              title: "Really cool place", snippet: "5 Star Rating"),
          icon: BitmapDescriptor.defaultMarker,
        ),
      );
      setState(() {});
      _polyline.add(
        Polyline(
            polylineId: const PolylineId("1"),
            points: latLng,
            color: Colors.yellow),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Polyline in Google Maps"),
        centerTitle: true,
      ),
      body: GoogleMap(
        initialCameraPosition: kGooglePlex,
        mapType: MapType.hybrid,
        markers: _markers,
        polylines: _polyline,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        myLocationEnabled: true,
      ),
    );
  }
}
