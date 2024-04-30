import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notificationapp/screen/admindashBoard/notification.dart';
import 'package:notificationapp/screen/login/loginscreen.dart';
class AdminDashBoard extends StatefulWidget {
  const AdminDashBoard({Key? key}) : super(key: key);

  @override
  State<AdminDashBoard> createState() => _appBarState();
}

class _appBarState extends State<AdminDashBoard> {
  FirebaseAuth auth=FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(width: double.infinity,
            decoration:BoxDecoration(color: Colors.indigo,borderRadius: BorderRadius.all(Radius.circular(20))),
            height: 200,
          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(margin: EdgeInsets.only(top: 30,right: 10),
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(onPressed: (){
                     auth.signOut();
                     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen(),));
                    }, icon:Icon(Icons.logout,color: Colors.white,)),
                    CircleAvatar(child: Image(image: AssetImage("lib/assets/image/logo.png")),)
                  ],
                ),
              ),
              Container(margin: EdgeInsets.only(left: 40),
                  child: Text("DashBoard",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 40,color: Colors.white),)),
              Container(margin: EdgeInsets.only(left: 40),
                  child: Text(auth.currentUser!.email.toString(),style: TextStyle(fontSize: 20,color: Colors.white54),)),
            ],
          ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
            Row(mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => NotificationScreen(),));
                },
                  child: Container(margin: EdgeInsets.only(top:20,right: 30,left: 20),
                    width: 150,
                    height: 140,
                    decoration:BoxDecoration(color: Colors.blue,borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Icon(Icons.notifications_active,size: 90,)
                  ),
                ),
                Container(width:150,
                  height: 140,
                  margin: EdgeInsets.only(top:20,right: 20,),
                  decoration:BoxDecoration(color: Colors.blue,borderRadius: BorderRadius.all(Radius.circular(20))),
                ),
              ],
            ),
            Row(mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(margin: EdgeInsets.only(top:30,right: 30,left: 20),
                  width: 150,
                  height: 140,
                  decoration:BoxDecoration(color: Colors.blue,borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: Container(
                    child: Icon(Icons.notifications_on_outlined,size: 60,),
                  ),
                ),
                Container(width:150,
                  height: 140,
                  margin: EdgeInsets.only(top:30,right: 20,),
                  decoration:BoxDecoration(color: Colors.blue,borderRadius: BorderRadius.all(Radius.circular(20))),
                ),
              ],
            ),
          ],)
        ],
      ),

    );
  }
}
