import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:notificationapp/screen/studentdashboard/classesdashboard.dart';
import 'package:notificationapp/screen/studentdashboard/eventdashboard.dart';
import 'package:notificationapp/screen/studentdashboard/groupdashboard.dart';


class BottomNabBar extends StatefulWidget {
  const BottomNabBar({super.key});

  @override
  State<BottomNabBar> createState() => _BottomNabBarState();
}

class _BottomNabBarState extends State<BottomNabBar> {
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  int currentIndex=0;
  List Screen=[
    EventDashBoardForStudent(),
    ClassesDashBoard(),
    GroupDashBoard()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            label: 'Groups',
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
