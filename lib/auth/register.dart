import 'package:chat_app/auth/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController namecontrol = TextEditingController();
  TextEditingController emailcontrol = TextEditingController();
  TextEditingController passcontrol = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: <Widget>[
            Text(
              "Register your self",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 40.0),
            ),
            TextFormField(
              controller: namecontrol,
              decoration: InputDecoration(hintText: "enter your name"),
            ),
            TextFormField(
                controller: emailcontrol,
                decoration: InputDecoration(hintText: "enter your mail id")),
            TextFormField(
                controller: passcontrol,
                decoration: InputDecoration(hintText: "Enter your Password")),
            TextFormField(
                decoration:
                    InputDecoration(hintText: "re-enter your mail password")),
            SizedBox(height: 30.0),
            ElevatedButton(
                onPressed: () {
                  var user = FirebaseAuth.instance
                      .createUserWithEmailAndPassword(
                          email: emailcontrol.text, password: passcontrol.text);
                },
                child: Text("Submit & Register")),
            SizedBox(height: 30.0),
            Row(
              children: [
                Text("already user,"),
                TextButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Login()));
                    },
                    child: Text("login"))
              ],
            )
          ],
        ),
      ),
    );
  }
}
