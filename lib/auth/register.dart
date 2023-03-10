import 'dart:math';

import 'package:chat_app/auth/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final db = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  Future<void> createuser(String uid, String email, String name) async {
    await db.collection("Users").doc(uid).set({
      "uid": uid,
      "fullname": namecontrol,
      "email": emailcontrol,
    });
  }

  TextEditingController namecontrol = TextEditingController();
  TextEditingController emailcontrol = TextEditingController();
  TextEditingController passcontrol = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("register"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
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
                  onPressed: () async {
                    try {
                      FirebaseAuth auth = FirebaseAuth.instance;
                      User? active = await FirebaseAuth.instance.currentUser;
                      var user = FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                              email: emailcontrol.text,
                              password: passcontrol.text)
                          // .then((value) => createuser(value.uid, value.emailcontrol, value.name))
                          .then((value) => FirebaseFirestore.instance
                                  .collection("users")
                                  .doc(value.user!.uid)
                                  .set({
                                "uid": value.user!.uid,
                                "name": namecontrol.text,
                                "email": value.user!.email
                              }));
                    } catch (e) {
                      print(e);
                    }
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
      ),
    );
  }
}
