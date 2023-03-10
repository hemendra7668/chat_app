import 'dart:developer';

import 'package:chat_app/Chatroom.dart';
import 'package:chat_app/main.dart';
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
  UserModel? nuserModel;
  // DocumentSnapshot docSnap = await FirebaseFirestore.instance.collection("users").doc(currentUser?.uid).get();
  // UserModel? nuserModel = UserModel.fromMap(docSnap.data() as Map<String, dynamic>);
  Future<UserModel?> getUserModelById(String uid) async {
    DocumentSnapshot docSnap = await FirebaseFirestore.instance
        .collection("users")
        .doc(currentUser?.uid)
        .get();

    if (docSnap.data() != null) {
      UserModel? nuserModel =
          UserModel.fromMap(docSnap.data() as Map<String, dynamic>);
    }

    return nuserModel;
  }

  TextEditingController name = TextEditingController();
  ChatRoomModel? anotherchatroom;

  Future<ChatRoomModel?> getChatroomModel(UserModel targetuser) async {
    QuerySnapshot querysnap = await FirebaseFirestore.instance
        .collection("chatrooms")
        .where("participants.${currentUser!.uid}", isEqualTo: true)
        .where("partcipants.${targetuser.uid}", isEqualTo: true)
        .get();
    if (querysnap.docs.length > 0) {
      var docdata = querysnap.docs[0].data();
      ChatRoomModel existing =
          ChatRoomModel.fromMap(docdata as Map<String, dynamic>);
      anotherchatroom = existing;
    } else {
      ChatRoomModel newchatroom =
          ChatRoomModel(chatroomid: uuid.v1(), lastmessage: "", participants: {
        currentUser!.uid: true,
        targetuser.uid!: true,
      });
      await FirebaseFirestore.instance
          .collection("chatroom")
          .doc(newchatroom.chatroomid)
          .set(newchatroom.toMap());
      log("chatroom created");
      anotherchatroom = newchatroom;
    }
    return anotherchatroom;
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
                                  if (chatroom != null) {
                                    log(searcheduser.name.toString());
                                    log(chatroom.participants.toString());
                                    log(currentUser.toString());
                                    // ignore: use_build_context_synchronously
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => Chatroom(
                                            targetuser: searcheduser,
                                            firebaseuser: currentUser!,
                                            userm: nuserModel!,
                                            crm: chatroom,
                                          ),
                                        ));
                                  }
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
