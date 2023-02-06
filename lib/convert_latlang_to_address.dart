// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';

class ConvertLatLangToAddress extends StatefulWidget {
  const ConvertLatLangToAddress({super.key});

  @override
  State<ConvertLatLangToAddress> createState() =>
      ConvertLatLangToAddressState();
}

class ConvertLatLangToAddressState extends State<ConvertLatLangToAddress> {
  String stAdress = " ", stAdd = " ";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Converting Longitude/Latitude to Address"),
        centerTitle: true,
        backgroundColor: Colors.lightBlue[800],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            stAdress,
            style: const TextStyle(fontSize: 20),
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            stAdd,
            style: const TextStyle(fontSize: 20),
          ),
          GestureDetector(
            onTap: () async {
              List<Location> locations =
                  await locationFromAddress("Askari V Malir Cantt, Karachi");
              List<Placemark> placemarks = await placemarkFromCoordinates(
                  24.9596, 67.2252); // longitude latitude

              setState(
                () {
                  stAdress = locations.last.longitude.toString() +
                      " " +
                      locations.last.latitude.toString();
                  stAdd = placemarks.reversed.last.name.toString() +
                      " " +
                      placemarks.reversed.last.locality.toString() +
                      " " +
                      placemarks.reversed.last.country.toString();
                },
              );
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 30),
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: const Center(
                  child: Text(
                    "CONVERT",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
