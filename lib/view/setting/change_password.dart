import '../../res/CustomAppBar.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../res/color.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final _formKey = GlobalKey<FormState>();

  var email = "";

  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  final emailController = TextEditingController();

  // @override
  // void dispose() {
  //   // Clean up the controller when the widget is disposed.
  //   emailController.dispose();
  //   super.dispose();
  // }

  clearTextInput() {
    emailController.clear();
  }

  resetPassword() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.orangeAccent,
          content: Text(
            'Reset password link has been sent in email',
            style: TextStyle(
              fontSize: 18.0,
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
            backgroundColor: Colors.orangeAccent,
            content: Text(
              'No user found for that email.',
              style: TextStyle(
                fontSize: 18.0,
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
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: CustomAppBar(
        title: 'Reset Password',
        leadingOnPressed: () => Navigator.of(context).pop(),
      ),
      body: Container(
        color: AppColors.bgColor,
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
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    // Validate returns true if the form is valid, otherwise false.
                                    if (_formKey.currentState!.validate()) {
                                      setState(() {
                                        email = emailController.text;
                                      });
                                      clearTextInput();
                                      resetPassword();
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: AppColors.buttonTextColor,
                                    backgroundColor:
                                        AppColors.submitbuttonColor,
                                    textStyle: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  child: const Text(
                                    "Send Email",
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                // Row(
                                //   children: [
                                //     ElevatedButton(
                                //       onPressed: () => {
                                //         Navigator.pushAndRemoveUntil(
                                //             context,
                                //             PageRouteBuilder(
                                //               pageBuilder: (context, a, b) =>
                                //               const LoginPage(),
                                //               transitionDuration: const Duration(
                                //                 seconds: 0,
                                //               ),
                                //             ),
                                //                 (route) => false)
                                //       },
                                //       style: ElevatedButton.styleFrom(
                                //         foregroundColor: AppColors.textColor,
                                //         backgroundColor:
                                //         AppColors.submitbuttonColor,
                                //         textStyle: const TextStyle(
                                //           fontWeight: FontWeight.bold,
                                //         ),
                                //       ),
                                //       child: const Text(
                                //         "Login",
                                //       ),
                                //     ),
                                //   ],
                                // ),
                              ],
                            ),
                          ],
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
    );
  }
}
