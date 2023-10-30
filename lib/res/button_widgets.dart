// ignore_for_file: prefer_typing_uninitialized_variables, non_constant_identifier_names, must_be_immutable

import 'package:flutter/material.dart';
import '../../res/color.dart';
import 'package:material_dialogs/dialogs.dart';

class AddUpdateButton extends StatelessWidget {
  AddUpdateButton({
    super.key,
    required this.Onpressed,
    required this.Display_Name,
    required this.Loading,
  });

  var Onpressed;
  var Display_Name;
  bool Loading;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: Onpressed,
      minWidth: 35,
      height: 35,
      color: AppColors.submitbuttonColor,
      textColor: AppColors.buttonTextColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          32,
        ),
      ),
      child: Loading
          ? Container(
              width: 24,
              height: 24,
              padding: const EdgeInsets.all(2.0),
              child: const CircularProgressIndicator(
                color: AppColors.appbartextColor,
                strokeWidth: 3,
              ),
            )
          : Text(
              Display_Name,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
    );
  }
}

class LoginSignUpButton extends StatelessWidget {
  LoginSignUpButton({
    super.key,
    required this.Onpressed,
    required this.Display_Name,
    required this.Loading,
  });

  var Onpressed;
  var Display_Name;
  bool Loading;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: Onpressed,
      minWidth: double.infinity,
      height: 52,
      elevation: 24,
      color: AppColors.submitbuttonColor,
      textColor: AppColors.buttonTextColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          32,
        ),
      ),
      child: Loading
          ? Container(
              width: 24,
              height: 24,
              padding: const EdgeInsets.all(2.0),
              child: const CircularProgressIndicator(
                color: AppColors.appbartextColor,
                strokeWidth: 3,
              ),
            )
          : Text(
              Display_Name,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
    );
  }
}

class EditButton extends StatelessWidget {
  EditButton({
    super.key,
    required this.Onpressed,
  });

  var Onpressed;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: Onpressed,
      minWidth: double.infinity,
      height: 38,
      elevation: 16,
      color: AppColors.editbuttonColor,
      textColor: AppColors.whiteColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          32,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(
            Icons.edit_outlined,
            color: AppColors.whiteColor,
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 1.0,
              right: 1.0,
            ),
          ),
          Text(
            'Edit',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class DeleteButton extends StatelessWidget {
  final VoidCallback Onpressed;
  final String displayName;

  const DeleteButton({
    Key? key,
    required this.Onpressed,
    required this.displayName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {
        Dialogs.materialDialog(
          title: displayName,
          color: AppColors.bgColor,
          context: context,
          actions: [
            MaterialButton(
              onPressed: Onpressed,
              color: AppColors.submitbuttonColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  32,
                ),
              ),
              child: const Text(
                'Yes',
                style: TextStyle(
                  color: AppColors.buttonTextColor,
                ),
              ),
            ),
            MaterialButton(
              onPressed: () {
                Navigator.pop(context);
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  32,
                ),
              ),
              color: AppColors.submitbuttonColor,
              child: const Text(
                'No',
                style: TextStyle(
                  color: AppColors.buttonTextColor,
                ),
              ),
            ),
          ],
        );
      },
      minWidth: double.infinity,
      height: 38,
      elevation: 16,
      color: AppColors.deletebuttonColor,
      textColor: AppColors.whiteColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          32,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(
            Icons.delete_forever_outlined,
            color: AppColors.whiteColor,
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 1.0,
              right: 1.0,
            ),
          ),
          Text(
            'Delete',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColors.whiteColor,
            ),
          ),
        ],
      ),
    );
  }
}

class SignOutButton extends StatelessWidget {
  final VoidCallback Onpressed;


  const SignOutButton({
    Key? key,
    required this.Onpressed,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {
        Dialogs.materialDialog(
          title: 'Are you sure you want to Logout ?',
          color: AppColors.bgColor,
          context: context,
          actions: [
            MaterialButton(
              onPressed: Onpressed,
              color: AppColors.submitbuttonColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  32,
                ),
              ),
              child: const Text(
                'Yes',
                style: TextStyle(
                  color: AppColors.buttonTextColor,
                ),
              ),
            ),
            MaterialButton(
              onPressed: () {
                Navigator.pop(context);
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  32,
                ),
              ),
              color: AppColors.submitbuttonColor,
              child: const Text(
                'No',
                style: TextStyle(
                  color: AppColors.buttonTextColor,
                ),
              ),
            ),
          ],
        );
      },

      color: AppColors.submitbuttonColor,
      textColor: AppColors.textColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          32,
        ),
      ),
      padding: const EdgeInsets.all(1.0,),
      child: const Text(
        'Sign out',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ),
    );
  }
}
