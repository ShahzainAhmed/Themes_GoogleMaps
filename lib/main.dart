import 'package:flutter/material.dart';
import 'package:fluttergooglemap/convert_latlang_to_address.dart';
import 'package:fluttergooglemap/custom_info_window.dart';
import 'package:fluttergooglemap/custom_marker_screen.dart';
import 'package:fluttergooglemap/google_places_api.dart';
import 'package:fluttergooglemap/home.dart';
import 'package:fluttergooglemap/network_image_custom_Marker.dart';
import 'package:fluttergooglemap/polygons.dart';
import 'package:fluttergooglemap/polyline.dart';
import 'package:fluttergooglemap/style_googlemap_screen.dart';
import 'package:fluttergooglemap/users_current_location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StyleGoogleMapScreen(),
    );
  }
}
