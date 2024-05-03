// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:map_v1/map.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final MapController controller = MapController();
  LocationData? currentLocation;
  LatLng latLng = const LatLng(31.239293517646644, 29.955860843168796); //DEFAULT MARKER LOCATION

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Map'),
          backgroundColor: Colors.white,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          backgroundColor: Colors.white,
          child: const Icon(Icons.gps_fixed),
        ),
        body: const MapScreen(),
      ),
    );
  }
}
