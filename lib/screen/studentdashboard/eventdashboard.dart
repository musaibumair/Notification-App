import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:notificationapp/screen/login/loginscreen.dart';
import 'package:notificationapp/screen/signup/signup.dart';

class EventDashBoardForStudent extends StatefulWidget {
  const EventDashBoardForStudent({Key? key}) : super(key: key);

  @override
  State<EventDashBoardForStudent> createState() => _EventDashBoardForStudentState();
}

class _EventDashBoardForStudentState extends State<EventDashBoardForStudent> {
  var databaseReference=FirebaseDatabase.instance.ref("Message");
  Color color=Color.fromRGBO(171, 252, 174, 1.0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(246, 235, 235, 1.0),
        appBar: AppBar(
      title: Text("Event Notification"),
    ),
      drawer: Drawer(
        child: Container(
          margin: EdgeInsets.all(10),
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
      ),
      body: Container(margin: EdgeInsets.all(10),
        child: FirebaseAnimatedList(
          query:databaseReference,
          itemBuilder: (context, snapshot, animation, index) {
            if(snapshot.child("messageType").value.toString()=='alert'){
              color=Color.fromRGBO(248, 125, 125, 1.0);
            }
            else if(snapshot.child("messageType").value.toString()=='timeLimited'){
              color=Color.fromRGBO(165, 187, 215, 1.0);
            }
            else{
              color=Color.fromRGBO(171, 252, 174, 1.0);
            }
            return snapshot.child("message").value.toString().contains("https://firebasestorage.googleapis.com/v0/b/notifyme-59aae.appspot.com/o/notificationImage%")?Container(
                child: Column(
                  children: [Image.network(snapshot.child("message").value.toString()),
                    Text(snapshot.child("date").value.toString()),
                  ],
                )
            ):Container(
              margin: EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(color: color,
              borderRadius: BorderRadius.circular(20)),
              child: ListTile(
                title: Text(snapshot.child("message").value.toString()),
                subtitle: Text(snapshot.child("date").value.toString()),
              ),
            );
          },
        ),
      ),
    );
  }
}
