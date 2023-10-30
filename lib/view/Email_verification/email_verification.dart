import 'dart:async';
import 'dart:io';
import '../../res/CustomAppBar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../res/button_widgets.dart';
import '../../utils/utils.dart';
import '../login/login_page.dart';

class VerifyEmailPage extends StatefulWidget {
  const VerifyEmailPage({Key? key}) : super(key: key);

  @override
  State<VerifyEmailPage> createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> {
  bool isEmailVerified = false;
  bool canResentEmail = false;
  final _isLoading = false;
  Timer? timer;

  @override
  void initState() {
    super.initState();

    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;

    if (!isEmailVerified) {
      sendVerificationEmail();

      timer = Timer.periodic(
        const Duration(seconds: 3),
        (_) => checkEmailVerified(),
      );
    }
  }

  Future checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser!.reload();
    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });
    if (isEmailVerified) timer?.cancel();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Future sendVerificationEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();
      setState(() => canResentEmail = false);
      await Future.delayed(const Duration(seconds: 10));
      setState(() => canResentEmail = true);
    } catch (e) {
      Utils.customFlushBar(context, e.toString());
    }
  }

  late SharedPreferences logindata;

  @override
  Widget build(BuildContext context) => isEmailVerified
      ? const LoginPage()
      : WillPopScope(
          child: Scaffold(
            appBar: CustomAppBar(title: 'Verify Email'),
            body: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'A verification email has been sent to your email',
                    style: TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  LoginSignUpButton(
                    Onpressed: canResentEmail ? sendVerificationEmail : null,
                    Display_Name: 'Resent email',
                    Loading: _isLoading,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  LoginSignUpButton(
                    Onpressed: () async {
                      logindata = await SharedPreferences.getInstance();
                      logindata?.clear();
                      // ignore: use_build_context_synchronously
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const LoginPage(),
                        ),
                      );
                    },
                    Display_Name: 'Cancel',
                    Loading: _isLoading,
                  ),
                ],
              ),
            ),
          ),
          onWillPop: () => _onBackpressed(context),
        );
}

//Alert Dialogue
Future<bool> _onBackpressed(BuildContext context) async {
  bool exitApp = await showDialog(
    context: context,
    builder: (BuildContext contex) {
      return AlertDialog(
        content: const Text(
          "Do you want to Exit?",
        ),
        actions: [
          TextButton(
            onPressed: () => exit(0),
            child: const Text("Yes"),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: const Text("No"),
          ),
        ],
      );
    },
  );
  return exitApp;
}
