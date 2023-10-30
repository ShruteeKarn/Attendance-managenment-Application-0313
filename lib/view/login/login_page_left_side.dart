// ignore_for_file: use_build_context_synchronously, non_constant_identifier_names, prefer_typing_uninitialized_variables, duplicate_ignore

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Role_Student_View/Dashboard/Dashboard.dart';
import '../../res/String_widgets.dart';
import '../../res/button_widgets.dart';
import '../../res/color.dart';
import '../../res/icons.dart';
import '../../utils/routes/routes_name.dart';
import '../../utils/utils.dart';
import '../Email_verification/email_verification.dart';
import '../signup/signup_view.dart';

class LoginPageLeftSide extends StatefulWidget {
  const LoginPageLeftSide({Key? key}) : super(key: key);

  @override
  State<LoginPageLeftSide> createState() => _LoginPageLeftSideState();
}

class _LoginPageLeftSideState extends State<LoginPageLeftSide> {
  final _formKey = GlobalKey<FormState>();

  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  final ValueNotifier<bool> obsecurePassword = ValueNotifier<bool>(true);

  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();

  late SharedPreferences logindata, checkdata;
  late bool newuser;
  var roleName;

  var rolePermission;
  var roleId;

  bool _isLoading = false;
  DatabaseReference dbRef = FirebaseDatabase.instance.ref().child('Users');
  late final DatabaseEvent REF;
  var CurrentUserId;

  final users = FirebaseAuth.instance.currentUser;

  void clearTextField() {
    emailController.clear();
    passwordController.clear();
  }

  userLogin() async {
    setState(() {
      _isLoading = true;
    });
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      // ignore: use_build_context_synchronously
      logindata.setBool('login', false);

      if (FirebaseAuth.instance.currentUser!.emailVerified) {
        await check_if_already_login();
      } else {
        // ignore: use_build_context_synchronously
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const VerifyEmailPage(),
          ),
        );
      }
      if (mounted) {
        setState(() {
          _isLoading = false;
          clearTextField();
        });
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        if (kDebugMode) {
          print("No User Found for that Email");
        }
        setState(() {
          _isLoading = false;
        });
        Utils.customFlushBar(context, 'No user for that email.');
      } else if (e.code == 'wrong-password') {
        if (kDebugMode) {
          print("Wrong Password Provided by User");
        }
        setState(() {
          _isLoading = false;
        });
        Utils.customFlushBar(context, 'Password did not match.');
      }
    }
  }

  @override
  void initState() {
    super.initState();
    check_if_already_login();
  }

  Future<void> check_if_already_login() async {
    final user = FirebaseAuth.instance.currentUser;
    logindata = await SharedPreferences.getInstance();
    newuser = (logindata.getBool('login') ?? true);

    if (newuser == false) {
      if (user != null) {
        final userId = user.uid;
        final userRef =
            FirebaseFirestore.instance.collection('Users').doc(userId);
        final userSnapshot = await userRef.get();
        if (userSnapshot.exists) {
          final roleId = userSnapshot.get('role_id') as String?;
          final roleRef =
              FirebaseFirestore.instance.collection('Role').doc(roleId);
          final roleSnapshot = await roleRef.get();
          if (roleSnapshot.exists) {
            final role = roleSnapshot.data()!;
            final roleName = role['role'];
            if (roleName == 'Faculty') {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const User_Dashboard(),
                ),
              );
            } else {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const User_Dashboard(),
                ),
              );
            }
          } else {
            Utils.customFlushBar(context, 'Role not found.');
          }
        } else {
          Utils.customFlushBar(context, 'User not found.');
        }
      }
    }
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
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Image.asset(
                    'assets/images/gateway.png',
                    width: 60,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Text(
                    "Login",
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
                  24,
                ),
              ),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                autofocus: false,
                cursorColor: AppColors.focusedColor,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  hintText: 'Enter your mail',
                  prefixIcon: Icon(
                    AppIcons.user_mail,
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColors.focusedColor,
                    ),
                  ),
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
                    return 'Enter your email';
                  } else if (!EmailValidator.validate(value)) {
                    return ' Enter Valid Email';
                  }
                  return null;
                },
              ),
              const Padding(
                padding: EdgeInsets.all(
                  17,
                ),
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
                      labelText: 'Password',
                      hintText: 'Enter your password',
                      prefixIcon: const Icon(
                        Icons.lock_open_outlined,
                      ),
                      border: const OutlineInputBorder(),
                      focusColor: AppColors.focusedColor,
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
                      if (value == null || value.isEmpty) {
                        return 'Enter your password';
                      }
                      return null;
                    },
                  );
                },
              ),
              const Padding(
                padding: EdgeInsets.all(
                  8,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: MaterialButton(
                      child: const Text(
                        "Sign up",
                        style: TextStyle(
                          color: AppColors.loginBtnColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignUp(),
                          ),
                        );
                      },
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: MaterialButton(
                      child: const Text(
                        "Forget password?",
                        style: TextStyle(
                          color: AppColors.loginBtnColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          RoutesName.forgotpassword,
                        );
                      },
                    ),
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.all(
                  15,
                ),
              ),
              LoginSignUpButton(
                Onpressed: () async {
                  if (_formKey.currentState!.validate()) {
                    setState(() {
                      email = emailController.text;
                      password = passwordController.text;
                      _isLoading = true;
                    });
                    userLogin();
                  }
                },
                Display_Name: "Login",
                Loading: _isLoading,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
