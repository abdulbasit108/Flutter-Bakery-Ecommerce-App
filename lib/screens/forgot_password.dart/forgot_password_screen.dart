import 'package:bakeway_app/constants/color_constants/color_constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../utils/utils.dart';
import '../widget/round_button.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final emailController = TextEditingController();
  final auth = FirebaseAuth.instance;
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: kDefaultColor,
        title: Text('Forgot Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              child: Center(
                child: Image.asset("assets/images/logo.jpg"),
              ),
            ),
            Form(
              key: _formkey,
              child: TextFormField(
                controller: emailController,
                decoration: InputDecoration(hintText: 'Email'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Enter Email';
                  }
                  return null;
                },
              ),
            ),
            SizedBox(
              height: 40,
            ),
            RoundButton(
                title: 'Forgot',
                onTap: () {
                  if (_formkey.currentState!.validate()) {
                    auth
                        .sendPasswordResetEmail(
                            email: emailController.text.toString())
                        .then((value) {
                      Utils().toastMessage(
                          'We have sent you email to recover password, please check email');
                    }).onError((error, stackTrace) {
                      Utils().toastMessage(error.toString());
                    });
                  }
                })
          ],
        ),
      ),
    );
  }
}
