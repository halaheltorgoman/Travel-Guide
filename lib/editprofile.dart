import 'dart:async';

import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:travelguide/authpage.dart';

import 'package:travelguide/textfields2.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final List<String> items = [
    'USA',
    'China',
    'France',
    'Germany',
    'Italy',
    'Japan',
    'Mexico',
    'Netherlands',
    'Spain',
    'Turkey'
  ];
  String? Countryfrom;
  Future<void> userCountry() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null && Countryfrom != null) {
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(user.email)
          .update({'from': Countryfrom});
    }
  }

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
    // TODO: implement initState
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

  Widget optionMenu() {
    return Container(
      height: 150,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: [
          const Text(
            "Set your Profile Picture",
            style: TextStyle(fontSize: 20),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton.icon(
                onPressed: () {
                  photofrom(ImageSource.camera);
                },
                icon: const Icon(Icons.camera_alt),
                label: const Text("Camera"),
              ),
              TextButton.icon(
                onPressed: () {
                  photofrom(ImageSource.gallery);
                },
                icon: const Icon(Icons.photo),
                label: const Text("Photos"),
              ),
            ],
          ),
        ],
      ),
    );
  }

  final user = FirebaseAuth.instance.currentUser;
  final allUsers = FirebaseFirestore.instance.collection("Users");
  Future<void> editField(String field) async {
    String newValue = "";
    await showDialog(
        context: context,
        builder: (context) => Center(
              child: AlertDialog(
                backgroundColor: Color.fromARGB(255, 42, 2, 143),
                title: Text(
                  "Edit $field",
                  style: GoogleFonts.poppins(
                      textStyle: const TextStyle(
                          letterSpacing: 1,
                          decoration: TextDecoration.underline,
                          decorationColor: Colors.white,
                          fontSize: 20,
                          color: Color.fromARGB(255, 255, 255, 255))),
                ),
                content: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: SizedBox(
                    width: 450,
                    height: 80,
                    child: TextField(
                      onChanged: (value) {
                        newValue = value;
                      },
                      decoration: InputDecoration(
                        fillColor: Color.fromRGBO(255, 255, 255, 1),
                        filled: true,
                        contentPadding: EdgeInsets.all(10),
                        hintText: "Enter new $field",
                        hintStyle: const TextStyle(
                          color: Color.fromRGBO(161, 184, 213, 0.282),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                ),
                actions: [
                  TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        "Cancel",
                        style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                                letterSpacing: 1,
                                fontSize: 18,
                                color: Color.fromARGB(255, 255, 255, 255))),
                      )),
                  TextButton(
                      onPressed: () => Navigator.of(context).pop(newValue),
                      child: Text(
                        "Save",
                        style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                                letterSpacing: 1,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 255, 255, 255))),
                      )),
                ],
              ),
            ));

    if (newValue.trim().length > 0) {
      await allUsers.doc(user?.email).update({field: newValue});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: StreamBuilder<DocumentSnapshot>(
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
                        height: 150,
                        child: AppBar(
                          automaticallyImplyLeading: false,
                          backgroundColor: Color.fromARGB(159, 214, 212, 248),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(2000),
                              // bottomRight: Radius.circular(200)
                            ),
                          ),
                        ),
                      ),
                      AppBar(
                        automaticallyImplyLeading: false,
                        backgroundColor: Colors.transparent,
                        title: Text(
                          "    Edit Your Profile",
                          style: GoogleFonts.poppins(
                              textStyle: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1,
                                  fontSize: 23,
                                  color: Color.fromARGB(255, 0, 0, 0))),
                        ),
                        actions: [
                          IconButton(
                              onPressed: () async {
                                await signOut();
                              },
                              icon: Icon(
                                Icons.logout,
                                color: Colors.white,
                                size: 30,
                              ))
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 130),
                        child: Center(
                          child: CircleAvatar(
                            backgroundColor: Colors.black,
                            radius: 62,
                            child: CircleAvatar(
                              radius: 60.0,
                              backgroundImage: pickedImage == null
                                  ? const AssetImage(
                                      "Lottie/defaultprofile.png",
                                    )
                                  : Image.memory(pickedImage!).image,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                          bottom: -10,
                          right: 130,
                          child: IconButton(
                            onPressed: () {
                              showModalBottomSheet(
                                context: context,
                                builder: ((builder) => optionMenu()),
                              );
                            },
                            icon: const Icon(Icons.edit),
                            color: const Color.fromARGB(255, 0, 0, 0),
                          ))
                    ],
                  ),
                ),
                SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      DropdownButtonHideUnderline(
                        child: DropdownButton2<String>(
                          isExpanded: true,
                          hint: Text(
                            'Select Country',
                            style: TextStyle(
                              fontSize: 14,
                              color: Color.fromARGB(255, 187, 186, 186),
                            ),
                          ),
                          items: items
                              .map((String item) => DropdownMenuItem<String>(
                                    value: item,
                                    child: Center(
                                      child: Text(item,
                                          style: GoogleFonts.poppins(
                                              textStyle: const TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  letterSpacing: 1,
                                                  fontSize: 18,
                                                  color: Color.fromARGB(
                                                      255, 255, 255, 255)))),
                                    ),
                                  ))
                              .toList(),
                          value: Countryfrom,
                          onChanged: (String? value) {
                            setState(() {
                              Countryfrom = value;
                            });
                            userCountry();
                          },
                          buttonStyleData: ButtonStyleData(
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: const Color.fromARGB(255, 0, 0, 0)
                                      .withOpacity(0.4),
                                  blurRadius: 4,
                                  offset: Offset(0, 4),
                                )
                              ],
                              color: Color.fromARGB(255, 63, 3, 213),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            height: 40,
                            width: 140,
                          ),
                          dropdownStyleData: DropdownStyleData(
                            maxHeight: 190,
                            width: 160,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              color: Color.fromARGB(255, 135, 91, 248),
                            ),
                            offset: const Offset(-8, 0),
                            scrollbarTheme: ScrollbarThemeData(
                              radius: const Radius.circular(40),
                              thickness: MaterialStateProperty.all(6),
                              thumbVisibility: MaterialStateProperty.all(true),
                            ),
                          ),
                          iconStyleData: const IconStyleData(
                            icon: Icon(
                              Icons.arrow_forward_ios_outlined,
                              color: Colors.white,
                              size: 14,
                            ),
                          ),
                          menuItemStyleData: const MenuItemStyleData(
                            height: 40,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      TextFields2(
                        tag: "         Username:",
                        text: userData['username'],
                        onPressed: () => editField('username'),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFields2(
                        tag: "Email:",
                        text: userData['email'],
                        onPressed: () => editField('email'),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFields2(
                        tag: "        Password:",
                        text: obscurePassword(userData['password']),
                        onPressed: () => editField('password'),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Center(
                        child: Stack(children: [
                          Transform.flip(
                            flipY: true,
                            child: Container(
                              height: 150,
                              child: AppBar(
                                automaticallyImplyLeading: false,
                                backgroundColor:
                                    Color.fromARGB(159, 214, 212, 248),
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      // bottomLeft: Radius.circular(2000),
                                      bottomRight: Radius.circular(2000)),
                                ),
                              ),
                            ),
                          ),
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 40.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(30.0),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color:
                                            const Color.fromARGB(255, 0, 0, 0)
                                                .withOpacity(0.4),
                                        blurRadius: 4,
                                        offset: Offset(0, 8),
                                      )
                                    ]),
                                child: ElevatedButton(
                                  onPressed: () => Navigator.of(context).pop(),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        const Color.fromARGB(255, 12, 12, 12),
                                    minimumSize: const Size(160, 50),
                                  ),
                                  child: Text(
                                    "Save",
                                    style: GoogleFonts.poppins(
                                        textStyle: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 1,
                                            fontSize: 20,
                                            color: Color.fromARGB(
                                                255, 255, 255, 255))),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ]),
                      ),
                    ],
                  ),
                )
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
    ));
  }
}
