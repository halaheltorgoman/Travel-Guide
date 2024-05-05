// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
//import 'package:flutter_application_3/explore_display.dart';
import 'package:travelguide/list_view.dart';

class Explore extends StatefulWidget {
  @override
  _ExploreState createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {
  List<String> images = [];

  @override
  void initState() {
    super.initState();
    // initialize Firebase
    //.then() recieves the future value then performs a code (_) means neglecting returned values from intialization func. as it is irrelevent
    Firebase.initializeApp().then((_) {
      //create an instance of firebase storage
      final storage = FirebaseStorage.instance;
      //reference to firebase folder
      final folder = storage.ref().child('places');
      // retrieve files from firebase Storage folder
      folder.listAll().then((result) {
        //iterate over each item and represent by refrence
        result.items.forEach((Reference ref) {
          // Add file path to images list
          images.add(ref.fullPath);
        });

        // Update UI with the file list
        setState(() {});
        //to disolay error if present
      }).catchError((e) {
        print('Error retrieving files: $e');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Expanded(
        child: images.isEmpty
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: images.length,
                itemBuilder: (BuildContext context, int index) {
                  try {
                    return Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Container(
                          height: 200,
                          width: double.infinity,
                          child: ListElementView(
                              images[index],
                              extractFileName(
                                  images[index])) // Your item content
                          ),
                    );
                  } catch (e) {
                    return Text('Error loading item at index $index');
                  }
                },
              ),
      ),
    );
  }
}

String extractFileName(String input) {
  int slashIndex = input.indexOf('/');
  int dotIndex = input.lastIndexOf('.');

  if (slashIndex != -1 && dotIndex != -1 && slashIndex < dotIndex) {
    return input.substring(slashIndex + 1, dotIndex);
  }

  return input;
}
