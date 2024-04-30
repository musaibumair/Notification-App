import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  var databaseReference=FirebaseDatabase.instance.ref("Message");
  TextEditingController messageController=TextEditingController();
  ImagePicker imagePicker=ImagePicker();
  firebase_storage.FirebaseStorage storage=firebase_storage.FirebaseStorage.instance;
  File? file;

  uploadImage(File? fileUrl)async{
    DateTime time=DateTime.now();
    firebase_storage.Reference ref=firebase_storage.FirebaseStorage.instance.ref('/notificationImage/'+time.microsecondsSinceEpoch.toString());
    firebase_storage.UploadTask upload=ref.putFile(fileUrl!.absolute);
    await Future.value(upload);
    var newUrl=await ref.getDownloadURL();
    sendMessage(newUrl.toString());
  }
  sendMessage(String message){
    DateTime dateTime=DateTime.now();
    if(message.isEmpty){
      print("o hello");
    }
    else{
      databaseReference.push().set({'key':dateTime.microsecondsSinceEpoch,'message':message,"date":DateFormat('yyyy-MM-dd HH:mm:ss').format(dateTime)}).catchError((error){
        print("the error is ${error}");
      });
    }
  }

  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Notifications"),),
      body: Column(
        children: [
          Expanded(flex: 8,
              child: Container(margin: EdgeInsets.all(10),
                child: FirebaseAnimatedList(
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
              ),
    ),
          Expanded(flex: 2,
              child: Container(height: 40,
                margin: EdgeInsets.only(left: 20,right: 20,),
                child: Row(children: [
                  Expanded(flex: 9,
                    child: TextField(maxLines: 1,
                      controller: messageController,
                      decoration: InputDecoration(suffixIcon: IconButton(onPressed: (){
                        showDialog(context: context, builder:(context) {
                          return AlertDialog(title: Text("Pick the image from"),
                            actions: [
                              TextButton(onPressed: ()async{
                           var image= await imagePicker.pickImage(source: ImageSource.gallery);
                           if(image!=null){
                             file=File(image.path);
                             uploadImage(file);
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => NotificationScreen(),));
                           }
                           else{
                             Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => NotificationScreen(),));
                           }
                              }, child: Text("Gallery")),
                              TextButton(onPressed: ()async{
                                var image=await imagePicker.pickImage(source: ImageSource.camera);
                                if(image!=null){
                                  file=File(image.path);
                                  uploadImage(file);
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => NotificationScreen(),));
                                }
                                else{
                                   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => NotificationScreen(),));
                                }
                              }, child: Text("camera")),
                            ],
                          );
                        },);
                      },icon: Icon(Icons.image),),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25)
                          )),
                    ),
                  ),
                  Expanded(flex: 1,
                      child: IconButton(onPressed: (){
                        sendMessage(messageController.text);
                        messageController.clear();
                      },icon: Icon(Icons.send),))
                ],),
              )),
        ],
      ),
    );
  }
}
