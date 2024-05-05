// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:travelguide/visited_cities.dart';
//import 'package:cached_network_image/cached_network_image.dart';

class CountryGridElement extends StatefulWidget {
  const CountryGridElement(this.path, {Key? key}) : super(key: key);

  final String path;
  @override
  State<CountryGridElement> createState() => _CountryGridElementState();
}

class _CountryGridElementState extends State<CountryGridElement> {
  //snackbar
  void _showCustomSnackbar(BuildContext context, String country) {
    if (country == 'Egypt') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => VisitedCities()),
      );
    } else {
      final snackBar = SnackBar(
        content: Text('App under development'),
        duration: Duration(seconds: 2),
        action: SnackBarAction(
          label: 'Close',
          onPressed: () {
            // default behaviour is close
          },
        ),
      );
      //showing snackbar
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  //final String? _path;
  @override
  Widget build(BuildContext context) {
    //give path
    final String? imagePath = widget.path;
    return Scaffold(
      body: Center(
        child: GestureDetector(
          onTap: () {
            _showCustomSnackbar(context, extractFileName(widget.path));
          },
          child: Column(
            //to display image and name
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (imagePath != null)
                //builds widget based on future events
                FutureBuilder(
                  //the future action is to get image url
                  future:
                      FirebaseStorage.instance.ref(imagePath).getDownloadURL(),
                  //when future action comes buildthe following
                  builder:
                      //AsyncSnapshot contains info about the future action
                      //if successful it takes data of type string if not it contains error info
                      //asynchronous action allows code to execute independently from main flow
                      (BuildContext context, AsyncSnapshot<String> snapshot) {
                    //if it's still loading show loading circle
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                      // if it hasan error show it
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      // Use Image.network to display the image
                      return Center(
                          child: Container(
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black
                                        .withOpacity(0.5), // Shadow color
                                    spreadRadius: 2, // Spread radius
                                    blurRadius: 7, // Blur radius
                                    offset:
                                        Offset(0, 3), // Offset of the shadow
                                  ),
                                ],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
                                child: Image.network(
                                  //non-null assertion
                                  snapshot.data!,
                                  width: 100, // Adjust the width as needed
                                  height: 100, // Adjust the height as needed
                                  fit: BoxFit.cover, // Adjust the fit as needed
                                ),
                              )));
                    }
                  },
                ),
              SizedBox(height: 20),
              Text(extractFileName(widget.path))
            ],
          ),
        ),
      ),
    );
  }
}

//function takes path and returns name
//example countries/Egypt.png returns Egypt
String extractFileName(String input) {
  int slashIndex = input.indexOf('/');
  int dotIndex = input.lastIndexOf('.');

  if (slashIndex != -1 && dotIndex != -1 && slashIndex < dotIndex) {
    return input.substring(slashIndex + 1, dotIndex);
  }

  return input;
}
