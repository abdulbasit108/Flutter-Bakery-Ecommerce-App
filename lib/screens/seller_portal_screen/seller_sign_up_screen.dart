import 'dart:ui';

import 'package:bakeway_app/screens/seller_portal_screen/seller_signin_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


import '../../utils/utils.dart';
import '../signin_screen/signin_screen.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:bakeway_app/screens/widget/round_button.dart';

class SellerSignUpScreen extends StatefulWidget {
  const SellerSignUpScreen({Key? key}) : super(key: key);
  @override
  State<SellerSignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SellerSignUpScreen> {
  bool loading = false;
  final _formkey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final bakeryController = TextEditingController();
  final cnicController = TextEditingController();
  final ntnController = TextEditingController();

  FirebaseAuth _auth = FirebaseAuth.instance;
  final fireStore = FirebaseFirestore.instance.collection('bakery');

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    bakeryController.dispose();
    cnicController.dispose();
    ntnController.dispose();
  }

  void signUp() {
    setState(() {
      loading = true;
    });
    _auth
        .createUserWithEmailAndPassword(
            email: emailController.text.toString(),
            password: passwordController.text.toString())
        .then((value) {
      String id = DateTime.now().millisecondsSinceEpoch.toString();
      fireStore.doc(id).set({
        'bakery': bakeryController.text.trim(), // John Doe
        'cnic': cnicController.text.trim(), // Stokes and Sons
        'ntn': ntnController.text.trim(),
        'id': id,
        'email': emailController.text.trim()
      });
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => SellerSignInScreen()));
      setState(() {
        loading = false;
      });
    }).onError((error, stackTrace) {
      setState(() {
        loading = false;
      });
      Utils().toastMessage(error.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            child: Column(children: [
          Container(
            child: Center(
              child: Image.asset("assets/images/logo.jpg"),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                  child: Text(
                "CREATE ACCOUNT",
                style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              )),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20),
            child: Align(
              alignment: Alignment.centerLeft,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Form(
                  key: _formkey,
                  child: Column(
                    children: [
                      TextFormField(
                        keyboardType: TextInputType.text,
                        controller: emailController,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: 'Email',
                          prefixIcon:
                              Icon(FontAwesomeIcons.user, color: Colors.white),
                          filled: true,
                          fillColor: Color(0xFF424242),
                          hintStyle: TextStyle(color: Colors.white),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 6, horizontal: 16),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter Email';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: passwordController,
                        obscureText: true,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: 'Password',
                          prefixIcon: Icon(
                            FontAwesomeIcons.lock,
                            color: Colors.white,
                          ),
                          filled: true,
                          fillColor: Color(0xFF424242),
                          hintStyle: TextStyle(color: Colors.white),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 6, horizontal: 16),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter Password';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.text,
                        controller: bakeryController,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: 'Bakery Name',
                          prefixIcon: Icon(
                            FontAwesomeIcons.shop,
                            color: Colors.white,
                          ),
                          filled: true,
                          fillColor: Color(0xFF424242),
                          hintStyle: TextStyle(color: Colors.white),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 6, horizontal: 16),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter Bakery Name';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.text,
                        controller: cnicController,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: 'Enter CNIC Number',
                          prefixIcon: Icon(
                            FontAwesomeIcons.idCard,
                            color: Colors.white,
                          ),
                          filled: true,
                          fillColor: Color(0xFF424242),
                          hintStyle: TextStyle(color: Colors.white),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 6, horizontal: 16),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter CNIC';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.text,
                        style: TextStyle(color: Colors.white),
                        controller: ntnController,
                        decoration: InputDecoration(
                          hintText: 'Enter NTN Number',
                          prefixIcon: Icon(
                            FontAwesomeIcons.idCard,
                            color: Colors.white,
                          ),
                          filled: true,
                          fillColor: Color(0xFF424242),
                          hintStyle: TextStyle(color: Colors.white),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 6, horizontal: 16),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter NTN ';
                          }
                          return null;
                        },
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                RoundButton(
                  title: 'Sign up',
                  loading: loading,
                  onTap: () {
                    if (_formkey.currentState!.validate()) {
                      signUp();
                    }
                  },
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have an account?"),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SellerSignInScreen()));
                        },
                        child: Text("Login"))
                  ],
                )
              ],
            ),
          ),
        ])));
  }
}