import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController name = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text("Chat App"),
          actions: [
            IconButton(
              icon: Icon(Icons.logout_outlined),
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
            )
          ],
        ),
        body: Container(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                    controller: name,
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 15.0, horizontal: 15.0),
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "Search Name or Post ",
                        labelText: "Search...",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide: const BorderSide(width: 0.5)),
                        suffixIcon: IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.search_rounded)))),
              )
            ],
          ),
        ));
  }
}
