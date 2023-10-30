import 'dart:io';

import 'package:flutter/material.dart';

import '../../res/color.dart';
import 'signup_page_left_side.dart';

class SignUp extends StatelessWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/signupbg.jpeg"),
                  fit: BoxFit.cover,),),
          child: Center(
            child: SingleChildScrollView(
              child: Container(
                height: 650,
                width: 640,
                margin: const EdgeInsets.symmetric(
                  horizontal: 24,
                ),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    24,
                  ),
                  color: AppColors.whiteColor.withOpacity(0.5),
                ),
                child: const Row(
                  children: [
                    SignUpPageLeftSide(),
                  ],
                ),
              ),
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
            child: const Text("No"),
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
