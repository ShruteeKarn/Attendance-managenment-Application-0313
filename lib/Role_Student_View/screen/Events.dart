// import 'package:flutter/material.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: EventCollagePage(),
//     );
//   }
// }

// class EventCollagePage extends StatelessWidget {
//   final List<Event> events = [
//     Event("Foundation Day", "2023-10-10"),
//     Event("Diwali", "2023-11-04"),
//     Event("Saraswati Puja", "2023-02-16"),
//     Event("Holi", "2023-03-18"),
//     Event("New year Fest", "2023-01-01"),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: ListView(
//         children: [
//           GridView.builder(
//             shrinkWrap: true, // Add this property
//             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 2,
//             ),
//             itemCount: events.length,
//             itemBuilder: (BuildContext context, int index) {
//               return EventCard(event: events[index]);
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }

// class Event {
//   final String name;
//   final String date;

//   Event(this.name, this.date);
// }

// class EventCard extends StatelessWidget {
//   final Event event;

//   EventCard({required this.event});

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       margin: EdgeInsets.all(10),
//       child: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               event.name,
//               style: TextStyle(fontSize: 20),
//             ),
//             Text(
//               event.date,
//               style: TextStyle(fontSize: 16),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: EventCollagePage(),
    );
  }
}

class EventCollagePage extends StatelessWidget {
  final List<Event> events = [
    Event("Foundation Day", "2023-10-10", Icons.cake, Colors.red),
    Event("Diwali", "2023-11-04", Icons.lightbulb_outline, Colors.deepOrange),
    Event("Saraswati Puja", "2023-02-16", Icons.school, Colors.blue),
    Event("Holi", "2023-03-18", Icons.invert_colors, Colors.green),
    Event("New year Fest", "2023-01-01", Icons.party_mode, Colors.purple),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemCount: events.length,
        itemBuilder: (BuildContext context, int index) {
          return EventCard(event: events[index]);
        },
      ),
    );
  }
}

class Event {
  final String name;
  final String date;
  final IconData icon;
  final Color color;

  Event(this.name, this.date, this.icon, this.color);
}

class EventCard extends StatelessWidget {
  final Event event;

  EventCard({required this.event});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      color: event.color, // Background color
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              event.icon,
              size: 40, // Decreased icon size
              color: Colors.white, // Icon color
            ),
            Text(
              event.name,
              style: TextStyle(fontSize: 20, color: Colors.white), // Text color
            ),
            Text(
              event.date,
              style: TextStyle(fontSize: 16, color: Colors.white), // Text color
            ),
          ],
        ),
      ),
    );
  }
}
