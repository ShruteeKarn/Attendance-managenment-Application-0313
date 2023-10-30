// ignore_for_file: camel_case_types

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../res/CustomAppBar.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../res/color.dart';
import '../../controllers/profile_controller.dart';
import '../../res/icons.dart';
import '../Dashboard/Dashboard.dart';

class User_UserProfile extends StatefulWidget {
  const User_UserProfile({Key? key}) : super(key: key);

  @override
  State<User_UserProfile> createState() => _User_UserProfileState();
}

class _User_UserProfileState extends State<User_UserProfile> {
  bool _status = true;
  bool _isFavorite = false;
  final FocusNode myFocusNode = FocusNode();
  ScrollController scrollController = ScrollController();

  // late DatabaseReference ref;

  _User_UserProfileState() {
    selectedgender = genderList[0];
  }

  bool isEditable = false; // true-disable,false-enable

  final genderList = ["Male", "Female", "Transgender"];
  String? selectedgender = "";
  final _formKey = GlobalKey<FormState>();
  var name = "";
  var age = "";
  var email = "";
  var number = "";

  final userNameController = TextEditingController();
  final userAgeController = TextEditingController();
  final userEmailController = TextEditingController();
  final userNumberController = TextEditingController();
  final userGenderController = TextEditingController();

  final userNameFocusNode = FocusNode();
  final userAgeFocusNode = FocusNode();
  final userEmailFocusNode = FocusNode();
  final userNumberFocusNode = FocusNode();
  final userGenderFocusNode = FocusNode();
  bool enableDropdown = false;
  late DocumentReference ref;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // ref = FirebaseDatabase.instance.ref().child('Users');
    ref = usersCollection.doc(FirebaseAuth.instance.currentUser!.uid);
    getUserssData();
    _toggleFavorite();
  }

  void _toggleFavorite() {
    setState(() {
      _isFavorite = !_isFavorite;
    });
  }

  final dbref = FirebaseFirestore.instance.collection('Users');
  CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('Users');

  void getUserssData() async {
    DocumentSnapshot snapshot = await ref.get();
    Map<String, dynamic> user = snapshot.data() as Map<String, dynamic>;
    userNameController.text = user['u_name'];
    userAgeController.text = user['age'];
    userEmailController.text = user['email'];
    userNumberController.text = user['number'];
    userGenderController.text = user['gender'];
    setState(() {
      selectedgender = user['gender'];
    });
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
      body: Form(
        key: _formKey,
        child: ChangeNotifierProvider(
          create: (_) => ProfileController(),
          child: Consumer<ProfileController>(
            builder: (context, provider, child) {
              return SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                  ),
                  child: StreamBuilder(
                    stream: ref.snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (snapshot.hasData) {
                        Map<String, dynamic>? map =
                            snapshot.data!.data() as Map<String, dynamic>?;

                        return SingleChildScrollView(
                          child: Column(
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
                                      child: GestureDetector(
                                        onTap: () {
                                          provider.showImage(
                                              context, map!['u_img']);
                                        },
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
                                                    : Image.network(
                                                        map['u_img'],
                                                        // Replace this with the URL of the image
                                                        fit: BoxFit.cover,
                                                        loadingBuilder:
                                                            (BuildContext
                                                                    context,
                                                                Widget child,
                                                                ImageChunkEvent?
                                                                    loadingProgress) {
                                                          if (loadingProgress ==
                                                              null) {
                                                            return child;
                                                          } else {
                                                            return Center(
                                                              child:
                                                                  CircularProgressIndicator(
                                                                value: loadingProgress
                                                                            .expectedTotalBytes !=
                                                                        null
                                                                    ? loadingProgress
                                                                            .cumulativeBytesLoaded /
                                                                        loadingProgress
                                                                            .expectedTotalBytes!
                                                                    : null,
                                                              ),
                                                            );
                                                          }
                                                        },
                                                      )
                                                /*CachedNetworkImage(
                                              fit: BoxFit.cover,
                                              placeholder:
                                                  (context, url) =>
                                              const Center(
                                                child:
                                                CircularProgressIndicator(),
                                              ),
                                              imageUrl: map['u_img'],
                                            )*/
                                                : Stack(
                                                    children: [
                                                      Image.file(
                                                        File(provider
                                                                .image!.path)
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
                                  ),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        _isFavorite = !_isFavorite;
                                      });
                                      provider.pickImage(context);
                                    },
                                    child: CircleAvatar(
                                      radius: 14,
                                      backgroundColor: AppColors.dividerColor,
                                      child: _isFavorite
                                          ? const Icon(
                                              Icons.add,
                                              size: 18,
                                              color: AppColors.whiteColor,
                                            )
                                          : const Icon(
                                              Icons.edit,
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
                              GestureDetector(
                                onTap: () {
                                  FocusScope.of(context).requestFocus(
                                    FocusNode(),
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    bottom: 25.0,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
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
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          top: 25.0,
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Flexible(
                                              child: TextFormField(
                                                autovalidateMode:
                                                    AutovalidateMode
                                                        .onUserInteraction,
                                                controller: userNameController,
                                                keyboardType:
                                                    TextInputType.text,
                                                decoration:
                                                    const InputDecoration(
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
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          top: 25.0,
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Flexible(
                                              child: TextFormField(
                                                autovalidateMode:
                                                    AutovalidateMode
                                                        .onUserInteraction,
                                                controller: userEmailController,
                                                keyboardType:
                                                    TextInputType.emailAddress,
                                                decoration:
                                                    const InputDecoration(
                                                  enabled: false,
                                                  labelText: 'Email ID',
                                                  hintText: "Enter Email ID",
                                                  prefixIcon: Icon(
                                                    AppIcons.user_mail,
                                                  ),
                                                ),
                                                validator: (value) {
                                                  if (value == null ||
                                                      value.isEmpty) {
                                                    return 'No user for this email';
                                                  } else if (!EmailValidator
                                                      .validate(value)) {
                                                    return ' Enter Valid Email';
                                                  }
                                                  return null;
                                                },
                                                enabled: false,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          top: 25.0,
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Flexible(
                                              child: TextFormField(
                                                autovalidateMode:
                                                    AutovalidateMode
                                                        .onUserInteraction,
                                                controller:
                                                    userNumberController,
                                                keyboardType:
                                                    TextInputType.phone,
                                                decoration:
                                                    const InputDecoration(
                                                  labelText: 'Mobile',
                                                  hintText:
                                                      "Enter Mobile Number",
                                                  prefixIcon: Icon(
                                                    AppIcons.phone_number,
                                                  ),
                                                ),
                                                maxLength: 10,
                                                validator: (value) {
                                                  RegExp digitRegExp =
                                                      RegExp(r'\d');
                                                  if (value == null ||
                                                      value.isEmpty) {
                                                    return 'Enter your number';
                                                  }
                                                  if (!digitRegExp
                                                      .hasMatch(value)) {
                                                    return 'No valid format';
                                                  }
                                                  if (value.length > 10) {
                                                    return 'Maximum limit 10 digits';
                                                  }
                                                  if (value.length < 10) {
                                                    return 'Minimum limit 10 digits';
                                                  }
                                                  return null;
                                                },
                                                enabled: !_status,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          top: 25.0,
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Flexible(
                                              flex: 2,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                  right: 10.0,
                                                  top: 4.0,
                                                ),
                                                child: TextFormField(
                                                  autovalidateMode:
                                                      AutovalidateMode
                                                          .onUserInteraction,
                                                  controller: userAgeController,
                                                  keyboardType:
                                                      TextInputType.phone,
                                                  decoration:
                                                      const InputDecoration(
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
                                            Flexible(
                                              flex: 2,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                  right: 10.0,
                                                ),
                                                child: DropdownButtonFormField(
                                                  value: selectedgender,
                                                  items: genderList
                                                      .map((e) =>
                                                          DropdownMenuItem(
                                                            value: e,
                                                            child: Text(e),
                                                          ))
                                                      .toList(),
                                                  onChanged: isEditable
                                                      ? (String? value) {
                                                          setState(() {
                                                            selectedgender =
                                                                value!;
                                                          });
                                                        }
                                                      : null,
                                                  icon: const Icon(
                                                    Icons
                                                        .arrow_drop_down_circle,
                                                    color: AppColors
                                                        .appbariconColor,
                                                  ),
                                                  decoration:
                                                      const InputDecoration(
                                                    labelText: "Gender",
                                                  ),
                                                ),
                                              ),
                                              // ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      !_status
                                          ? _getActionButtons()
                                          : Container(),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
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
      ),
    );
  }

  Widget _getActionButtons() {
    return Padding(
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
                      isEditable = false;
                      dbadduser();
                      FocusScope.of(context).requestFocus(
                        FocusNode(),
                      );
                    },
                  );
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: AppColors.whiteColor,
                  backgroundColor: AppColors.editbuttonColor,
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
                      isEditable = false;
                      FocusScope.of(context).requestFocus(
                        FocusNode(),
                      );
                    },
                  );
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: AppColors.whiteColor,
                  backgroundColor: AppColors.alertColor,
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
    );
  }

  Widget _getEditIcon() {
    return GestureDetector(
      child: const CircleAvatar(
        backgroundColor: AppColors.circleColor,
        radius: 14.0,
        child: Icon(
          Icons.edit,
          color: AppColors.whiteColor,
          size: 16.0,
        ),
      ),
      onTap: () {
        setState(
          () {
            _status = false;
            isEditable = isEditable == true ? false : true;
          },
        );
      },
    );
  }

  void dbadduser() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        age = userAgeController.text;
        name = userNameController.text;
        number = userNumberController.text;
      });
      ref.update(
        {
          'u_name': userNameController.text.toString(),
          'number': userNumberController.text.toString(),
          'age': userAgeController.text.toString(),
          'gender': selectedgender.toString(),
          'email': userEmailController.text.toString(),
        },
      );
      dbref
          .doc(
        FirebaseAuth.instance.currentUser!.uid.toString(),
      )
          .update(
        {
          'u_name': userNameController.text.toString(),
          'number': userNumberController.text.toString(),
          'age': userAgeController.text.toString(),
          'gender': selectedgender.toString(),
          'email': userEmailController.text.toString(),
        },
      );
      userNumberController.addListener(
        () {
          if (userNumberController.text.length > 10) {
            userNumberController.text =
                userNumberController.text.substring(0, 10);
            userNumberController.selection = TextSelection.fromPosition(
              TextPosition(offset: userNumberController.text.length),
            );
          }
        },
      );
      userAgeController.addListener(
        () {
          if (userAgeController.text.length > 2) {
            userAgeController.text = userAgeController.text.substring(0, 2);
            userAgeController.selection = TextSelection.fromPosition(
              TextPosition(offset: userAgeController.text.length),
            );
          }
        },
      );
    }
  }
}
