import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:ui' as ui;

class CustomMarkerScreen extends StatefulWidget {
  const CustomMarkerScreen({super.key});

  @override
  State<CustomMarkerScreen> createState() => _CustomMarkerScreenState();
}

final Completer<GoogleMapController> _controller = Completer();

Uint8List? markerImage;

List<String> images = ['images/car.png', 'images/bike.png'];

class _CustomMarkerScreenState extends State<CustomMarkerScreen> {
  final List<Marker> _markers = <Marker>[];
  final List<LatLng> _latLang = <LatLng>[
    const LatLng(25.4073, 68.3669),
    const LatLng(25.3988, 68.3399),
  ];

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(24.8920, 67.0747),
    zoom: 15,
  );

  Future<Uint8List> getBytesFromAssets(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  loadData() async {
    // i = index
    for (int i = 0; i < images.length; i++) {
      final Uint8List markerIcon = await getBytesFromAssets(images[i], 100);
      _markers.add(
        Marker(
            markerId: MarkerId(
              i.toString(),
            ),
            position: _latLang[i],
            icon: BitmapDescriptor.fromBytes(markerIcon),
            infoWindow:
                InfoWindow(title: "This is title marker" + i.toString())),
      );
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: _kGooglePlex,
        mapType: MapType.normal,
        myLocationButtonEnabled: true,
        myLocationEnabled: true,
        markers: Set<Marker>.of(_markers),
        onMapCreated: ((GoogleMapController controller) {
          _controller.complete(controller);
        }),
      ),
    );
  }
}
