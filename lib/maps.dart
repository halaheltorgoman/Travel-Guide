import 'dart:convert';

import 'package:location/location.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;

class Maps extends StatefulWidget {
  const Maps({super.key});

  @override
  State<Maps> createState() => _MapsState();
}

class _MapsState extends State<Maps> {
  final MapController controller = MapController();
  final apiKey =
      'pk.eyJ1IjoiaGFsYWgiLCJhIjoiY2x2djF6cmVoMWZoNTJqbWhjMmhzYzB6cSJ9.lX0DRnjFeaNks40LlcwK1g';
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
    updateMarkerPosition(
        currentLocation); // Update makan el marker b3d ma ageeb location el user

    controller.move(
        LatLng(currentLocation!.latitude ?? latLng.latitude,
            currentLocation!.longitude ?? latLng.longitude),
        13);
    setState(() {});
  }

  Future<List<String>> _fetchSuggestions(String input) async {
    final endpoint =
        'https://api.mapbox.com/geocoding/v5/mapbox.places/$input.json?access_token=$apiKey';
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
    final endpoint =
        'https://api.mapbox.com/geocoding/v5/mapbox.places/$locationName.json?access_token=$apiKey';

    final response = await http.get(Uri.parse(endpoint));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['features'] != null && data['features'].isNotEmpty) {
        final coordinates = data['features'][0]['center'];
        final double latitude = coordinates[1];
        final double longitude = coordinates[0];
        setState(() {
          latLng = LatLng(latitude, longitude);
          controller.move(latLng, 13);
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
                urlTemplate:
                    "https://api.mapbox.com/styles/v1/halah/clvv21j9d022x01qv20zs5ip5.html?title=view&access_token=pk.eyJ1IjoiaGFsYWgiLCJhIjoiY2x2djF6cmVoMWZoNTJqbWhjMmhzYzB6cSJ9.lX0DRnjFeaNks40LlcwK1g&zoomwheel=true&fresh=true#2/37.75/-92.25",
                subdomains: const ['a', 'b', 'c'],
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
