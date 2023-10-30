import 'package:flutter/material.dart';

import 'color.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? leadingOnPressed;
  final VoidCallback? trailingOnPressed;
  final IconData? trailingIcon;

  CustomAppBar({
    required this.title,
    this.leadingOnPressed,
    this.trailingOnPressed,
    this.trailingIcon,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    double? scrolledUnderElevation;
    return AppBar(
      title: Text(
        title,
        style: const TextStyle(
          color: AppColors.appbartextColor,
          fontSize: 24,
          // Add any additional TextStyle options here
        ),
      ),
      surfaceTintColor: AppColors.whiteColor,
      backgroundColor: AppColors.appbarColor,
      foregroundColor: AppColors.whiteColor,
      scrolledUnderElevation: scrolledUnderElevation,
      automaticallyImplyLeading: false,
      elevation: 2,
      leading: leadingOnPressed != null
          ? IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: AppColors.appbariconColor,
              ),
              onPressed: leadingOnPressed,
            )
          : null,
      actions: trailingIcon != null && trailingOnPressed != null
          ? [
              IconButton(
                icon: Icon(
                  trailingIcon,
                  color: AppColors.appbariconColor,
                ),
                onPressed: trailingOnPressed,
              ),
            ]
          : null,
    );
  }
}

// class AppColors {
//   static const Color appbartextColor = Colors.white; // Change this to your desired color
//   static const Color appbarColor = Colors.blue; // Change this to your desired color
// }
