import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomMarkerInfoWindow extends StatefulWidget {
  const CustomMarkerInfoWindow({super.key});

  @override
  State<CustomMarkerInfoWindow> createState() => _CustomMarkerInfoWindowState();
}

class _CustomMarkerInfoWindowState extends State<CustomMarkerInfoWindow> {
  final CustomInfoWindowController _customInfoWindowController =
      CustomInfoWindowController();

  final List<Marker> _markers = <Marker>[];
  final List<LatLng> _latLng = <LatLng>[
    const LatLng(25.4073, 68.3669),
    const LatLng(25.3988, 68.3399),
  ];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() {
    for (int i = 0; i < _latLng.length; i++) {
      if (i % 2 == 0) {
        _markers.add(
          Marker(
            markerId: MarkerId(i.toString()),
            icon: BitmapDescriptor.defaultMarker,
            position: _latLng[i],
            onTap: () {
              _customInfoWindowController.addInfoWindow!(
                Container(
                  height: 300,
                  width: 200,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Center(
                    child:
                        CircleAvatar(radius: 30, backgroundColor: Colors.amber),
                  ),
                ),
                _latLng[i],
              );
            },
          ),
        );
      } else {
        _markers.add(
          Marker(
            markerId: MarkerId(i.toString()),
            icon: BitmapDescriptor.defaultMarker,
            position: _latLng[i],
            onTap: () {
              _customInfoWindowController.addInfoWindow!(
                Container(
                  height: 300,
                  width: 200,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 300,
                        height: 100,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(
                                'https://images.pexels.com/photos/1566837/pexels-photo-1566837.jpeg?cs=srgb&dl=pexels-narda-yescas-1566837.jpg&fm=jpg'),
                            fit: BoxFit.fitWidth,
                            filterQuality: FilterQuality.high,
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                          color: Colors.red,
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 10, left: 10, right: 10),
                        child: Row(
                          children: const [
                            SizedBox(
                              width: 100,
                              child: Text(
                                "Pizzeria",
                                maxLines: 1,
                                overflow: TextOverflow.fade,
                                softWrap: false,
                              ),
                            ),
                            Spacer(),
                            Text(".3 mi.")
                          ],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 10, left: 10, right: 10),
                        child: Text(
                          'Help me finish these tacos! I got a platter from Costco and its too much.',
                          maxLines: 2,
                        ),
                      ),
                    ],
                  ),
                ),
                _latLng[i],
              );
            },
          ),
        );
      }

      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Custom Marker Info Window"),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: const CameraPosition(
              zoom: 15,
              target: LatLng(25.4073, 68.3669),
            ),

            // markers: _markers --> It is giving error so we will write it as;
            markers: Set<Marker>.of(_markers),

            onTap: (position) {
              _customInfoWindowController.hideInfoWindow!();
            },

            onCameraMove: (position) {
              _customInfoWindowController.onCameraMove!();
            },

            onMapCreated: (GoogleMapController controller) {
              _customInfoWindowController.googleMapController = controller;
            },
          ),
          CustomInfoWindow(
            controller: _customInfoWindowController,
            height: 200,
            width: 300,
            offset: 35,
          )
        ],
      ),
    );
  }
}
