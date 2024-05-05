import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

import 'class-view.dart';

class GroupCreate extends StatefulWidget {
  const GroupCreate({super.key});

  @override
  State<GroupCreate> createState() => _GroupCreateState();
}

class _GroupCreateState extends State<GroupCreate> {
  TextEditingController nameController=TextEditingController();
  TextEditingController classController=TextEditingController();
  TextEditingController subjectController=TextEditingController();
  var databaseReference=FirebaseDatabase.instance.ref("Class Creation");

  createClass(){
    try{
      databaseReference.push().set({"Teacher Name":nameController.text,"Subject Name":subjectController.text,"Class Name":classController.text});
    }catch(error){
      print("error is ${error}");
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Class Creation"),),
      body: Container(
        child: FirebaseAnimatedList(query: databaseReference,itemBuilder: (context, snapshot, animation, index) {
         return ListTile(onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => GroupView(className: snapshot.child("Class Name").value.toString(),id: snapshot.key,),));},
             title: Text(snapshot.child("Class Name").value.toString()),
         subtitle: Text(snapshot.child("Subject Name").value.toString()+" - "+snapshot.child("Teacher Name").value.toString()),leading: CircleAvatar());
        },),
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        showDialog(context: context, builder:(context) {
          return AlertDialog(
            insetPadding: EdgeInsets.all(10),
            title: Text("Class Create"),
            actions: [
              Container(child: TextField(
                controller: nameController,
                decoration: InputDecoration(border: OutlineInputBorder(),label: Text("Name")),
              ),),SizedBox(
                height: 10,
              ),
              Container(child: TextField(
                controller: subjectController,
                decoration: InputDecoration(border: OutlineInputBorder(),label: Text("Subject")),
              ),),SizedBox(
                height: 10,
              ),
              Container(child: TextField(
                controller: classController,
                decoration: InputDecoration(border: OutlineInputBorder(),label: Text("Class")),
              ),),
              SizedBox(height: 10,),
              ElevatedButton(onPressed: (){
                createClass();
                Navigator.pop(context);
              }, child: Text("Class Create"))
            ],
          );
        },);
      },child: Icon(Icons.add),),
    );
  }
}
