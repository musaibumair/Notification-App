import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notificationapp/screen/signup/signup.dart';
import 'package:notificationapp/screen/teacherdashboard/bottom-navigator-bar.dart';
import '../admindashBoard/addmindashboard.dart';
import '../studentdashboard/bottom-navigator-bar.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailContoller = TextEditingController();
  TextEditingController passwordContoller = TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance;
  var credential;

  signInWithEmailAndPassword()async{
    try {
       await _auth.signInWithEmailAndPassword(
          email: emailContoller.text,
          password: passwordContoller.text
      ).then((value){
         if(emailContoller.text.contains("admin")){
           Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AdminDashBoard(),));
         }else if(emailContoller.text.contains("pujc.edu.pk")){
           Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => BottomNabBarforTeacher(),));
         }
         else{
           Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>BottomNabBar()));
         }
       });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Container(
                width: double.infinity,
                child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 100),
              child: Image(
                image: AssetImage("lib/assets/image/logo.png"),
                width: 100,
              ),
            ),
            Text(
              "Notify Me",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Form(child: Column(children: [
              Container(
                margin: EdgeInsets.all(10),
                child: TextFormField(
                  controller: emailContoller,
                    decoration: InputDecoration(prefixIcon: Icon(Icons.email),
                        border: OutlineInputBorder(),
                        label: Text("Enter Your Email"))),
              ),
              Container(
                margin: EdgeInsets.only(top: 10,right: 10,left: 10),
                child: TextFormField(controller: passwordContoller,
                    autocorrect: false,
                    keyboardType: TextInputType.visiblePassword,maxLength: 16,
                    obscureText: false,
                    decoration: InputDecoration(prefixIcon: Icon(Icons.password),
                        border: OutlineInputBorder(), label: Text("Password"))),
              ),],)),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(margin: EdgeInsets.only(right: 10),child: TextButton(onPressed: (){}, child: Text("Forget password")))
              ],
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(onPressed: () {
                  signInWithEmailAndPassword();
                 // await _auth.signInWithEmailAndPassword(email: emailContoller.text, password: passwordContoller.text);
                  // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AdminDashBoard()));
                }, child: Text("  Login  ")),
              ],
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Don`t have any account"),
                TextButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return SignUP();
                  },));
                }, child:Text("Sign Up"))
              ],
            )
          ],
                ),
              ),
        ));
  }
}
