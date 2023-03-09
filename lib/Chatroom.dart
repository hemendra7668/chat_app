import 'package:flutter/material.dart';

class Chatroom extends StatefulWidget {
  const Chatroom({super.key});

  @override
  State<Chatroom> createState() => _ChatroomState();
}

class _ChatroomState extends State<Chatroom> {
  TextEditingController msgcontrol = TextEditingController();
  bool _isTextFilled = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
          child: Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * .7,
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
