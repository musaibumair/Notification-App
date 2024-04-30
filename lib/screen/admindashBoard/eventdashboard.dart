import 'package:flutter/material.dart';
class EventDashBoard extends StatefulWidget {
  const EventDashBoard({Key? key}) : super(key: key);

  @override
  State<EventDashBoard> createState() => _EventDashBoardState();
}

class _EventDashBoardState extends State<EventDashBoard> {
  @override

  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title:Text("Event Notification"),leading:IconButton(icon:Icon(Icons.menu) ,onPressed: (){}),));
  }
}
