import 'dart:io';
import 'package:ams/Role_Student_View/Dashboard/Dashboard.dart';

import '../../res/CustomAppBar.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/profile_controller.dart';
import '../../res/color.dart';
import '../../res/icons.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key, required this.userKey}) : super(key: key);

  final String userKey;

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  // final ref = FirebaseDatabase.instance.ref().child('Users');
  bool _status = true;
  final FocusNode myFocusNode = FocusNode();

  final _formKey = GlobalKey<FormState>();

  late DatabaseReference ref;

  var name = "";
  var age = "";
  var email = "";
  var number = "";

  final userNameController = TextEditingController();
  final userAgeController = TextEditingController();
  final userEmailController = TextEditingController();
  final userNumberController = TextEditingController();
  final userGenderController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ref = FirebaseDatabase.instance.ref().child('Users');
    getUserssData();
  }

  void getUserssData() async {
    DataSnapshot snapshot = await ref.child(widget.userKey).get();

    Map user = snapshot.value as Map;

    userNameController.text = user['u_name'];
    userAgeController.text = user['age'];
    userEmailController.text = user['email'];
    userNumberController.text = user['number'];
    userGenderController.text = user['gender'];
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    myFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      resizeToAvoidBottomInset: false,
      appBar: CustomAppBar(
        title: 'Profile',
        leadingOnPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const User_Dashboard(),
          ),
        ),
      ),
      body: ChangeNotifierProvider(
        create: (_) => ProfileController(),
        child: Consumer<ProfileController>(
          builder: (context, provider, child) {
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                ),
                child: StreamBuilder(
                  stream: ref
                      .child(
                        FirebaseAuth.instance.currentUser!.uid.toString(),
                      )
                      .onValue,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasData) {
                      Map<dynamic, dynamic>? map =
                          snapshot.data!.snapshot.value as Map?;

                      return Column(
                        children: [
                          const SizedBox(
                            height: 30,
                          ),
                          Stack(
                            alignment: Alignment.bottomCenter,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 10,
                                ),
                                child: Center(
                                  child: Container(
                                    height: 130,
                                    width: 130,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: AppColors.appbarColor,
                                        width: 2,
                                      ),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(
                                        100,
                                      ),
                                      child: provider.image == null
                                          ? map!['u_img'].toString() == ""
                                              ? const Icon(
                                                  AppIcons.user_name,
                                                  size: 35,
                                                )
                                              : Image(
                                                  fit: BoxFit.cover,
                                                  image: NetworkImage(
                                                    map['u_img'],
                                                  ),
                                                  loadingBuilder: (context,
                                                      child, loadingProgess) {
                                                    if (loadingProgess ==
                                                        null) {
                                                      return child;
                                                    }
                                                    return const Center(
                                                      child:
                                                          CircularProgressIndicator(),
                                                    );
                                                  },
                                                )
                                          : Stack(
                                              children: [
                                                Image.file(
                                                  File(provider.image!.path)
                                                      .absolute,
                                                ),
                                                const Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                ),
                                              ],
                                            ),
                                    ),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  provider.pickImage(context);
                                },
                                child: const CircleAvatar(
                                  radius: 14,
                                  backgroundColor: AppColors.dividerColor,
                                  child: Icon(
                                    Icons.add,
                                    size: 18,
                                    color: AppColors.whiteColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                bottom: 25.0,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 25.0,
                                      right: 25.0,
                                      top: 25.0,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      mainAxisSize: MainAxisSize.max,
                                      children: <Widget>[
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: const <Widget>[
                                            Text(
                                              'Personal Information',
                                              style: TextStyle(
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            _status
                                                ? _getEditIcon()
                                                : Container(),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  // Padding(
                                  //   padding: const EdgeInsets.only(
                                  //     left: 25.0,
                                  //     right: 25.0,
                                  //     top: 25.0,
                                  //   ),
                                  //   child: Row(
                                  //     mainAxisSize: MainAxisSize.max,
                                  //     children: <Widget>[
                                  //       Column(
                                  //         mainAxisAlignment:
                                  //             MainAxisAlignment.start,
                                  //         mainAxisSize: MainAxisSize.min,
                                  //         children: const <Widget>[
                                  //           Text(
                                  //             'Name',
                                  //             style: TextStyle(
                                  //               fontSize: 16.0,
                                  //               fontWeight: FontWeight.bold,
                                  //             ),
                                  //           ),
                                  //         ],
                                  //       ),
                                  //     ],
                                  //   ),
                                  // ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 25.0,
                                      right: 25.0,
                                      top: 2.0,
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        TextFormField(
                                          autovalidateMode: AutovalidateMode
                                              .onUserInteraction,
                                          controller: userNameController,
                                          keyboardType: TextInputType.text,
                                          decoration: const InputDecoration(
                                            border: OutlineInputBorder(),
                                            labelText: "Name",
                                            hintText: "Enter Your Name",
                                            prefixIcon: Icon(
                                              AppIcons.user_name,
                                            ),
                                          ),
                                          validator: (value) {
                                            RegExp nonWhitespaceRegExp =
                                                RegExp(r'\S');
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Please enter your name';
                                            }
                                            if (!nonWhitespaceRegExp
                                                .hasMatch(value)) {
                                              return 'Not valid format';
                                            }
                                            if (value.length > 50) {
                                              return 'Name should be less than 50 Characters';
                                            }
                                            return null;
                                          },
                                          enabled: !_status,
                                          autofocus: !_status,
                                        ),
                                      ],
                                    ),
                                  ),
                                  // Padding(
                                  //   padding: const EdgeInsets.only(
                                  //     left: 25.0,
                                  //     right: 25.0,
                                  //     top: 25.0,
                                  //   ),
                                  //   child: Row(
                                  //     mainAxisSize: MainAxisSize.max,
                                  //     children: [
                                  //       Column(
                                  //         mainAxisAlignment:
                                  //             MainAxisAlignment.start,
                                  //         mainAxisSize: MainAxisSize.min,
                                  //         children: const [
                                  //           Text(
                                  //             'Email ID',
                                  //             style: TextStyle(
                                  //               fontSize: 16.0,
                                  //               fontWeight: FontWeight.bold,
                                  //             ),
                                  //           ),
                                  //         ],
                                  //       ),
                                  //     ],
                                  //   ),
                                  // ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 25.0,
                                      right: 25.0,
                                      top: 2.0,
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        TextFormField(
                                          autovalidateMode: AutovalidateMode
                                              .onUserInteraction,
                                          controller: userEmailController,
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          decoration: const InputDecoration(
                                            border: OutlineInputBorder(),
                                            labelText: 'Email ID',
                                            enabled: false,
                                            hintText: "Enter Email ID",
                                            prefixIcon: Icon(
                                              AppIcons.user_mail,
                                            ),
                                          ),
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'No user for this email';
                                            } else if (!EmailValidator.validate(
                                                value)) {
                                              return ' Enter Valid Email';
                                            }
                                            return null;
                                          },
                                          enabled: false,
                                        ),
                                      ],
                                    ),
                                  ),
                                  // Padding(
                                  //   padding: const EdgeInsets.only(
                                  //     left: 25.0,
                                  //     right: 25.0,
                                  //     top: 25.0,
                                  //   ),
                                  //   child: Row(
                                  //     mainAxisSize: MainAxisSize.max,
                                  //     children: <Widget>[
                                  //       Column(
                                  //         mainAxisAlignment:
                                  //             MainAxisAlignment.start,
                                  //         mainAxisSize: MainAxisSize.min,
                                  //         children: const [
                                  //           Text(
                                  //             'Mobile',
                                  //             style: TextStyle(
                                  //               fontSize: 16.0,
                                  //               fontWeight: FontWeight.bold,
                                  //             ),
                                  //           ),
                                  //         ],
                                  //       ),
                                  //     ],
                                  //   ),
                                  // ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 25.0,
                                      right: 25.0,
                                      top: 2.0,
                                    ),
                                    child: SingleChildScrollView(
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          SingleChildScrollView(
                                            child: TextFormField(
                                              autovalidateMode: AutovalidateMode
                                                  .onUserInteraction,
                                              controller: userNumberController,
                                              keyboardType: TextInputType.phone,
                                              decoration: const InputDecoration(
                                                border: OutlineInputBorder(),
                                                labelText: 'Mobile',
                                                hintText: "Enter Mobile Number",
                                                prefixIcon: Icon(
                                                  AppIcons.phone_number,
                                                ),
                                              ),
                                              validator: (value) {
                                                RegExp digitRegExp =
                                                    RegExp(r'\d');
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return 'Number can not be empty';
                                                }
                                                if (!digitRegExp
                                                    .hasMatch(value)) {
                                                  return 'No valid format';
                                                }
                                                if (value.length > 10) {
                                                  return 'Maximum limit 10 digits';
                                                }

                                                return null;
                                              },
                                              enabled: !_status,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 25.0,
                                      right: 25.0,
                                      top: 25.0,
                                    ),
                                    child: SingleChildScrollView(
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: const [
                                          Expanded(
                                            flex: 2,
                                            child: Text(
                                              'Age',
                                              style: TextStyle(
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Text(
                                              'Gender',
                                              style: TextStyle(
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 25.0,
                                      right: 25.0,
                                      top: 2.0,
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        Flexible(
                                          flex: 2,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                              right: 10.0,
                                            ),
                                            child: SingleChildScrollView(
                                              child: TextFormField(
                                                autovalidateMode:
                                                    AutovalidateMode
                                                        .onUserInteraction,
                                                controller: userAgeController,
                                                keyboardType:
                                                    TextInputType.number,
                                                decoration:
                                                    const InputDecoration(
                                                  border: OutlineInputBorder(),
                                                  labelText: "Age",
                                                  hintText: "Enter Age",
                                                  prefixIcon: Icon(
                                                    AppIcons.user_age,
                                                  ),
                                                ),
                                                validator: (value) {
                                                  RegExp digitRegExp =
                                                      RegExp(r'\d');
                                                  if (value == null ||
                                                      value.isEmpty) {
                                                    return 'Enter your age';
                                                  }
                                                  if (!digitRegExp
                                                      .hasMatch(value)) {
                                                    return 'No valid format';
                                                  }
                                                  if (value.length > 2) {
                                                    return 'Enter valid age';
                                                  }
                                                  return null;
                                                },
                                                enabled: !_status,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Flexible(
                                          flex: 2,
                                          child: SingleChildScrollView(
                                            child: TextFormField(
                                              autovalidateMode: AutovalidateMode
                                                  .onUserInteraction,
                                              controller: userGenderController,
                                              keyboardType: TextInputType.text,
                                              decoration: const InputDecoration(
                                                border: OutlineInputBorder(),
                                                labelText: "Gender",
                                                hintText: "Enter Gender",
                                                prefixIcon: Icon(
                                                  AppIcons.user_gender,
                                                ),
                                              ),
                                              validator: (value) {
                                                RegExp nonWhitespaceRegExp =
                                                    RegExp(r'\S');
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return 'Enter your age';
                                                }
                                                if (!nonWhitespaceRegExp
                                                    .hasMatch(value)) {
                                                  return "Not valid format";
                                                }
                                                if (value.length > 6) {
                                                  return 'Enter valid characters';
                                                }
                                                return null;
                                              },
                                              enabled: !_status,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  !_status ? _getActionButtons() : Container(),
                                ],
                              ),
                            ),
                          )
                        ],
                      );
                    } else {
                      return const Center(
                        child: Text(
                          "Something went wrong",
                        ),
                      );
                    }
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _getActionButtons() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(
          left: 25.0,
          right: 25.0,
          top: 45.0,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.only(
                  right: 10.0,
                ),
                child: ElevatedButton(
                  onPressed: () {
                    setState(
                      () {
                        _status = true;
                        FocusScope.of(context).requestFocus(
                          FocusNode(),
                        );
                      },
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        20.0,
                      ),
                    ),
                  ),
                  child: const Text(
                    "Save",
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 10.0,
                ),
                child: ElevatedButton(
                  onPressed: () {
                    setState(
                      () {
                        _status = true;
                        FocusScope.of(context).requestFocus(
                          FocusNode(),
                        );
                      },
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        20.0,
                      ),
                    ),
                  ),
                  child: const Text(
                    "Cancel",
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getEditIcon() {
    return SingleChildScrollView(
      child: GestureDetector(
        child: const CircleAvatar(
          backgroundColor: Colors.red,
          radius: 14.0,
          child: Icon(
            Icons.edit,
            color: Colors.white,
            size: 16.0,
          ),
        ),
        onTap: () {
          setState(
            () {
              _status = false;
            },
          );
        },
      ),
    );
  }

  void dbadduser() {
    Map<String, String> user = {
      'u_name': userNameController.text,
      'age': userAgeController.text,
      'email': userEmailController.text,
      'number': userNumberController.text,
      'gender': userGenderController.text
    };
    if (_formKey.currentState!.validate()) {
      setState(
        () {
          name = userNameController.text;
          age = userAgeController.text;
          email = userEmailController.text;
          number = userNumberController.text;
        },
      );
      ref.child(widget.userKey).update(user).then((value) => {
            Navigator.pop(context),
          });
    }
  }
}
