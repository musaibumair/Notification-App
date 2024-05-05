import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:notificationapp/screen/admindashBoard/teacher-discussion.dart';
import 'package:notificationapp/screen/studentdashboard/eventdashboard.dart';
import 'package:notificationapp/screen/studentdashboard/groupdashboard.dart';
import 'package:notificationapp/screen/teacherdashboard/create-group.dart';

class BottomNabBarforTeacher extends StatefulWidget {
  const BottomNabBarforTeacher({super.key});

  @override
  State<BottomNabBarforTeacher> createState() => _BottomNabBarforTeacherState();
}

class _BottomNabBarforTeacherState extends State<BottomNabBarforTeacher> {
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  int currentIndex = 0;
  List Screen = [
    EventDashBoardForStudent(),
    GroupCreate(),
    TeacherDiscussion()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(246, 235, 235, 1.0),
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: 0,
        items: [
          CurvedNavigationBarItem(
            child: Icon(Icons.notifications_on_outlined),
            label: 'Notification',
          ),
          CurvedNavigationBarItem(
            child: Icon(Icons.class_outlined),
            label: 'Calsses',
          ),
          CurvedNavigationBarItem(
            child: Icon(Icons.group),
            label: 'Chat',
          ),
        ],
        color: Colors.white,
        buttonBackgroundColor: Colors.white,
        backgroundColor: Colors.blueAccent,
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 600),
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        letIndexChange: (index) => true,
      ),
      body: Screen[currentIndex],
    );
  }
}
