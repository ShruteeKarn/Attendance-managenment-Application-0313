// ignore_for_file: use_build_context_synchronously, non_constant_identifier_names, duplicate_ignore

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Role_Student_View/Dashboard/Dashboard.dart';
import '../../model/user_model.dart';
import '../../utils/utils.dart';
import '../../view/login/login_page.dart';
import '../user_view_model.dart';

class SplashServices {
  Future<UserModel> getUserDate() => UserViewModel().getUser();

  // FirebaseAuth auth = FirebaseAuth.instance;
  final user = FirebaseAuth.instance.currentUser;
  late SharedPreferences logindata, checkdata;
  late bool newuser;

  Future<void> check_if_already_login(BuildContext context) async {
    final user = FirebaseAuth.instance.currentUser;
    final logindata = await SharedPreferences.getInstance();
    final newuser = (logindata.getBool('login') ?? true);
    if (kDebugMode) {
      print(newuser);
    }
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
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginPage(),
        ),
      );
    }
  }
}
