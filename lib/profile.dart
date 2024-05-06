import 'dart:async';

import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:travelguide/authpage.dart';

import 'package:travelguide/editprofile.dart';

import 'package:travelguide/textfields3.dart';

import 'package:travelguide/visited_country.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
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
                Center(
                  child: Stack(
                    children: [
                      Container(
                        height: 230,
                        child: AppBar(
                          //   automaticallyImplyLeading: false,
                          backgroundColor: Color.fromARGB(255, 227, 227, 227),
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
                          backgroundColor: Color.fromARGB(255, 33, 33, 33),
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
                          actions: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: IconButton(
                                onPressed: () => Navigator.of(context).pop(),
                                icon: const Icon(
                                  Icons.person,
                                  color: Color.fromARGB(206, 162, 162, 162),
                                  size: 35,
                                ),
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
                        padding: const EdgeInsets.only(top: 170),
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
                                color: Color.fromARGB(255, 76, 0, 255),
                              )),
                            ),
                            IconButton(
                                onPressed: () async {
                                  await signOut();
                                },
                                icon: const Icon(
                                  Icons.logout,
                                  color: Color.fromARGB(255, 76, 0, 255),
                                )),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 30,
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
    );
  }
}
