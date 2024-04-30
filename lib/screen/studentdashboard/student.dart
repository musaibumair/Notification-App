import 'package:flutter/material.dart';
class StudentDashBoard extends StatefulWidget {
  const StudentDashBoard({Key? key}) : super(key: key);

  @override
  State<StudentDashBoard> createState() => _StudentDashBoardState();
}

class _StudentDashBoardState extends State<StudentDashBoard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title:Text("Event Notification"),leading:IconButton(icon:Icon(Icons.menu) ,onPressed: (){}),));
  }
}
