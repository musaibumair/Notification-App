import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:notificationapp/assets/widget/drawerwidget.dart';

import '../login/loginscreen.dart';
class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  var databaseReference=FirebaseDatabase.instance.ref("Message");
  TextEditingController message=TextEditingController();

  sendMessage(){
    DateTime dateTime=DateTime.now();
    databaseReference.push().set({'key':dateTime.microsecondsSinceEpoch,'message':message.text}).then((value){print("sent message");}).catchError((error){
      print("the error is ${error}");
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Notifications"),),
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
      body: Column(
        children: [
          Expanded(flex: 8,
            child:FirebaseAnimatedList(
              reverse: false,
              query:databaseReference,
              itemBuilder: (context, snapshot, animation, index) {
                if(!snapshot.exists){
                  return CircularProgressIndicator();
                }
                else{
                  return ListTile(
                    title: Text(snapshot.child("message").value.toString()),
                    subtitle: Text(snapshot.child("date").value.toString()),
                  );
                }
              },
            ),
          ),
          Expanded(flex: 1,
              child: Container(height: 40,
                margin: EdgeInsets.only(left: 20,right: 20,),
                child: TextField(
                  controller: message,
                  decoration: InputDecoration(suffixIcon: IconButton(onPressed: (){
                    sendMessage();
                    message.clear();
                  },icon: Icon(Icons.send),),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25)
                      )),
                ),
              )),
        ],
      ),
    );
  }
}
