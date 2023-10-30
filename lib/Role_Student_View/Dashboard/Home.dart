import 'dart:io' show exit;
import '../../../res/CustomAppBar.dart';
import 'package:flutter/material.dart';
import '../../../res/color.dart';
import '../screen/timeTable.dart';

class User_Home extends StatefulWidget {
  const User_Home({Key? key}) : super(key: key);

  @override
  State<User_Home> createState() => _User_HomeState();
}

class _User_HomeState extends State<User_Home> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        backgroundColor: AppColors.bgColor,
        appBar: CustomAppBar(
          title: 'Time Table',
        ),
        body: const timeTable(),
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
