import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notificationapp/screen/admindashBoard/addmindashboard.dart';
import 'package:notificationapp/screen/login/loginscreen.dart';
import 'package:notificationapp/screen/studentdashboard/bottom-navigator-bar.dart';

import '../teacherdashboard/bottom-navigator-bar.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var user=FirebaseAuth.instance.currentUser;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(user!=null){
      if(user!.email.toString().contains("admin")){
        Timer(Duration(seconds: 3),() => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
          return AdminDashBoard();
        },)),);
      }
      else if(user!.email.toString().contains("pujc.edu.pk")){
        Timer(Duration(seconds: 3),() => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
          return BottomNabBarforTeacher();
        },)),);
      }
      else{
        Timer(Duration(seconds: 3),() => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
          return BottomNabBar();
        },)),);
      }
    }
    else{
      Timer(Duration(seconds: 3),() => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return LoginScreen();
      },)),);
    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor:Colors.black,body: Container(
      width: double.infinity,
      child: Column(
        children: [ Expanded(
          flex: 2,
          child: Column(children: [
            Expanded(
              child: Container(margin: EdgeInsets.only(top: 100),
                  width:200,child: Image(image:AssetImage("lib/assets/image/logo.png") )),
            ),
            Text("UNIVERSTY OF THE PUNJAB",style: TextStyle(fontSize: 20,color: Colors.white),),
            SizedBox(height: 100,)
          ],
          ),
        ),Expanded(flex:1,child: Column(
          children: [Text("Welcome",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.white),),
          Text("jklds kjsakd kjlksadj lkjdkjsa jjsha jdkjhsakj jhdjsah",style: TextStyle(color: Colors.white60),)],
        ))],
      ),
    ),);
  }
}
