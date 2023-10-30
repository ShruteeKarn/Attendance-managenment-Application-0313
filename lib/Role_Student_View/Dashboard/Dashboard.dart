import 'dart:io';
import 'package:ams/Role_Student_View/screen/academics.dart';
import 'package:flutter/material.dart';

import '../../../res/color.dart';
import '../screen/attendance.dart';
import 'Home.dart';
import 'Setting.dart';

/*import '../../Role_Admin_View/screen/academics.dart';
import '../../Role_Admin_View/screen/attendance.dart';
import 'Home.dart';
import 'Setting.dart';*/

class User_Dashboard extends StatefulWidget {
  const User_Dashboard({Key? key}) : super(key: key);

  @override
  State<User_Dashboard> createState() => _User_DashboardState();
}

class _User_DashboardState extends State<User_Dashboard> {
  int selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  final List<Widget> _pages = [
    const Home(),
    const User_Home(),
    const academics(),
    const User_Setting(),
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        backgroundColor: AppColors.bgColor,
        body: _pages[selectedIndex],
      ),
      onWillPop: () => _onBackpressed(context),
    );
  }
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
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: const Text("No"),
          ),
          TextButton(
            onPressed: () => exit(0),
            child: const Text("Yes"),
          ),
        ],
      );
    },
  );
  return exitApp;
}
