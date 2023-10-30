import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../res/color.dart';

class Utils {
  static double averageRating(List<int> rating) {
    var avgRating = 0;
    for (int i = 0; i < rating.length; i++) {
      avgRating = avgRating + rating[i];
    }
    return double.parse(
      (avgRating / rating.length).toStringAsFixed(1),
    );
  }

  static void fieldFocusChange(
      BuildContext context, FocusNode current, FocusNode nextFocus) {
    current.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  static toastMessage(String message) {
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: AppColors.appbarColor,
      textColor: AppColors.textColor,
    );
  }

  static void flushBarErrorMessage(String message, BuildContext context) {
    showFlushbar(
      context: context,
      flushbar: Flushbar(
        forwardAnimationCurve: Curves.decelerate,
        margin: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        padding: const EdgeInsets.all(
          15,
        ),
        message: message,
        duration: const Duration(
          seconds: 1,
        ),
        borderRadius: BorderRadius.circular(
          8,
        ),
        flushbarPosition: FlushbarPosition.TOP,
        backgroundColor: AppColors.alertColor,
        reverseAnimationCurve: Curves.easeInOut,
        positionOffset: 20,
        icon: const Icon(
          Icons.error,
          size: 28,
          color: AppColors.whiteColor,
        ),
      )..show(context),
    );
  }

  static snackBar(String message, BuildContext context) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: AppColors.alertColor,
        content: Text(
          message,
        ),
      ),
    );
  }

  static Flushbar customFlushBar(BuildContext context, String text) {
    return Flushbar(
      flushbarPosition: FlushbarPosition.BOTTOM,
      message: text,
      duration: const Duration(seconds: 2),
      backgroundColor: AppColors.flushbar2bgColor,
      leftBarIndicatorColor: AppColors.whiteColor,
      // Customize the border radius
      borderRadius: BorderRadius.circular(8),
      // Customize the entrance animation
      forwardAnimationCurve: Curves.easeOutQuart,
      // Customize the exit animation
      reverseAnimationCurve: Curves.easeInQuart,
    )..show(context);
  }

  static Flushbar customFlushBar2(BuildContext context, String text) {
    return Flushbar(
      flushbarPosition: FlushbarPosition.TOP,
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(10),
      message: text,
      duration: const Duration(seconds: 2),
      backgroundColor: AppColors.flushbar2bgColor,
      leftBarIndicatorColor: AppColors.whiteColor,
    )..show(context);
  }
}
