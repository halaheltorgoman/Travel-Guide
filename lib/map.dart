// ignore_for_file:  prefer_const_declarations

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final MapController controller = MapController();
  final apiKey ='pk.eyJ1IjoiaGFueWFrb3YiLCJhIjoiY2x2ZjU5MHF5MGd6dzJpbnZrdHQzYnlwZiJ9.rEoxzx8Jnd6OBD2x6NYeOQ';
  LatLng latLng = const LatLng(
      31.239293517646644, 29.955860843168796); // default makan el marker
  LocationData? currentLocation; // user's location
  final TextEditingController _searchController = TextEditingController();
  // final List<String> _suggestions = [];

  //   @override
  // void dispose() {
  //   _searchController.dispose();
  //   super.dispose();
  // }
  @override
  void initState() {
    super.initState();
    initLocation();
  }
  
  void updateMarkerPosition(LocationData? location) {
    setState(() {
      latLng = LatLng(location!.latitude!, location.longitude!);
    });
  }

  //location tracking
  Future<void> initLocation() async {
    var location = Location();
    currentLocation = await location.getLocation();
    updateMarkerPosition(currentLocation); // Update makan el marker b3d ma ageeb location el user
    controller.move(LatLng(currentLocation!.latitude ?? latLng.latitude,currentLocation!.longitude ?? latLng.longitude), 13);
    setState(() {});
  }


  Future<List<String>> _fetchSuggestions(String input) async {
    final endpoint ='https://api.mapbox.com/geocoding/v5/mapbox.places/$input.json?access_token=$apiKey';
    final response = await http.get(Uri.parse(endpoint));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['features'] != null) {
        final List<dynamic> features = data['features'];
        return features
            .map<String>((feature) => feature['place_name'] as String)
            .toList();
      }
    }
    return [];
  }


  void _moveToLocation(String locationName) async {
    final endpoint ='https://api.mapbox.com/geocoding/v5/mapbox.places/$locationName.json?access_token=$apiKey';

    final response = await http.get(Uri.parse(endpoint));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['features'] != null && data['features'].isNotEmpty) {
        final coordinates = data['features'][0]['center'];
        final double latitude = coordinates[1];
        final double longitude = coordinates[0];
        setState(() {
          latLng = LatLng(latitude, longitude);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FlutterMap(
            mapController: controller,
            options: MapOptions(
              initialCenter: latLng,
              initialZoom: 13,
              maxZoom: 18,
              minZoom: 3,
            ),
            children: [
              TileLayer(
                urlTemplate:"https://api.mapbox.com/styles/v1/hanyakov/clvf5dye4015001oc4m118b4v/tiles/256/{z}/{x}/{y}@2x?access_token=$apiKey",
                subdomains: const ['a','b','c'], 
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    point: latLng,
                    width: 60,
                    height: 60,
                    alignment: Alignment.topCenter,
                    child: Icon(
                      Icons.location_pin,
                      color: Colors.red.shade700,
                      size: 40,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Positioned(
            top: 5,
            left: 20,
            right: 20,
            child: TypeAheadField(
              textFieldConfiguration: TextFieldConfiguration(
                controller: _searchController,
                decoration: const InputDecoration(
                  hintText: 'Search for a location...',
                  border: OutlineInputBorder(),
                ),

                //onChanged: (value) {
                //    _fetchSuggestions(value).then((suggestions) {
                //     setState(() {
                //       _suggestions = suggestions;
                //     });
                //   });
                // },

              ),
              suggestionsCallback: (pattern) async {
                return _fetchSuggestions(pattern);
              },
              itemBuilder: (context, suggestion) {
                //suggestion list ui
                return ListTile(
                  title: Text(suggestion),
                );
              },
              onSuggestionSelected: (suggestion) {
                _moveToLocation(suggestion);
              },
            ),
          ),
        ],
      ),
    );
  }
}


