import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notificationapp/screen/login/loginscreen.dart';

class SignUP extends StatelessWidget {
  SignUP({Key? key}) : super(key: key);
  TextEditingController emailContoller = TextEditingController();
  TextEditingController passwordContoller = TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance;

  createUserWithEmailAndPassword() async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: emailContoller.text,
        password: passwordContoller.text,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print("the error is ${e}");
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
            Form(
                child: Column(
              children: [
                Container(
                  margin: EdgeInsets.all(10),
                  child: TextFormField(
                    controller: emailContoller,
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.email),
                          border: OutlineInputBorder(),
                          label: Text("Enter Your Email"))),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10, right: 10, left: 10),
                  child: TextFormField(
                    controller: passwordContoller,
                      autocorrect: false,
                      keyboardType: TextInputType.visiblePassword,
                      maxLength: 16,
                      obscureText: false,
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.password),
                          border: OutlineInputBorder(),
                          label: Text("Password"))),
                ),
              ],
            )),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () async {
                      await _auth.createUserWithEmailAndPassword(
                        email: emailContoller.text,
                        password: passwordContoller.text,
                      );
                    },
                    child: Text("  Sign Up  ")),
              ],
            )
          ],
        ),
      ),
    ));
  }
}
