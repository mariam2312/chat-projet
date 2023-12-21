// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api, avoid_print, await_only_futures, unnecessary_null_comparison

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import '../constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _firestore = FirebaseFirestore.instance;
User? loggedInUser;

class ChatScreen extends StatefulWidget {
  static const String id = 'chat_screen';
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _auth = FirebaseAuth.instance;
  String? message;
  final massageTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Firebase.initializeApp().whenComplete(() {
      print("completed");
      getCurrentUser();
    });
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser!;
      if (user != null) {
        loggedInUser = user;
        print(loggedInUser?.email);
      }
    } catch (e) {
      print(e);
    }
  }

  // void getMessages() async {
  //   // final messageList = await _firestore.collection('messages').get();
  //   // for (var myMessage in messageList.docs) {
  //   //   print(myMessage.data);
  //   // }
  //   await _firestore.collection("messages").get().then((event) {
  //     for (var doc in event.docs) {
  //       print("${doc.id} => ${doc.data()}");
  //     }
  //   });
  // }
  // function => to get data from firestore real time change  .
  // void messageStream() async {
  //   await for (var snapshot in _firestore.collection('messages').snapshots()) {
  //     for (var message in snapshot.docs) {
  //       print("${message.data()}");
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                // messageStream();
                //Implement logout functionality
                _auth.signOut();
                Navigator.pop(context);
              }),
        ],
        title: const Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const MassagesStream(),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: massageTextController,
                      onChanged: (value) {
                        //Do something with the user input.
                        message = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  FloatingActionButton(
                    heroTag: null,
                    onPressed: () {
                      //Implement send functionality.
                      // two filed 1.text,2.loggedInEmail
                      _firestore.collection('messages').add(
                          {'text': message, 'sender': loggedInUser!.email});

                      massageTextController.clear();
                    },
                    child: const Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MassageBubble extends StatelessWidget {
  const MassageBubble(
      {required this.sender, required this.text, required this.isMe});
  final String sender;
  final String text;
  final bool isMe;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            sender,
            style: const TextStyle(
                fontSize: 15,
                color: Colors.black54,
                fontWeight: FontWeight.bold),
          ),
          Material(
            borderRadius: isMe
                ? const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30))
                : const BorderRadius.only(
                    topRight: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30)),
            elevation: 5,
            color: isMe ? Colors.lightBlueAccent : Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text(
                '$text ',
                style: TextStyle(
                    color: isMe ? Colors.white : Colors.black54, fontSize: 18),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MassagesStream extends StatelessWidget {
  const MassagesStream();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('messages').snapshots(),
        builder: (context, snapshot) {
          List<MassageBubble> messageBubbles = [];
          if (snapshot.hasData) {
            //reversed to show massage
            final massages = snapshot.data?.docs.toList().reversed;
            for (var massage in massages!) {
              final massageText = massage['text'];
              final massageSender = massage['sender'];
              final currentUser = loggedInUser?.email;
              // massage from user
              if (currentUser == massageSender) {}
              //Text('$massageText from $massageSender',style: TextStyle(),);}
              final massageBubble = MassageBubble(
                sender: massageSender,
                text: massageText,
                isMe: currentUser == massageSender,
              );
              messageBubbles.add(massageBubble);
            }
          }
          return Expanded(
            child: ListView(
              // last massage appear in screen
              reverse: true,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              children: messageBubbles,
            ),
          );
        });
    // for (var snapshot in _firestore.collection('messages').snapshots()) {
    //for (var message in snapshot.data.docs) {
    //print("${message.data()}");
    //final messages = snapshot.data?.docs;

    // for (int i = 0; i < snapshot.data!.docs.length; i++) {
    //   //for (var message in messages!) {
    //   // final messageText = message.data['text'];
    //   //final messageSender = message.data['sender'];
    //   final messageText = snapshot.data!.docs[i].data();
    //   //${snapshot.data!.docs[i].data()['text']
    //   // "${snapshot.data!.docs[i].data()['text']}"
    //   final messageWidget = Text("${messageText}");
    //   messageList.add(messageWidget);
    //   // print(messageList);
    // }
    //}
    // return Column(
    //       children: messageList,
    //     );
    //   },
    // ),
  }
}
