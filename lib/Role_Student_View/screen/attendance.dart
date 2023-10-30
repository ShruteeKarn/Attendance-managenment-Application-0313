import 'dart:async';
import 'package:flutter/material.dart';
import 'package:ams/Role_Student_View/grid.dart';

import '../Dashboard/Profile.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  Animation<double>? _animation;
  int counter = 1;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _animation = Tween<double>(
      begin: 0.0,
      end: 0.75,
    ).animate(_controller)
      ..addListener(() {
        setState(() {});
      });

    _controller.forward();

    Timer.periodic(const Duration(milliseconds: 35), (timer) {
      if (counter < 50) {
        setState(() {
          counter++;
        });
      } else {
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Home Page"),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 12.0),
              child: Container(
                width: 30,
                height: 30,
                decoration: const BoxDecoration(
                  color: Colors.white, // Change to your desired color
                  shape: BoxShape.circle,
                ),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => User_UserProfile()));
                  },
                  child: const Icon(Icons.person, color: Colors.black),
                ),
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 18.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildCircularProgressBar("Current Month"),
                        _buildCircularProgressBar("Average"),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  width: double.infinity,
                  height: 550,
                  child: MyGrid(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCircularProgressBar(String label) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              height: 110,
              width: 110,
              child: CircularProgressIndicator(
                value: _animation?.value ?? 0.0,
                strokeWidth: 8,
                backgroundColor: Colors.grey,
                valueColor: const AlwaysStoppedAnimation<Color>(
                  Colors.red, // Change to your desired color
                ),
              ),
            ),
            Text(
              '$counter%',
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
