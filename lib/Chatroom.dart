// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:developer';
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
  final UserModel userm;
// final UserModel
  const Chatroom({
    Key? key,
    required this.targetuser,
    required this.chatroomod,
    required this.firebaseuser,
    required this.userm,
  }) : super(key: key);

  @override
  State<Chatroom> createState() => _ChatroomState();
}

class _ChatroomState extends State<Chatroom> {
  TextEditingController msgcontrol = TextEditingController();
  bool _isTextFilled = false;
  @override
  void initState() {
    super.initState();
    msgcontrol.addListener(() {
      setState(() {
        _isTextFilled = msgcontrol.text.isNotEmpty;
      });
    });
  }

  void sendmessage() async {
    String msg = msgcontrol.text.trim();
    msgcontrol.clear();
    if (msg != null) {
      MessageModel msgmod = MessageModel(
          messageid: uuid.v1(),
          text: msg,
          createdon: DateTime.now(),
          sender: widget.userm.uid,
          seen: false);

      FirebaseFirestore.instance
          .collection("chatrooms")
          .doc(widget.chatroomod.chatroomid)
          .collection("messages")
          .doc(msgmod.messageid)
          .set(msgmod.toMap());
      print("message sent");
      log("sent");
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.targetuser.name}"),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: SizedBox(
          height: 600,
          width: 550,
          child: Column(
            children: [
              Expanded(
                child: Container(
                  // width: MediaQuery.of(context).size.width * 9,
                  // height: MediaQuery.of(context).size.height * 9,
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("chatrooms")
                        .doc(widget.chatroomod.chatroomid)
                        .collection("messages")
                        .orderBy("createdon", descending: true)
                        .snapshots(),
                    // initialData: initialData,
                    builder: (context, snapshot) {
                      // if (snapshot.connectionState == ConnectionState.active) {
                      if (snapshot.hasData) {
                        log("${snapshot.data!.docs.length}");
                        QuerySnapshot dataSnapshot =
                            snapshot.data as QuerySnapshot;

                        return ListView.builder(
                          reverse: true,
                          // shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          itemCount: dataSnapshot.docs.length,
                          itemBuilder: (context, index) {
                            MessageModel currentMessage = MessageModel.fromMap(
                                dataSnapshot.docs[index].data()
                                    as Map<String, dynamic>);
                            return Row(
                              mainAxisAlignment:
                                  (currentMessage.sender == widget.userm.uid)
                                      ? MainAxisAlignment.end
                                      : MainAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.symmetric(vertical: 2),
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 10),
                                  decoration: BoxDecoration(
                                    color: (currentMessage.sender ==
                                            widget.userm.uid)
                                        ? Colors.grey
                                        : Colors.amber,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Text(
                                    currentMessage.text.toString(),
                                    style: const TextStyle(
                                      color: Color.fromARGB(255, 235, 43, 43),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      } else {
                        return Text('No data available');
                      }
                      // }
                      // else{
                      //   return Center(child: CircularProgressIndicator());
                      // }
                    },
                  ),
                ),
              ),

              // Text("${widget.userm}"),
              // Text("${widget.targetuser}"),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 60.0,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15.0),
                        topRight: Radius.circular(15.0)),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * .85,
                        height: MediaQuery.of(context).size.height * .1,
                        child: TextFormField(
                          cursorColor: Colors.green,
                          autocorrect: true,
                          controller: msgcontrol,
                          textAlign: TextAlign.start,
                          decoration: InputDecoration(
                            labelStyle: const TextStyle(
                                color: Color.fromARGB(255, 81, 187, 104)),
                            labelText: "enter message",
                            suffixIcon: _isTextFilled
                                ? IconButton(
                                    onPressed: () {
                                      setState(() {
                                        sendmessage();
                                      });
                                    },
                                    icon: const Icon(
                                      Icons.send,
                                      color: Color.fromARGB(255, 83, 212, 88),
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
                        color: const Color.fromARGB(255, 48, 220, 53),
                        onPressed: () {},
                        icon: const Icon(Icons.attach_file),
                      ),

                      const SizedBox(width: 4),
                      // if(tcontroller.text!=null)
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
