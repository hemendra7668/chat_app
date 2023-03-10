// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';

import 'package:chat_app/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:chat_app/model/ChatRoomModel.dart';
import 'package:chat_app/model/MessageModel.dart';
import 'package:chat_app/model/UserModel.dart';

import 'home.dart';

class Chatroom extends StatefulWidget {
  final UserModel targetuser;
  final ChatRoomModel chatroomod;
  final User firebaseuser;
// final UserModel
  const Chatroom({
    Key? key,
    required this.targetuser,
    required this.chatroomod,
    required this.firebaseuser,
  }) : super(key: key);

  @override
  State<Chatroom> createState() => _ChatroomState();
}

class _ChatroomState extends State<Chatroom> {
  TextEditingController msgcontrol = TextEditingController();
  bool _isTextFilled = false;

  void sendmessage() async {
    String msg = msgcontrol.text.trim();
    if (msg != null) {
      MessageModel msgmod = MessageModel(
          messageid: uuid.v1(),
          text: msg,
          createdon: DateTime.now(),
          sender: currentUser!.uid,
          seen: false);

// FirebaseFirestore.instance.collection("chatrooms").doc().
    } else {}
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            // Text(targetuser.uid.toString()),

            Container(
              color: Color.fromARGB(255, 203, 200, 190),
              height: 60.0,
            ),
            Container(
              color: Color.fromARGB(255, 216, 209, 188),
              height: 60.0,
            ),
            Container(
              color: Color.fromARGB(255, 141, 231, 85),
              height: 60.0,
            ),
            Container(
              color: Color.fromARGB(255, 141, 210, 149),
              height: 60.0,
            ),
            Container(
              color: Color.fromARGB(255, 169, 217, 190),
              height: 60.0,
            ),
            Container(
              color: Color.fromARGB(255, 162, 167, 240),
              height: 60.0,
            ),
            Container(
              color: Color.fromARGB(255, 230, 228, 224),
              height: 60.0,
            ),
            Container(
              color: Color.fromARGB(255, 191, 148, 240),
              height: 60.0,
            ),
            Container(
              color: Color.fromARGB(255, 220, 148, 198),
              height: 60.0,
            ),
            Container(
              color: Colors.amber,
              height: 60.0,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 60.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15.0),
                      topRight: Radius.circular(15.0)),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * .9,
                      height: MediaQuery.of(context).size.height * .1,
                      child: TextFormField(
                        cursorColor: Colors.green,
                        autocorrect: true,
                        controller: msgcontrol,
                        textAlign: TextAlign.start,
                        decoration: InputDecoration(
                          labelStyle: TextStyle(
                              color: Color.fromARGB(255, 81, 187, 104)),
                          labelText: "enter message",
                          suffixIcon: _isTextFilled
                              ? IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.send,
                                    color: Colors.green,
                                  ),
                                )
                              : null,
                          border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(18))),
                          hintText: "Enter something to Chats ",
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      color: Color.fromARGB(255, 48, 220, 53),
                      onPressed: () {},
                      icon: Icon(Icons.attach_file),
                    ),

                    SizedBox(width: 4),
                    // if(tcontroller.text!=null)
                  ],
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
