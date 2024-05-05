import 'dart:ffi';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
class GroupView extends StatefulWidget {
  String? className;
  String? id;
  GroupView({this.className,this.id});

  @override
  State<GroupView> createState() => _GroupViewState();
}

class _GroupViewState extends State<GroupView> {
  var messageController=TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  var databaseReference=FirebaseDatabase.instance.ref();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.className!??""),),
      body: Column(
        children: [
          Expanded(flex: 8,
            child: Container(margin: EdgeInsets.all(10),
              child: FirebaseAnimatedList(
                query:databaseReference.child(widget.className!),
                itemBuilder: (context, snapshot, animation, index) {
                  return snapshot.child("message").value.toString().contains("https://firebasestorage.googleapis.com/v0/b/notifyme-59aae.appspot.com/o/notificationImage%")?Container(
                      child: InkWell(onTap: (){
                        showDialog(context: context, builder: (context) {
                          return AlertDialog(
                            title: Text("Do You want to delete this message"),
                            actions: [
                              Row(mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  TextButton(onPressed: (){
                                    Navigator.pop(context);
                                  }, child: Text("Cancle")),
                                  TextButton(onPressed: (){
                                    databaseReference.child(snapshot.key!).remove();
                                    Navigator.pop(context);
                                  }, child: Text("Delete")),
                                ],
                              )
                            ],

                          );
                        },);
                      },
                        child: Column(
                          children: [Image.network(snapshot.child("message").value.toString()),
                            Text(snapshot.child("date").value.toString()),
                          ],
                        ),
                      )
                  ):Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20)
                    ),
                    margin: EdgeInsets.only(bottom: 10),
                    child: ListTile(
                      onTap: () {
                        showDialog(context: context, builder: (context) {
                          return AlertDialog(
                            title: Text("Do You want to delete this message"),
                            actions: [
                              Row(mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  TextButton(onPressed: (){
                                    Navigator.pop(context);
                                  }, child: Text("Cancle")),
                                  TextButton(onPressed: (){
                                    databaseReference.child(snapshot.key!).remove();
                                    Navigator.pop(context);
                                  }, child: Text("Delete")),
                                ],
                              )
                            ],
                          );
                        },);
                      },
                      title: Text(snapshot.child("message").value.toString()),
                      subtitle: Text(snapshot.child("date").value.toString()),
                    ),
                  );
                },
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Row(
              children: [
                Expanded(flex: 3,
                  child: Container(
                    margin: EdgeInsets.only(left: 10),
                    child: TextField(controller: messageController,
                      decoration:InputDecoration(border: OutlineInputBorder()),),
                  ),
                ),
                IconButton(onPressed: (){
                  DateTime datetime=DateTime.now();
                  databaseReference.child(widget.className!).push().set({"message":messageController.text,"date":DateFormat('yyyy-MM-dd HH:mm:ss').format(datetime)});
                  messageController.clear();
                }, icon: Icon(Icons.send))
              ],
            ))
        ],
      ),
    );
  }
}
