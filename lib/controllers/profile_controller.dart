// ignore_for_file: prefer_typing_uninitialized_variables, use_build_context_synchronously

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import '../../res/color.dart';
import 'package:image_picker/image_picker.dart';

import '../utils/utils.dart';

class ProfileController with ChangeNotifier {
  final userNameController = TextEditingController();
  final userAgeController = TextEditingController();
  final userEmailController = TextEditingController();
  final userNumberController = TextEditingController();
  final userGenderController = TextEditingController();

  final nameFocusNode = FocusNode();
  final ageFocusNode = FocusNode();
  final emailFocusNode = FocusNode();
  final numberFocusNode = FocusNode();
  final genderFocusNode = FocusNode();

  bool isButtonActive = false;

  final ref = FirebaseFirestore.instance.collection('Users');
  final dbref = FirebaseFirestore.instance.collection('Users');

  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  final picker = ImagePicker();
  var imagelink;

  XFile? _image;

  XFile? get image => _image;

  bool _loading = false;

  bool get loading => _loading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future pickGalleryImage(BuildContext context) async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 100,
    );

    if (pickedFile != null) {
      _image = XFile(pickedFile.path);
      uploadImage(context);
      notifyListeners();
    }
  }

  Future pickCameraImage(BuildContext context) async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 100,
    );

    if (pickedFile != null) {
      _image = XFile(pickedFile.path);
      uploadImage(context);
      notifyListeners();
    }
  }

  void pickImage(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SizedBox(
            height: 168,
            child: Column(
              children: [
                ListTile(
                  onTap: () {
                    pickCameraImage(context);
                    Navigator.pop(context);
                  },
                  leading: const Icon(
                    Icons.camera_alt_outlined,
                    color: AppColors.dividerColor,
                  ),
                  title: const Text('Camera'),
                ),
                ListTile(
                  onTap: () {
                    pickGalleryImage(context);
                    Navigator.pop(context);
                  },
                  leading: const Icon(
                    Icons.image,
                    color: AppColors.dividerColor,
                  ),
                  title: const Text('Gallery'),
                ),
                ListTile(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  leading: const Icon(
                    Icons.cancel_outlined,
                    color: AppColors.dividerColor,
                  ),
                  title: const Text('Cancel'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void uploadImage(BuildContext context) async {
    setLoading(true);
    firebase_storage.Reference storageref =
        firebase_storage.FirebaseStorage.instance.ref(
      '/u_img${FirebaseAuth.instance.currentUser!.uid}',
    );

    firebase_storage.UploadTask uploadTask =
        storageref.putFile(File(image!.path).absolute);

    await Future.value(uploadTask);

    final newUrl = await storageref.getDownloadURL();
    ref
        .doc(
      FirebaseAuth.instance.currentUser!.uid.toString(),
    )
        .update({'u_img': newUrl.toString()}).then(
      (value) {
        Utils.customFlushBar(context, 'Profile updated');
        setLoading(false);
        _image = null;
      },
    ).onError(
      (error, stackTrace) {
        setLoading(false);
        Utils.customFlushBar(
          context,
          error.toString(),
        );
      },
    );
  }

  void showImage(context, String imageUrl) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Center(
          child: Hero(
            tag: imageUrl,
            child: Image.network(
              imageUrl,
              fit: BoxFit.contain,
            ),
          ),
        );
      },
    );
  }
}
