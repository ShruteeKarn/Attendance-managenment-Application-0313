import 'package:flutter/material.dart';

class academics extends StatefulWidget {
  const academics({super.key});

  @override
  State<academics> createState() => _academicsState();
}

class _academicsState extends State<academics> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset("assets/images/TIMETABLE.png"),
      ),
    );
  }
}
