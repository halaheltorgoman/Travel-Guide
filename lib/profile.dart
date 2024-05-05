import 'dart:async';

import 'dart:typed_data';

import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:travelguide/authpage.dart';
import 'package:travelguide/eat_out.dart';
import 'package:travelguide/editprofile.dart';
import 'package:travelguide/explore.dart';
import 'package:travelguide/hotels.dart';
import 'package:travelguide/maps.dart';

import 'package:travelguide/textfields3.dart';
import 'package:travelguide/translator.dart';
import 'package:travelguide/visited_country.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
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
    EatOut()
  ];
  String obscurePassword(String password) {
    return '*' * password.length;
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const AuthPage()));
  }

  @override
  void initState() {
    super.initState();
    getProfilepic();
  }

  Uint8List? pickedImage;
  void photofrom(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final XFile? imageFile = await picker.pickImage(source: source);

    final storageRef = FirebaseStorage.instance.ref();
    final imageRef = storageRef.child('ProfilePicutes').child('_profile.jpg');
    // ignore: non_constant_identifier_names
    final ImageBytes = await imageFile?.readAsBytes();
    await imageRef.putData(ImageBytes!);
    setState(() {
      pickedImage = ImageBytes;
    });
  }

  Future<void> getProfilepic() async {
    final storageRef = FirebaseStorage.instance.ref();
    final imageRef = storageRef.child('ProfilePicutes').child('_profile.jpg');
    try {
      final ImageBytes = await imageRef.getData();
      if (ImageBytes == null) return;
      setState(() {
        pickedImage = ImageBytes;
      });
    } catch (e) {
      print(" no profilepic");
    }
  }

  final user = FirebaseAuth.instance.currentUser;
  final allUsers = FirebaseFirestore.instance.collection("Users");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection("Users")
            .doc(user!.email)
            .snapshots(),
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            final userData = snapshot.data!.data() as Map<String, dynamic>;

            return Column(
              children: [
                Expanded(
                  child: PageView(
                    controller: _pageController,
                    children: _screens,
                  ),
                ),
                Center(
                  child: Stack(
                    children: [
                      Container(
                        height: 200,
                        child: AppBar(
                          //   automaticallyImplyLeading: false,
                          backgroundColor: Color.fromARGB(159, 214, 212, 248),
                        ),
                      ),
                      Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(30.0),
                          ),
                        ),
                        child: AppBar(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(30),
                                bottomRight: Radius.circular(30)),
                          ),
                          toolbarHeight: 65,
                          backgroundColor: Color.fromARGB(255, 63, 3, 213),
                          leading: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: IconButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const VisitedCountry()),
                                  );
                                },
                                icon: const Icon(
                                  Icons.travel_explore,
                                  color: Colors.white,
                                  size: 35,
                                )),
                          ),
                          actions: const [
                            Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Icon(
                                Icons.person,
                                color: Color.fromARGB(206, 0, 0, 0),
                                size: 35,
                              ),
                            ),
                          ],
                          title: Column(
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Hi, ${userData['username']}',
                                style: GoogleFonts.poppins(
                                    textStyle: const TextStyle(
                                        fontWeight: FontWeight.w400,
                                        letterSpacing: 1,
                                        fontSize: 25,
                                        color: Color.fromARGB(
                                            255, 255, 255, 255))),
                              ),
                              Text(
                                "Profile",
                                style: GoogleFonts.poppins(
                                    textStyle: const TextStyle(
                                        fontWeight: FontWeight.w300,
                                        letterSpacing: 1,
                                        fontSize: 18,
                                        color: Color.fromARGB(
                                            255, 255, 255, 255))),
                              ),
                              const SizedBox(
                                height: 10,
                              )
                            ],
                          ),
                          centerTitle: true,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 130),
                        child: Center(
                          child: CircleAvatar(
                            backgroundColor: const Color.fromARGB(255, 0, 0, 0),
                            radius: 52,
                            child: CircleAvatar(
                              radius: 50.0,
                              backgroundImage: pickedImage == null
                                  ? const AssetImage(
                                      "Lottie/defaultprofile.png",
                                    )
                                  : Image.memory(pickedImage!).image,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Center(
                    child: Text(
                  userData['username'].toUpperCase(),
                  style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                          fontSize: 20,
                          color: Color.fromARGB(255, 0, 0, 0))),
                )),
                Text(userData['from']),
                const SizedBox(
                  height: 20,
                ),
                SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      TextFields3(
                        tag: "        Username:",
                        hint: userData['username'],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      TextFields3(
                        tag: "Email:",
                        hint: userData['email'],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      TextFields3(
                        tag: "        Password:",
                        hint: obscurePassword(userData['password']),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "LOG OUT".toUpperCase(),
                              style: GoogleFonts.poppins(
                                  textStyle: const TextStyle(
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1,
                                fontSize: 18,
                                color: Color.fromARGB(255, 160, 155, 249),
                              )),
                            ),
                            IconButton(
                                onPressed: () async {
                                  await signOut();
                                },
                                icon: const Icon(
                                  Icons.logout,
                                  color: Color.fromARGB(255, 160, 155, 249),
                                )),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(30.0),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color.fromARGB(255, 0, 0, 0)
                                      .withOpacity(0.4),
                                  blurRadius: 4,
                                  offset: const Offset(0, 8),
                                )
                              ]),
                          child: ElevatedButton(
                            onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const EditProfile()),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 12, 12, 12),
                              minimumSize: const Size(160, 50),
                            ),
                            child: Text(
                              "Edit Profile",
                              style: GoogleFonts.poppins(
                                  textStyle: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1,
                                      fontSize: 18,
                                      color:
                                          Color.fromARGB(255, 255, 255, 255))),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else {
            if (snapshot.hasError) {
              return Center(child: Text('error${snapshot.error}'));
            }
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        }),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        onTap: _onItemTapped,
        index: _selectedIndex,
        height: 70,
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        color: const Color.fromARGB(255, 63, 3, 213),
        items: const [
          CurvedNavigationBarItem(
              label: 'Explore',
              labelStyle: TextStyle(color: Colors.white, fontSize: 12),
              child: Icon(
                Icons.search,
                color: Colors.white,
              )),
          CurvedNavigationBarItem(
              label: 'Maps',
              labelStyle: TextStyle(color: Colors.white, fontSize: 12),
              child: Icon(
                Icons.map,
                color: Colors.white,
              )),
          CurvedNavigationBarItem(
              label: 'Translate',
              labelStyle: TextStyle(color: Colors.white, fontSize: 12),
              child: Icon(
                Icons.translate,
                color: Colors.white,
              )),
          CurvedNavigationBarItem(
              label: 'Hotels',
              labelStyle: TextStyle(color: Colors.white, fontSize: 12),
              child: Icon(
                Icons.bed,
                color: Colors.white,
              )),
          CurvedNavigationBarItem(
              label: 'Food',
              labelStyle: TextStyle(color: Colors.white, fontSize: 12),
              child: Icon(
                Icons.restaurant,
                color: Colors.white,
              )),
        ],
      ),
    );
  }
}
