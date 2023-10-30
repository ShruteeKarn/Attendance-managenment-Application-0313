import 'package:ams/Role_Student_View/Dashboard/Home.dart';
import 'package:flutter/material.dart';


import '../../Role_Student_View/Dashboard/Dashboard.dart';
import '../../Role_Student_View/Dashboard/Profile.dart';
import '../../Role_Student_View/Dashboard/Setting.dart';
import '../../view/forgot_password.dart';
import '../../view/login/login_page.dart';
import '../../view/setting/change_password.dart';
import '../../view/signup/signup_view.dart';
import '../../view/splash_view.dart';
import 'routes_name.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.splash:
        return MaterialPageRoute(
          builder: (BuildContext context) => const SplashView(),
        );

      // case RoutesName.verification_page:
      //   return MaterialPageRoute(
      //     builder: (BuildContext context) => const VerifyEmailPage(),
      //   );

      case RoutesName.login:
        return MaterialPageRoute(
          builder: (BuildContext context) => const LoginPage(),
        );

      case RoutesName.signup:
        return MaterialPageRoute(
          builder: (BuildContext context) => const SignUp(),
        );

      case RoutesName.dashboard:
        return MaterialPageRoute(
          builder: (BuildContext context) => const User_Dashboard(),
        );

      case RoutesName.home:
        return MaterialPageRoute(
          builder: (BuildContext context) => const User_Home(),
        );

      case RoutesName.forgotpassword:
        return MaterialPageRoute(
          builder: (BuildContext context) => const ForgotPassword(),
        );

      case RoutesName.changepassword:
        return MaterialPageRoute(
          builder: (BuildContext context) => const ResetPassword(),
        );

      case RoutesName.setting:
        return MaterialPageRoute(
          builder: (BuildContext context) => const User_Setting(),
        );

      case RoutesName.profile:
        return MaterialPageRoute(
          builder: (BuildContext context) => const User_UserProfile(),
        );

      /*      Student Screen Route      */

      case RoutesName.udashboard:
        return MaterialPageRoute(
          builder: (BuildContext context) => const User_Dashboard(),
        );

      case RoutesName.usetting:
        return MaterialPageRoute(
          builder: (BuildContext context) => const User_Setting(),
        );

      case RoutesName.uprofile:
        return MaterialPageRoute(
          builder: (BuildContext context) => const User_UserProfile(),
        );

      default:
        return MaterialPageRoute(
          builder: (_) {
            return const Scaffold(
              body: Center(
                child: Text(
                  'No route defined',
                ),
              ),
            );
          },
        );
    }
  }
}
