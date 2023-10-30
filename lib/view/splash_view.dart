// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import '../view_model/services/splash_services.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  SplashServices splashServices = SplashServices();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // splashServices.checkAuthentication(context);
    Future.delayed(const Duration(milliseconds: 1500), () async {
      await splashServices.check_if_already_login(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Image.asset(
          "assets/images/splashrku.png",
          // height: 300.0,
          // width: 300.0,
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
