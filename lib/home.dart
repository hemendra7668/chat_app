import 'dart:developer';

import 'package:chat_app/Chatroom.dart';
import 'package:chat_app/model/ChatRoomModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

import 'model/UserModel.dart';

class Home extends StatefulWidget {
  const Home({super.key});
// final UserModel usermodel;
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  User? currentUser = FirebaseAuth.instance.currentUser;
  // UserModel? thisUserModel = await FirebaseHelper.getUserModelById(currentUser.uid);
  TextEditingController name = TextEditingController();

  Future<ChatRoomModel?> getChatroomModel(UserModel targetuser) async {
    QuerySnapshot querysnap = await FirebaseFirestore.instance
        .collection("chatrooms")
        .where("participants.${currentUser!.uid}", isEqualTo: true)
        .where("partcipants.${targetuser.uid}", isEqualTo: true)
        .get();
    if (querysnap.docs.length > 0) {
      log("chat already");
    } else {
      log("message not");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
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
                            onPressed: () {
                              setState(() {});
                            },
                            icon: Icon(Icons.search_rounded)))),
              ),
              Container(
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("users")
                      .where("email", isEqualTo: name.text)
                      // .where("email", isNotEqualTo: Widget.Usermode.email)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.active) {
                      if (snapshot.hasData) {
                        QuerySnapshot datasnapshot =
                            snapshot.data as QuerySnapshot;
                        if (datasnapshot.docs.length > 0) {
                          Map<String, dynamic> usermap = datasnapshot.docs[0]
                              .data() as Map<String, dynamic>;
                          UserModel searcheduser = UserModel.fromMap(usermap);
                          return ListTile(
                            title: Text(searcheduser.name!),
                            // title: Text(searcheduser.uid!),
                            subtitle: Text(searcheduser.email!),
                            trailing: IconButton(
                                onPressed: () async {
                                  ChatRoomModel? chatroom =
                                      await getChatroomModel(searcheduser);
                                  // Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //       builder: (context) => Chatroom(),
                                  //     ));
                                },
                                icon: Icon(Icons.message_rounded)),
                          );
                        } else {
                          return Text("No Result Found");
                        }
                        // } else if (snapshot.hasError) {
                      } else {
                        return Text("No Result Found");
                      }
                    } else {
                      return Container(
                          alignment: Alignment.center,
                          child: CircularProgressIndicator());
                    }
                  },
                ),
              )
            ],
          ),
        ));
  }
}
