import 'dart:io';

import 'package:bakeway_app/constants/color_constants/color_constants.dart';
import 'package:bakeway_app/shared_components/app_bar/app_bar.dart';
import 'package:bakeway_app/shared_components/margin_container/margin_container.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:image_picker/image_picker.dart';

import '../../shared_components/decorated_textfield/decorated_textfield.dart';
import '../../shared_components/section_heading/section_heading.dart';
import '../../utils/utils.dart';
import '../forgot_password.dart/forgot_password_screen.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? _image;
  final picker = ImagePicker();
  final user = FirebaseAuth.instance.currentUser!;
  final nameController = TextEditingController();

  CollectionReference customer =
      FirebaseFirestore.instance.collection('customer');

  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  Future getImage(data) async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });

    firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
        .ref('/customer/' + DateTime.now().millisecondsSinceEpoch.toString());
    firebase_storage.UploadTask uploadTask = ref.putFile(_image!.absolute);

    Future.value(uploadTask).then((value) async {
      var newUrl = await ref.getDownloadURL();

      customer.doc(data['id'].toString()).update({
        'imageUrl': newUrl,
      }).then((value) {
        Utils().toastMessage('uploaded');
      }).onError((error, stackTrace) {
        print(error.toString());
      });
    }).onError((error, stackTrace) {
      Utils().toastMessage(error.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: kDefaultColor,
        leading: IconButton(
          onPressed: () {
            Navigator.pushNamed(context, '/main-screen');
          },
          icon: Icon(Icons.arrow_back),
        ),

        elevation: 0,
        title: Text('Profile'),

        // actions: [Icon(ba)],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: customer.where('email', isEqualTo: user.email).snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }

          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data()! as Map<String, dynamic>;
              return Column(
                children: [
                  SizedBox(
                    height: 40,
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Stack(
                        children: [
                          _image == null
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: Image.network(
                                    data['imageUrl'],
                                    height: 200,
                                    width: 200,
                                  ),
                                )
                              : Image.file(
                                  _image!,
                                  width: 200,
                                  height: 200,
                                ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Color(0xFF424242),
                                  shape: BoxShape.circle),
                              child: IconButton(
                                onPressed: () {
                                  getImage(data);
                                },
                                icon: Icon(Icons.edit),
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: TextFormField(
                              readOnly: true,
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                hintText: "|   ${data['name']}",
                                prefixIcon:
                                    Icon(Icons.person, color: Colors.white),
                                filled: true,
                                fillColor: Color(0xFF424242),
                                hintStyle: TextStyle(color: Colors.white),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(52),
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 6, horizontal: 16),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 12.0, right: 12, bottom: 12),
                            child: TextFormField(
                              readOnly: true,
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                hintText: "|   ${data['email']}",
                                prefixIcon:
                                    Icon(Icons.mail, color: Colors.white),
                                filled: true,
                                fillColor: Color(0xFF424242),
                                hintStyle: TextStyle(color: Colors.white),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(52),
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 6, horizontal: 16),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      InkWell(
                          onTap: () {
                            showMyDialog(data);
                          },
                          child: Container(
                              height: 50,
                              width: 230,
                              decoration: BoxDecoration(
                                  color: kDefaultColor,
                                  borderRadius: BorderRadius.circular(52)),
                              child: Center(
                                child: Text(
                                  'Update Name',
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ))),
                      SizedBox(
                        height: 10,
                      ),
                      InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ForgotPasswordScreen()));
                          },
                          child: Container(
                              height: 50,
                              width: 230,
                              decoration: BoxDecoration(
                                  color: kDefaultColor,
                                  borderRadius: BorderRadius.circular(52)),
                              child: Center(
                                child: Text(
                                  'Update Password',
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ))),
                    ],
                  ),
                ],
              );
            }).toList(),
          );
        },
      ),
    );
  }

  Future<void> showMyDialog(Map<String, dynamic> data) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Update Name'),
          content: Container(
            height: 80,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(
                    hintText: data['name'],
                    border: OutlineInputBorder(),
                    labelStyle: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  customer
                      .doc(data['id'].toString())
                      .update({
                        'name': nameController.text.trim(), // John Doe
                      })
                      .then((value) => print("User Updated"))
                      .catchError(
                          (error) => print("Failed to update user: $error"));
                  nameController.clear();
                  Navigator.pop(context);
                },
                child: Text("Update"))
          ],
        );
      },
    );
  }
}
