// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ListElementView extends StatefulWidget {
  const ListElementView(this.path, this.name, {super.key});

  final String path;
  final String name;

  @override
  State<ListElementView> createState() => _ListElementViewState();
}

class _ListElementViewState extends State<ListElementView> {
  @override
  Widget build(BuildContext context) {
    final String? imagePath = widget.path;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (imagePath != null)
            //builds widget based on future events
            FutureBuilder(
              //the future action is to get image url
              future: FirebaseStorage.instance.ref(imagePath).getDownloadURL(),
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
                  //stack to display text over image
                  return Stack(
                    children: [
                      // Image loaded from network
                      Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 7,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Image.network(
                            snapshot.data!,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      // Positioned text overlay
                      Positioned.fill(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Color.fromARGB(83, 0, 0, 0),
                          ),
                          height: 200,
                          width: double.infinity,
                          padding: EdgeInsets.all(8),
                          child: Center(
                            child: Text(
                              widget.name,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 40,
                                fontWeight: FontWeight.w900,
                                shadows: [
                                  Shadow(
                                    color: Colors.black,
                                    offset: Offset(2, 2),
                                    blurRadius: 3,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }
              },
            ),
        ],
      ),
    );
  }
}
