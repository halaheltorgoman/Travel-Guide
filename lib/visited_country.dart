// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:travelguide/country_grid_element.dart';

class VisitedCountry extends StatefulWidget {
  const VisitedCountry({super.key});

  @override
  State<VisitedCountry> createState() => _VisitedCountryState();
}

//stores images retrieved from storage
List<String> images = [];

class _VisitedCountryState extends State<VisitedCountry> {
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
      final folder = storage.ref().child('countries');
      // retrieve files from firebase Storage folder
      folder.listAll().then((result) {
        //iterate over each item and represent by refrence
        result.items.forEach((Reference ref) {
          // adding image if the path doesn't exist
          if (!images.contains(ref.fullPath)) {
            images.add(ref.fullPath);
          }
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
            ],
          ),
          centerTitle: true,
          bottom: PreferredSize(
            preferredSize:
                const Size.fromHeight(4.0), // Adjust the height of the line
            child: Container(
              color: Colors.black, // Set the color of the line
              height: 2.0, // Set the height of the line
            ),
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Which country are you visiting',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            //grid view can't be inside column as it needs to expand so we wrap with expanded
            Expanded(
              child: GridView.builder(
                  itemCount: images.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8.0,
                      mainAxisSpacing: 8.0),
                  itemBuilder: (BuildContext context, int index) {
                    try {
                      return CountryGridElement(images[index]);
                    } catch (e) {
                      return Text('Error loading item at index $index');
                    }
                  }),
            ),
          ],
        ));
  }
}
