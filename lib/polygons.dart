import 'dart:async';
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PolygonsScreen extends StatefulWidget {
  const PolygonsScreen({super.key});

  @override
  State<PolygonsScreen> createState() => _PolygonsScreenState();
}

class _PolygonsScreenState extends State<PolygonsScreen> {
  Completer<GoogleMapController> _controller = Completer();

  CameraPosition kGooglePlex = const CameraPosition(
    target: LatLng(25.410475, 68.364542),
    zoom: 14,
  );

  Set<Polygon> _polygon = HashSet<Polygon>();
  List<LatLng> points = [
    // starting and ending points should always be same consider it a square
    const LatLng(25.410475, 68.364542),
    const LatLng(25.410444087436463, 68.36406193941798),
    const LatLng(25.410866, 68.363946),
    const LatLng(25.410475, 68.364542),
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _polygon.add(
      Polygon(
        polygonId: const PolygonId("1"),
        points: points,
        fillColor: Colors.red.withOpacity(0.5),

        geodesic:
            true, // shortest path between two points on the Earth's surface
        strokeWidth: 4,
        strokeColor: Colors.deepOrange,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Polygon"),
        centerTitle: true,
      ),
      body: GoogleMap(
        initialCameraPosition: kGooglePlex,
        myLocationButtonEnabled: true,
        myLocationEnabled: false,
        mapType: MapType.hybrid,
        polygons: _polygon,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }
}
