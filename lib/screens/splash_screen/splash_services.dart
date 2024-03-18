import 'dart:async';
import 'package:bakeway_app/screens/home_screen/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import '../main_screen/main_screen.dart';
import '../signin_screen/signin_screen.dart';

class SplashServices {
  void isLogin(BuildContext context) async {
    final auth = FirebaseAuth.instance;

    final user = auth.currentUser;
    // await user?.delete();
    // await user?.reload();
    await Permission.location.request();
    Permission.notification.request();

    if (user != null) {
      Timer(
          const Duration(seconds: 3),
          () => Navigator.push(
              context, MaterialPageRoute(builder: (context) => MainScreen())));
    } else {
      Timer(
          const Duration(seconds: 3),
          () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => SignInScreen())));
    }
  }
}
