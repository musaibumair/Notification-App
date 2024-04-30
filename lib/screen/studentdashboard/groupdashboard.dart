import 'package:flutter/material.dart';
class GroupDashBoard extends StatefulWidget {
  const GroupDashBoard({Key? key}) : super(key: key);

  @override
  State<GroupDashBoard> createState() => _GroupDashBoardState();
}

class _GroupDashBoardState extends State<GroupDashBoard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title:Text("Student Groups"),leading:IconButton(icon:Icon(Icons.menu) ,onPressed: (){}),));
  }
}
