import 'package:flutter/material.dart';
class ClassesDashBoard extends StatefulWidget {
  const ClassesDashBoard({Key? key}) : super(key: key);

  @override
  State<ClassesDashBoard> createState() => _ClassesDashBoardState();
}

class _ClassesDashBoardState extends State<ClassesDashBoard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title:Text("Classes"),leading:IconButton(icon:Icon(Icons.menu) ,onPressed: (){}),));
  }
}
