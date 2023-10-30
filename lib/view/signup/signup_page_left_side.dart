// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../res/String_widgets.dart';
import '../../res/button_widgets.dart';
import '../../res/color.dart';
import '../../res/icons.dart';
import '../../utils/utils.dart';
import '../Email_verification/email_verification.dart';
import '../login/login_page.dart';

class SignUpPageLeftSide extends StatefulWidget {
  const SignUpPageLeftSide({Key? key}) : super(key: key);

  @override
  State<SignUpPageLeftSide> createState() => _SignUpPageLeftSideState();
}

class _SignUpPageLeftSideState extends State<SignUpPageLeftSide> {
  final _formKey = GlobalKey<FormState>();

  var role_mode = "wEXDVTBPg0Fe9Hh4Oywu";
  final ValueNotifier<bool> obsecurePassword = ValueNotifier<bool>(true);
  final ValueNotifier<bool> obsecurePassword2 = ValueNotifier<bool>(true);

  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  FocusNode confirmpasswordFocusNode = FocusNode();
  FocusNode usernameFocusNode = FocusNode();

  bool _isLoading = false;
  DatabaseReference ref = FirebaseDatabase.instance.ref().child('Users');
  final dbRef = FirebaseFirestore.instance.collection('Users');
  final users = FirebaseAuth.instance.currentUser;

