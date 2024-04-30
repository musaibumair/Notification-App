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
      body:StreamBuilder(
        stream: databaseReference.onValue,
        builder: (context, snapshot) {
          if(!snapshot.hasData){
            return CircularProgressIndicator();
          }
          else{
            Map<dynamic,dynamic> map=snapshot.data!.snapshot.value as dynamic;
            List<dynamic> list=[];
            list=map.values.toList();
            return ListView.builder(itemBuilder: (context, index) {
              return ListTile(
                title: Text(list[index]["message"].toString()),
              );
            },itemCount: snapshot.data!.snapshot.children.length,
            );
          }
        },
      ),
    );
  }
}
