import 'package:flutter/material.dart';

class timeTable extends StatefulWidget {
  const timeTable({super.key});

  @override
  State<timeTable> createState() => _timeTableState();
}

class _timeTableState extends State<timeTable> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset("assets/images/TIMETABLE.png"),
      ),
    );
  }
}
