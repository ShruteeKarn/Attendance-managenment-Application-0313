import 'package:ams/Role_Student_View/screen/academics.dart';
import 'package:ams/Role_Student_View/screen/timeTable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'Dashboard/Setting.dart';
import 'screen/Events.dart';
import 'screen/TakeAttendance.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyGrid(),
    );
  }
}

class MyGrid extends StatelessWidget {
  const MyGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: GridView.count(
        crossAxisCount: 2,
        mainAxisSpacing: 4.0,
        crossAxisSpacing: 4.0,
        childAspectRatio: 1.6,
        children: [
          GridItem(
            title: 'Attendance',
            icon: Icons.menu_book_sharp,
            Screen: CheckBoxPage(),
          ),
          const GridItem(
              title: 'Academic Calender',
              icon: Icons.calendar_month_outlined,
              Screen: academics()),
          const GridItem(
            title: 'Timetable',
            icon: Icons.access_time_filled,
            Screen: timeTable(),
          ),
          GridItem(
            title: 'Events',
            icon: Icons.event_note_rounded,
            Screen: EventCollagePage(),
          ),
          const GridItem(
            title: 'Setting',
            icon: Icons.settings,
            Screen: User_Setting(),
          ),
        ],
      ),
    );
  }
}

class GridItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final Widget Screen;

  const GridItem(
      {Key? key, required this.title, required this.icon, required this.Screen})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to the next page when the card is tapped
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NextPage(title: title, Screen: Screen),
          ),
        );
      },
      child: Card(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 48.0,
                color: Colors.red, // You can set the color here
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12.0),
                child: Text(
                  title,
                  style: const TextStyle(fontSize: 16.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NextPage extends StatelessWidget {
  final String title;
  final Widget Screen;

  const NextPage({Key? key, required this.title, required this.Screen})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Screen,
      ),
    );
  }
}
