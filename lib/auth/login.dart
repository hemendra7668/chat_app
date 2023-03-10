import 'package:chat_app/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailcontrol = TextEditingController();
    TextEditingController passcontrol = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text("login into your accont"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TextFormField(
                controller: emailcontrol,
                decoration: InputDecoration(hintText: "enter your mail id")),
            TextFormField(
                controller: passcontrol,
                decoration: InputDecoration(hintText: "Enter your Password")),
            SizedBox(
              height: 50.0,
            ),
            ElevatedButton(
                onPressed: () async {
                  try {
                    var users = await FirebaseAuth.instance
                        .signInWithEmailAndPassword(
                            email: emailcontrol.text,
                            password: passcontrol.text)
                        .then((value) => Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Home())));
                  } on FirebaseException catch (ex) {
                    // Text("no user, found please register");
                    // ShowAlertDialog(context, "An error occured", ex.message.toString());

                    ScaffoldMessenger.of(context).showMaterialBanner(
                        MaterialBanner(
                            content: Text("no user found"),
                            actions: [
                          TextButton(
                              onPressed: () {
                                ScaffoldMessenger.of(context)
                                    .hideCurrentMaterialBanner();
                                Navigator.pop(context);
                              },
                              child: Text("ok"))
                        ]));
                  }
                },
                child: Text("login"))
          ],
        ),
      ),
    );
  }
}
