// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:travelguide/eat_out.dart';

import 'package:travelguide/explore.dart';
import 'package:travelguide/hotels.dart';
import 'package:travelguide/maps.dart';
import 'package:travelguide/profile.dart';

import 'package:travelguide/translator.dart';
import 'package:travelguide/visited_country.dart';

class NavigatorScreen extends StatefulWidget {
  const NavigatorScreen({super.key});

  @override
  State<NavigatorScreen> createState() => _NavigatorScreenState();
}

class _NavigatorScreenState extends State<NavigatorScreen> {
  final user = FirebaseAuth.instance.currentUser;
  final allUsers =
      FirebaseFirestore.instance.collection("Users").doc('username');

  int _selectedIndex = 0;
  PageController _pageController = PageController();

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _pageController.animateToPage(
        index,
        duration: Duration(milliseconds: 200),
        curve: Curves.easeInOut,
      );
    });
  }

  final List<Widget> _screens = [
    Explore(),
    Maps(),
    Translator(),
    Hotels(),
    EatOut(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        extendBody: true,
        appBar: AppBar(
            title: StreamBuilder<DocumentSnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("Users")
                    .doc(user!.email)
                    .snapshots(),
                builder: ((context, snapshot) {
                  if (snapshot.hasData) {
                    final userData =
                        snapshot.data?.data() as Map<String, dynamic>;
                    return Center(
                      child: Text(
                        "Hi, ${userData['username']}",
                        style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                                fontWeight: FontWeight.w400,
                                letterSpacing: 1,
                                fontSize: 25,
                                color: Color.fromARGB(255, 255, 255, 255))),
                      ),
                    );
                  } else {
                    if (snapshot.hasError) {
                      return Center(child: Text('User'));
                    }
                    return Center(child: CircularProgressIndicator());
                  }
                })),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30)),
            ),
            toolbarHeight: 65,
            backgroundColor: Color.fromARGB(255, 33, 33, 33),
            leading: Padding(
              padding: const EdgeInsets.all(2.0),
              child: IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => VisitedCountry()),
                    );
                  },
                  icon: const Icon(
                    Icons.travel_explore,
                    color: Colors.white,
                    size: 35,
                  )),
            ),
            actions: [
              Padding(
                padding: EdgeInsets.all(10.0),
                child: IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Profile()),
                    );
                  },
                  icon: Icon(
                    Icons.person,
                    color: Color.fromARGB(255, 255, 255, 255),
                    size: 35,
                  ),
                ),
              ),
            ]),
        body: PageView(
          controller: _pageController,
          children: _screens,
          onPageChanged: (index) {
            setState(() {
              _selectedIndex = index; // Update the selected index
            });
          },
        ),
        bottomNavigationBar: CurvedNavigationBar(
          color: Color.fromARGB(255, 33, 33, 33),
          backgroundColor: Color.fromARGB(0, 255, 255, 255),
          items: const [
            CurvedNavigationBarItem(
                label: 'Explore',
                labelStyle: TextStyle(color: Colors.white),
                child: Icon(
                  Icons.search,
                  color: Colors.white,
                )),
            CurvedNavigationBarItem(
                label: 'Maps',
                labelStyle: TextStyle(color: Colors.white),
                child: Icon(
                  Icons.map,
                  color: Colors.white,
                )),
            CurvedNavigationBarItem(
                label: 'Translate',
                labelStyle: TextStyle(color: Colors.white),
                child: Icon(
                  Icons.translate,
                  color: Colors.white,
                )),
            CurvedNavigationBarItem(
                label: 'Hotels',
                labelStyle: TextStyle(color: Colors.white),
                child: Icon(
                  Icons.bed,
                  color: Colors.white,
                )),
            CurvedNavigationBarItem(
                label: 'Food',
                labelStyle: TextStyle(color: Colors.white),
                child: Icon(
                  Icons.restaurant,
                  color: Colors.white,
                )),
          ],
          onTap: _onItemTapped,
          index: _selectedIndex,
        ));
  }
}
