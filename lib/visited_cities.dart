// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
//import 'package:flutter_application_3/city_list_element.dart';
import 'package:travelguide/list_view.dart';
import 'package:travelguide/navigator.dart';

class VisitedCities extends StatefulWidget {
  @override
  _VisitedCitiesState createState() => _VisitedCitiesState();
}

class _VisitedCitiesState extends State<VisitedCities> {
  List<String> images = [];

  @override
  @override
  //to intiate a state inside widget tree
  void initState() {
    super.initState();
    // initialize Firebase
    //.then() recieves the future value then performs a code (_) means neglecting returned values from intialization func. as it is irrelevent
    Firebase.initializeApp().then((_) {
      //create an instance of firebase storage
      final storage = FirebaseStorage.instance;
      //reference to firebase folder
      final folder = storage.ref().child('Cities');
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
      //AppBar 3ady
      appBar: AppBar(
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.person)),
          Padding(padding: EdgeInsets.all(5.0))
        ],
        title: const Column(
          children: [
            Text(
              'Hi, User',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w400),
            ),
            Text(
              "Welcome to Egypt!",
              style: TextStyle(fontWeight: FontWeight.w200),
            )
          ],
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4.0),
          child: Container(
            color: Colors.black,
            height: 2.0,
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Which city are you visiting',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
          Expanded(
            //if list is empty yes=> circular loading no=> build list view
            child: images.isEmpty
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: images.length,
                    itemBuilder: (BuildContext context, int index) {
                      try {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                              height: 200,
                              width: double.infinity,
                              child: GestureDetector(
                                onTap: () {
                                  _showCustomSnackbar(
                                      context, extractFileName(images[index]));
                                },
                                child: ListElementView(images[index],
                                    extractFileName(images[index])),
                              ) // Your item content
                              ),
                        );
                      } catch (e) {
                        return Text('Error loading item at index $index');
                      }
                    },
                  ),
          ),
        ],
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

void _showCustomSnackbar(BuildContext context, String city) {
  if (city == 'Alexandria') {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const NavigatorScreen()),
    );
  } else {
    final snackBar = SnackBar(
      content: Text('App under development'),
      duration: Duration(seconds: 2),
      action: SnackBarAction(
        label: 'Close',
        onPressed: () {
          // Default action is close
        },
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
