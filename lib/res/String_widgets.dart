// ignore_for_file: non_constant_identifier_names, file_names

import 'package:flutter/material.dart';

String roomId = "";
String celRoom = "";
String celDescription = "";
String datemonth = "";
String timesamay = "";
String room = "";
String description = "";
String age = "";
String number = "";
String userId = "";
String name = "";
String roomname = "";
String email = "";
String expensename = "";
String date = "";
String contribution = "";
String datectl = "";
String gender = "";
String password = "";
String confirmpassword = "";
late int amount;

final confirmpasswordController = TextEditingController();
final userNameController = TextEditingController();
final passwordController = TextEditingController();
final branchController = TextEditingController();
final facultyController = TextEditingController();
final emailController = TextEditingController();
final userCelDescController = TextEditingController();
final userCelNameController = TextEditingController();
final dateCtl = TextEditingController();
final usertimeinput = TextEditingController();
final userEmailController = TextEditingController();
final userRoomNameController = TextEditingController();
final ContributionNameController = TextEditingController();
final userDescController = TextEditingController();
final userAmountController = TextEditingController();
final expenseNameController = TextEditingController();
final userRoleController = TextEditingController();
final userRoomDescController = TextEditingController();

FocusNode emailFocusNode = FocusNode();
FocusNode passwordFocusNode = FocusNode();
FocusNode titleFocusNode = FocusNode();

clearText() {
  confirmpasswordController.clear();
  userNameController.clear();
  passwordController.clear();
  emailController.clear();
  userCelDescController.clear();
  userCelNameController.clear();
  dateCtl.clear();
  usertimeinput.clear();
  userEmailController.clear();
  userRoomNameController.clear();
  ContributionNameController.clear();
  userDescController.clear();
  userAmountController.clear();
  expenseNameController.clear();
  userRoleController.clear();
  userRoomDescController.clear();
  facultyController.clear();
  branchController.clear();
}
