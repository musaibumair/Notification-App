import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../screen/login/loginscreen.dart';
class DrawerWidget extends StatefulWidget {
  const DrawerWidget({super.key});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                padding: EdgeInsets.only(top: 20,bottom: 20),
                color: Theme.of(context).canvasColor,
                margin: EdgeInsets.only(top: 50,bottom: 30),

                child:Column(children: [
                  Center(child: CircleAvatar(child: Icon(Icons.person,size: 30,),)),
                  Text(FirebaseAuth.instance.currentUser!.email.toString(),style: TextStyle(fontSize: 16),)
                ],)
            ),
            InkWell(child: ListTile(leading: Icon(Icons.logout),title: Text("Log Out"),onTap: (){ FirebaseAuth.instance.signOut();
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>LoginScreen(),));},)),
          ],
        ),
      ),
    );
  }
}
