import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:ui' as ui;
import 'dart:ui';

class NetworkImageCustomMarker extends StatefulWidget {
  const NetworkImageCustomMarker({super.key});

  @override
  State<NetworkImageCustomMarker> createState() =>
      _NetworkImageCustomMarkerState();
}

class _NetworkImageCustomMarkerState extends State<NetworkImageCustomMarker> {
  Completer<GoogleMapController> _controller = Completer();

  CameraPosition kGooglePlex = const CameraPosition(
    target: LatLng(25.410475, 68.364542),
    zoom: 14,
  );

  final List<Marker> _markers = <Marker>[];

  final List<LatLng> _latLng = [
    const LatLng(25.410475, 68.364542),
    const LatLng(25.410265116664323, 68.36553394842564),
    const LatLng(25.410963330834264, 68.36403592758683),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  loadData() async {
    for (int i = 0; i < _latLng.length; i++) {
      Uint8List? image = await loadNetworkImage(
          "https://images.bitmoji.com/3d/avatar/201714142-99447061956_1-s5-v1.webp");

      final ui.Codec markerImageCodec = await ui.instantiateImageCodec(
        image!.buffer.asUint8List(),
        targetHeight: 400, // size of network image / icon
        targetWidth: 400, // size of network image / icon
      );

      final ui.FrameInfo frameInfo = await markerImageCodec.getNextFrame();
      final ByteData? byteData =
          await frameInfo.image.toByteData(format: ImageByteFormat.png);

      final Uint8List resizedImageMarker = byteData!.buffer.asUint8List();
      _markers.add(
        Marker(
          markerId: MarkerId(
            i.toString(),
          ),
          position: _latLng[i],
          icon: BitmapDescriptor.fromBytes(resizedImageMarker),
          infoWindow: InfoWindow(
            title: "Title of marker " + i.toString(),
          ),
        ),
      );
      setState(() {});
    }
  }

  Future<Uint8List?> loadNetworkImage(String path) async {
    final completer = Completer<ImageInfo>();
    var image = NetworkImage(path);
    image.resolve(const ImageConfiguration()).addListener(
          ImageStreamListener(
            (info, _) => completer.complete(info),
          ),
        );
    final imageInfo = await completer.future;
    final byteData =
        await imageInfo.image.toByteData(format: ui.ImageByteFormat.png);

    return byteData!.buffer.asUint8List();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Network Image as Custom Marker"),
        centerTitle: true,
      ),
      body: GoogleMap(
        initialCameraPosition: kGooglePlex,
        mapType: MapType.normal,
        markers: Set<Marker>.of(_markers),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
      ),
    );
  }
}
