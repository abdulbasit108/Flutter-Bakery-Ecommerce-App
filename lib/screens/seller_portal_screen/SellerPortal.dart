import 'dart:io';

import 'package:bakeway_app/model/seller.dart';
import 'package:bakeway_app/screens/main_screen/main_screen.dart';
import 'package:bakeway_app/screens/seller_portal_screen/AddProduct.dart';
import 'package:bakeway_app/screens/seller_portal_screen/DeleteProduct.dart';
import 'package:bakeway_app/screens/seller_portal_screen/SoldProduct.dart';
import 'package:bakeway_app/screens/signin_screen/signin_screen.dart';
import 'package:bakeway_app/screens/widget/round_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../constants/color_constants/color_constants.dart';
import '../../utils/utils.dart';
import '../home_screen/home_screen.dart';

class SellerPortal extends StatefulWidget {
  const SellerPortal({super.key});

  @override
  State<SellerPortal> createState() => _SellerPortalState();
}

Future<Seller> getUserData() async {
  final user = FirebaseAuth.instance.currentUser!;
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('bakery');
  QuerySnapshot querySnapshot =
      await usersCollection.where('email', isEqualTo: user.email).get();
  Seller sellerData = Seller(email: '', bakery: '', cnic: '', ntn: '');
  if (querySnapshot.docs.isNotEmpty) {
    Seller data = Seller.fromFirestore(querySnapshot.docs[0]);
    sellerData = data;
  }
  return sellerData;
}

class _SellerPortalState extends State<SellerPortal> {
  late Future<Seller> _futureSellerData;
  final auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    _futureSellerData = getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kDefaultColor,
        leading: Icon(
          Icons.dashboard,
          color: Colors.white,
        ),
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Welcome',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            SizedBox(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 5),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        auth
                            .signOut()
                            .then((value) {})
                            .onError((error, stackTrace) {
                          Utils().toastMessage(error.toString());
                        });
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignInScreen()));
                      },
                      child: IgnorePointer(
                        child: Icon(
                          Icons.logout,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      body: FutureBuilder<Seller>(
        future: _futureSellerData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('An error occurred while loading data.'),
            );
          } else {
            final sellerData = snapshot.data!;
            return Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage("assets/images/splashscreen.jpg"),
                  fit: BoxFit.cover,
                )),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 10, top: 5),
                        padding: EdgeInsets.only(left: 5),
                        child: Text(
                          'Dashboard',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w900,
                              fontSize: 30.0),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 10, top: 10),
                        padding: EdgeInsets.only(left: 5),
                        child: Text(
                          sellerData.bakery,
                          style: TextStyle(
                              color: kDefaultColor,
                              fontWeight: FontWeight.w900,
                              fontSize: 24.0),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      SizedBox(
                        height: 100,
                      ),
                      Column(
                        children: [
                          Container(
                            width: 360,
                            height: 150,
                            margin: EdgeInsets.all(10),
                            padding: EdgeInsets.all(5),
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SoldScreen(
                                              bakery: sellerData.bakery,
                                            )));
                              },
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Color(0xFF424242)),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.history,
                                    size: 40,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    'Sales',
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                            decoration: BoxDecoration(
                              color: Color(0xFF424242),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 170,
                                height: 150,
                                margin: EdgeInsets.all(10),
                                padding: EdgeInsets.all(5),
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => AddProduct(
                                                  bakery: sellerData.bakery,
                                                )));
                                  },
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            kDefaultColor),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.playlist_add,
                                        size: 40,
                                      ),
                                      Text(
                                        'Add Product',
                                        style: TextStyle(fontSize: 12),
                                      ),
                                    ],
                                  ),
                                ),
                                decoration: BoxDecoration(
                                  color: kDefaultColor,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              Container(
                                width: 170,
                                height: 150,
                                margin: EdgeInsets.all(10),
                                padding: EdgeInsets.all(5),
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => DeleteScreen(
                                                  bakery: sellerData.bakery,
                                                )));
                                  },
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            kDefaultColor),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.delete,
                                        size: 40,
                                      ),
                                      Text('Delete/Edit Product',
                                          style: TextStyle(
                                            fontSize: 12,
                                          )),
                                    ],
                                  ),
                                ),
                                decoration: BoxDecoration(
                                  color: kDefaultColor,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ));
          }
        },
      ),
    );
  }
}
