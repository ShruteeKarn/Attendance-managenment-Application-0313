import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CheckBoxPage(),
    );
  }
}

class CheckBoxPage extends StatefulWidget {
  @override
  _CheckBoxPageState createState() => _CheckBoxPageState();
}

class _CheckBoxPageState extends State<CheckBoxPage> {
  bool option1 = false;
  bool option2 = false;
  bool option3 = false;
  bool option4 = false;
  bool option5 = false;
  bool option6 = false;
  bool option7 = false;
  bool option8 = false;
  bool option9 = false;
  bool option10 = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CheckboxListTile(
              title: Text('Aarav'),
              value: option1,
              onChanged: (value) {
                setState(() {
                  option1 = value!;
                });
              },
            ),
            CheckboxListTile(
              title: Text('Aisha'),
              value: option2,
              onChanged: (value) {
                setState(() {
                  option2 = value!;
                });
              },
            ),
            CheckboxListTile(
              title: Text('Ananya'),
              value: option3,
              onChanged: (value) {
                setState(() {
                  option3 = value!;
                });
              },
            ),
            CheckboxListTile(
              title: Text('Aryan'),
              value: option4,
              onChanged: (value) {
                setState(() {
                  option4 = value!;
                });
              },
            ),
            CheckboxListTile(
              title: Text('Divya'),
              value: option5,
              onChanged: (value) {
                setState(() {
                  option5 = value!;
                });
              },
            ),
            CheckboxListTile(
              title: Text('Ishaan'),
              value: option6,
              onChanged: (value) {
                setState(() {
                  option6 = value!;
                });
              },
            ),
            CheckboxListTile(
              title: Text('Kavya'),
              value: option7,
              onChanged: (value) {
                setState(() {
                  option7 = value!;
                });
              },
            ),
            CheckboxListTile(
              title: Text('Rohan'),
              value: option8,
              onChanged: (value) {
                setState(() {
                  option8 = value!;
                });
              },
            ),
            CheckboxListTile(
              title: Text('Sneha'),
              value: option9,
              onChanged: (value) {
                setState(() {
                  option9 = value!;
                });
              },
            ),
            CheckboxListTile(
              title: Text('Varun'),
              value: option10,
              onChanged: (value) {
                setState(() {
                  option10 = value!;
                });
              },
            ),
            ElevatedButton(
              onPressed: () {
                // Implement the submit action here.
                // You can use the values of option1, option2, etc., as needed.
                print('Selected Options:');
                print('Aarav: $option1');
                print('Aisha: $option2');
                print('Ananya: $option3');
                print('Aryan: $option4');
                print('Divya: $option5');
                print('Ishaan: $option6');
                print('Kavya: $option7');
                print('Rohan: $option8');
                print('Sneha: $option9');
                print('Varun: $option10');
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
