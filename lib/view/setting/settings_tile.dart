import 'package:flutter/material.dart';
import '../../res/color.dart';

class SettingsTile extends StatelessWidget {
  final Color color;
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const SettingsTile({
    Key? key,
    required this.color,
    required this.title,
    required this.onTap,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 45,
          height: 45,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              15,
            ),
            color: color,
          ),
          child: Icon(
            icon,
            color: AppColors.appbariconColor,
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Spacer(),
        InkWell(
          onTap: onTap,
          child: Container(
            width: 45,
            height: 45,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(
                10,
              ),
            ),
            child: const Icon(
              Icons.arrow_forward_ios,
            ),
          ),
        )
      ],
    );
  }
}
