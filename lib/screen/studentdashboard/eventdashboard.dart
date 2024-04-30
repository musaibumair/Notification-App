import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:notificationapp/screen/login/loginscreen.dart';
import 'package:notificationapp/screen/signup/signup.dart';

class EventDashBoard extends StatefulWidget {
  const EventDashBoard({Key? key}) : super(key: key);

  @override
  State<EventDashBoard> createState() => _EventDashBoardState();
}

class _EventDashBoardState extends State<EventDashBoard> {
  var databaseReference=FirebaseDatabase.instance.ref("Message");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
      title: Text("Event Notification"),
    ),
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
      body: FirebaseAnimatedList(
        query:databaseReference,
        itemBuilder: (context, snapshot, animation, index) {
          return snapshot.child("message").value.toString().contains("https://firebasestorage.googleapis.com/v0/b/notifyme-59aae.appspot.com/o/notificationImage%")?Container(
              child: Column(
                children: [Image.network(snapshot.child("message").value.toString()),
                  Text(snapshot.child("date").value.toString()),
                ],
              )
          ):Container(
            child: ListTile(
              title: Text(snapshot.child("message").value.toString()),
              subtitle: Text(snapshot.child("date").value.toString()),
            ),
          );
        },
      ),
    );
  }
}