  void clearTextField() {
    emailController.clear();
    passwordController.clear();
    confirmpasswordController.clear();
    userNameController.clear();
    branchController.clear();
    facultyController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.only(
            left: 25.0,
            right: 25.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Image.asset(
                    'assets/images/gateway.png',
                    width: 70,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Text(
                    "Sign Up",
                    style: TextStyle(
                      fontSize: 28,
                      color: AppColors.loginBtnColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.all(
                  10,
                ),
              ),
              const Text(
                "Please Sign Up to create your account!",
                style: TextStyle(fontSize: 14, color: Colors.black),
              ),
              const Padding(
                padding: EdgeInsets.all(
                  10,
                ),
              ),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                autofocus: false,
                controller: branchController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelStyle: TextStyle(
                    fontSize: 17.0,
                  ),
                  errorStyle: TextStyle(
                    color: AppColors.alertColor,
                    fontSize: 15,
                  ),
                  labelText: 'Branch',
                  hintText: 'Enter your branch',
                  prefixIcon: Icon(
                    AppIcons.branchname,
                  ),
                ),
                validator: (value) {
                  RegExp nonWhitespaceRegExp = RegExp(r'\S');
                  if (value == null || value.isEmpty) {
                    return 'Please enter your branch';
                  }
                  if (!nonWhitespaceRegExp.hasMatch(value)) {
                    return 'Not valid format';
                  }
                  if (value.length > 50) {
                    return 'Branch should be less than 50 Characters';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                autofocus: false,
                controller: facultyController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelStyle: TextStyle(
                    fontSize: 17.0,
                  ),
                  errorStyle: TextStyle(
                    color: AppColors.alertColor,
                    fontSize: 15,
                  ),
                  labelText: 'Faculty',
                  hintText: 'Enter your faculty',
                  prefixIcon: Icon(
                    AppIcons.facultyname,
                  ),
                ),
                validator: (value) {
                  RegExp nonWhitespaceRegExp = RegExp(r'\S');
                  if (value == null || value.isEmpty) {
                    return 'Please enter your faculty';
                  }
                  if (!nonWhitespaceRegExp.hasMatch(value)) {
                    return 'Not valid format';
                  }
                  if (value.length > 50) {
                    return 'Faculty should be less than 50 Characters';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                autofocus: false,
                controller: userNameController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelStyle: TextStyle(
                    fontSize: 17.0,
                  ),
                  errorStyle: TextStyle(
                    color: AppColors.alertColor,
                    fontSize: 15,
                  ),
                  labelText: 'Name',
                  hintText: 'Enter your name',
                  prefixIcon: Icon(
                    AppIcons.user_name,
                  ),
                ),
                validator: (value) {
                  RegExp nonWhitespaceRegExp = RegExp(r'\S');
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  if (!nonWhitespaceRegExp.hasMatch(value)) {
                    return 'Not valid format';
                  }
                  if (value.length > 50) {
                    return 'Name should be less than 50 Characters';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                autofocus: false,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  hintText: 'Enter your mail',
                  prefixIcon: Icon(
                    AppIcons.user_mail,
                  ),
                  border: OutlineInputBorder(),
                  labelStyle: TextStyle(
                    fontSize: 17.0,
                  ),
                  errorStyle: TextStyle(
                    color: AppColors.alertColor,
                    fontSize: 15,
                  ),
                ),
                controller: emailController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'No user for this email';
                  } else if (!EmailValidator.validate(value)) {
                    return ' Enter Valid Email';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              ValueListenableBuilder(
                valueListenable: obsecurePassword,
                builder: (context, value, child) {
                  return TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: passwordController,
                    obscureText: obsecurePassword.value,
                    focusNode: passwordFocusNode,
                    obscuringCharacter: "*",
                    decoration: InputDecoration(
                      labelText: 'Create Password',
                      hintText: 'Create your password',
                      prefixIcon: const Icon(
                        Icons.lock_open_outlined,
                      ),
                      border: const OutlineInputBorder(),
                      errorStyle: const TextStyle(
                        color: AppColors.alertColor,
                        fontSize: 15,
                      ),
                      suffixIcon: InkWell(
                        onTap: () {
                          obsecurePassword.value = !obsecurePassword.value;
                        },
                        child: Icon(
                          obsecurePassword.value
                              ? Icons.visibility_off_outlined
                              : Icons.visibility,
                        ),
                      ),
                    ),
                    validator: (value) {
                      RegExp regex = RegExp(
                        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?\d)(?=.*?[!@#&*~]).{6,}$',
                      );
                      if (value == null || value.isEmpty) {
                        return 'Enter your password';
                      }
                      if (!regex.hasMatch(value)) {
                        return "Password must be minimum\n"
                            "6 character and at least\n1 Upper Case,\n1 Lower Case,\n1 Digit,\n1 Special Character";
                      }
                      return null;
                    },
                  );
                },
              ),
              const SizedBox(
                height: 10,
              ),
              ValueListenableBuilder(
                valueListenable: obsecurePassword2,
                builder: (context, value, child) {
                  return TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: confirmpasswordController,
                    obscureText: obsecurePassword2.value,
                    focusNode: confirmpasswordFocusNode,
                    obscuringCharacter: "*",
                    decoration: InputDecoration(
                      labelText: 'Confirm Password',
                      hintText: 'Re-enter your password',
                      prefixIcon: const Icon(
                        Icons.lock_open_outlined,
                      ),
                      border: const OutlineInputBorder(),
                      errorStyle: const TextStyle(
                        color: AppColors.alertColor,
                        fontSize: 15,
                      ),
                      suffixIcon: InkWell(
                        onTap: () {
                          obsecurePassword2.value = !obsecurePassword2.value;
                        },
                        child: Icon(
                          obsecurePassword2.value
                              ? Icons.visibility_off_outlined
                              : Icons.visibility,
                        ),
                      ),
                    ),
                    validator: (value) {
                      RegExp regex = RegExp(
                        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?\d)(?=.*?[!@#&*~]).{6,}$',
                      );
                      if (value == null || value.isEmpty) {
                        return 'Enter your password';
                      }
                      if (value != passwordController.text) {
                        return 'Passwords do not match';
                      }
                      if (!regex.hasMatch(value)) {
                        return "Password must be minimum\n"
                            "6 character and at least\n1 Upper Case,\n1 Lower Case,\n1 Digit,\n1 Special Character";
                      }
                      return null;
                    },
                  );
                },
              ),
              const SizedBox(
                height: 15,
              ),
              LoginSignUpButton(
                  Onpressed: () async {
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        email = emailController.text;
                        password = passwordController.text;
                        confirmpassword = confirmpasswordController.text;
                        name = userNameController.text;
                      });
                      UserSignUp();
                    }
                  },
                  Display_Name: "Sign Up",
                  Loading: _isLoading),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  const Text('Already have account ?'),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginPage(),
                        ),
                      );
                    },
                    child: const Text(
                      "Login",
                      style: TextStyle(
                        color: AppColors.loginBtnColor,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  UserSignUp() async {
    setState(() {
      _isLoading = true;
    });
    final signInMethods =
        await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);
    if (signInMethods.isNotEmpty) {
      // User already exists
      Utils.customFlushBar(context, 'Email already exists');
      setState(() {
        _isLoading = false;
      });
      return;
    }
    try {
      final authResult = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      String userId = authResult.user!.uid.toString();

      // Upload static image from assets to Firebase Storage
      ByteData imageData =
          await rootBundle.load('assets/images/person_icon.png');
      Uint8List bytes = imageData.buffer.asUint8List();
      Reference storageReference = FirebaseStorage.instance
          .ref()
          .child('u-img$userId'); // Customize the image URL
      UploadTask uploadTask = storageReference.putData(
        bytes,
        SettableMetadata(contentType: 'image/jpeg'), // Specify the content type
      );

      // Get the image URL after uploading
      String imageUrl = await (await uploadTask).ref.getDownloadURL();
      ref
          .child(userId)
          .set({
            'uid': userId,
            'u_name': name.toString(),
            'email': authResult.user!.email.toString(),
            'age': '',
            'number': '',
            'gender': 'Male',
            'u_img': '',
            'branch': '',
            'faculty': '',
          })
          .then((value) {})
          .onError(
            (error, stackTrace) {
              if (kDebugMode) {
                print("Error ${error.toString()}");
              }
            },
          );

      dbRef
          .doc(userId)
          .set({
            'uid': userId,
            'u_name': name.toString(),
            'email': authResult.user!.email.toString(),
            'role_id': role_mode,
            'u_img': '',
            'age': '',
            'number': '',
            'gender': 'Male',
            'branch': '',
            'faculty': '',
          })
          .then((value) {})
          .onError((error, stackTrace) {
            Utils.customFlushBar(context, error.toString());
          });
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const VerifyEmailPage(),
        ),
      );
      setState(
        () {
          _isLoading = false;
          clearTextField();
        },
      );
    } catch (error) {
      if (kDebugMode) {
        print("Error ${error.toString()}");
      }
      Utils.customFlushBar(context, error.toString());
    }
  }
}
