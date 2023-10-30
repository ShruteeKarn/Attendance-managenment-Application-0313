import '../../../res/CustomAppBar.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../res/button_widgets.dart';
import '../../res/color.dart';
import '../../view/login/login_page.dart';
import '../../view/setting/change_password.dart';
import '../../view/setting/settings_tile.dart';
import 'Profile.dart';

class User_Setting extends StatefulWidget {
  const User_Setting({Key? key}) : super(key: key);

  @override
  State<User_Setting> createState() => _User_SettingState();
}

class _User_SettingState extends State<User_Setting> {
  late SharedPreferences logindata;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(
            left: 16,
            top: 20,
            right: 16,
          ),
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(
                        Icons.person,
                        color: AppColors.settingiconColor,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        "Account",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const Divider(
                    height: 12,
                    thickness: 2,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SettingsTile(
                    color: AppColors.settingiconColor,
                    icon: Ionicons.person_circle_outline,
                    title: "Profile",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const User_UserProfile(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SettingsTile(
                    color: AppColors.settingiconColor,
                    icon: Ionicons.finger_print_outline,
                    title: "Reset password",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ResetPassword(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  const Row(
                    children: [
                      Icon(
                        Icons.share,
                        color: AppColors.settingiconColor,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        "Share",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const Divider(
                    height: 12,
                    thickness: 2,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SettingsTile(
                    color: AppColors.settingiconColor,
                    icon: Ionicons.share_social_outline,
                    title: "Social",
                    onTap: () {
                      _SocialURL();
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SettingsTile(
                    color: AppColors.settingiconColor,
                    icon: Ionicons.share_outline,
                    title: "Share",
                    onTap: () {
                      _ShareURL();
                    },
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  const Row(
                    children: [
                      Icon(
                        Icons.copyright,
                        color: AppColors.settingiconColor,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        "Terms",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const Divider(
                    height: 12,
                    thickness: 2,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SettingsTile(
                    color: AppColors.settingiconColor,
                    icon: Icons.privacy_tip_sharp,
                    title: "Privacy and Policy",
                    onTap: () {
                      _PrivacyURL();
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SettingsTile(
                    color: AppColors.settingiconColor,
                    icon: Ionicons.documents_outline,
                    title: "Contact Us",
                    onTap: () {
                      _TermsURL();
                    },
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                ],
              ),
              const SizedBox(
                height: 25,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SignOutButton(
                    Onpressed: () async {
                      logindata = await SharedPreferences.getInstance();
                      logindata?.clear();
                      // ignore: use_build_context_synchronously
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const LoginPage(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  _SocialURL() async {
    const url = 'https://rku.ac.in/index';
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }

  _ShareURL() async {
    const url = 'AMS';
    try {
      await Share.share(url);
    } catch (e) {
      throw 'Could not share $url';
    }
  }

  _PrivacyURL() async {
    const url = 'https://rku.ac.in/privacy-policy.php';
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }

  _TermsURL() async {
    const url = 'https://rku.ac.in/contact-us';
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }
}
