import 'dart:io';

import '../../res/CustomAppBar.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../res/button_widgets.dart';
import '../res/String_widgets.dart';
import '../res/color.dart';
import 'login/login_page.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _formKey = GlobalKey<FormState>();

  final _isLoading = false;

  clearTextInput() {
    emailController.clear();
  }

  resetPassword() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: AppColors.appbarColor,
          content: Text(
            'Reset password link has been sent in email',
            style: TextStyle(
              fontSize: 18.0,
              color: AppColors.appbartextColor,
            ),
          ),
        ),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        if (kDebugMode) {
          print(
            'No user found for that email.',
          );
        }
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: AppColors.appbarColor,
            content: Text(
              'No user found for that email.',
              style: TextStyle(
                fontSize: 18.0,
                color: AppColors.appbartextColor,
              ),
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width * .9;
    return WillPopScope(
      child: Scaffold(
        backgroundColor: AppColors.bgColor,
        appBar: CustomAppBar(title: 'Reset Password'),
        body: Container(
          alignment: Alignment.center,
          child: SizedBox(
            width: width * .98,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.all(
                    10,
                  ),
                ),
                const Text(
                  'Reset password link will be sent to your email!',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: Form(
                    key: _formKey,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 20,
                        horizontal: 30,
                      ),
                      child: ListView(
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(
                              vertical: 10.0,
                            ),
                            child: TextFormField(
                              autofocus: false,
                              decoration: const InputDecoration(
                                labelText: 'Email',
                                labelStyle: TextStyle(
                                  fontSize: 20.0,
                                ),
                                border: OutlineInputBorder(),
                                errorStyle: TextStyle(
                                  color: Colors.redAccent,
                                  fontSize: 15,
                                ),
                              ),
                              controller: emailController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Enter your email';
                                } else if (!EmailValidator.validate(value)) {
                                  return ' Enter Valid Email';
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            width: width,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                SizedBox(
                                  width: width * .4,
                                  child: LoginSignUpButton(
                                    Onpressed: () {
                                      // Validate returns true if the form is valid, otherwise false.
                                      if (_formKey.currentState!.validate()) {
                                        setState(() {
                                          email = emailController.text;
                                        });
                                        resetPassword();
                                        clearTextInput();
                                      }
                                    },
                                    Display_Name: "Send Email",
                                    Loading: _isLoading,
                                  ),
                                ),
                                const Padding(
                                  padding: EdgeInsets.only(
                                    left: 1.0,
                                    right: 1.0,
                                  ),
                                ),
                                SizedBox(
                                  width: width * .4,
                                  child: LoginSignUpButton(
                                    Onpressed: () {
                                      Navigator.pushAndRemoveUntil(
                                          context,
                                          PageRouteBuilder(
                                            pageBuilder: (context, a, b) =>
                                                const LoginPage(),
                                            transitionDuration: const Duration(
                                              seconds: 0,
                                            ),
                                          ),
                                          (route) => false);
                                    },
                                    Display_Name: "Login",
                                    Loading: _isLoading,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      onWillPop: () => _onBackpressed(context),
    );
  }
}

//Alert Dialogue
Future<bool> _onBackpressed(BuildContext context) async {
  bool exitApp = await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: const Text(
          "Do you want to Exit?",
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: const Text(
              "No",
            ),
          ),
          TextButton(
            onPressed: () => exit(0),
            child: const Text(
              "Yes",
            ),
          ),
        ],
      );
    },
  );
  return exitApp;
}
