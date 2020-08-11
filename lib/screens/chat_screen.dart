import 'package:flutter/material.dart';
import 'package:dash_talk/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _firestore = Firestore.instance;
FirebaseUser loggedInUser;

class ChatScreen extends StatefulWidget {
  static const id = '/chat';

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _auth = FirebaseAuth.instance;
  String messageText;
  final messageTextController = TextEditingController();
  String username;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        loggedInUser = user;
        //TODO: SE PUEDE HACER MEJOR PARA BUSCAR EL NOMBRE DE USUARIO?
        final users = await _firestore.collection('users').getDocuments();
        var userUID;
        for (var itUser in users.documents) {
          userUID = itUser.data['uid'];
          if (userUID == user.uid) {
            username = itUser.data['username'];
          }
        }
        //-----------------------------------------------------------
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('images/backgroundImage.jpg'),
              fit: BoxFit.fill)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          leading: null,
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  //Implement logout functionality
                  _auth.signOut();
                  Navigator.pop(context);
                }),
          ],
          title: Text('DashTalk 🗣️'),
          backgroundColor: kAppBarColor,
        ),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              MessagesStream(),
              Container(
                decoration: kMessageContainerDecoration,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w500),
                        controller: messageTextController,
                        onChanged: (value) {
                          //Do something with the user input.
                          messageText = value;
                        },
                        decoration: kMessageTextFieldDecoration,
                      ),
                    ),
                    FlatButton(
                      onPressed: () {
                        messageTextController.clear();
                        DateTime currentDate = DateTime.now();
                        Timestamp timestampMessage =
                            Timestamp.fromDate(currentDate);
                        //Implement send functionality.
                        _firestore.collection('messages').add({
                          'text': messageText,
                          'username': username,
                          'sender': loggedInUser.email,
                          'timeSent': timestampMessage
                        });
                      },
                      child: Icon(
                        Icons.near_me,
                        size: 30,
                        color: kSendMessageButtonColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MessagesStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _firestore.collection('messages').orderBy('timeSent').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.teal,
            ),
          );
        }
        final messages = snapshot.data.documents.reversed;
        List<MessageBubble> messageBubbles = [];
        for (var message in messages) {
          final messageText = message.data['text'];
          final messageSender = message.data['sender'];
          final messageUsername = message.data['username'];

          final messageBubble = MessageBubble(
            text: messageText,
            userName: messageUsername,
            isCurrentUser: messageSender == loggedInUser.email,
          );

          messageBubbles.add(messageBubble);
        }
        return Expanded(
          child: ListView(
            reverse: true,
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            children: messageBubbles,
          ),
        );
      },
    );
  }
}

class MessageBubble extends StatelessWidget {
  MessageBubble({this.text, this.userName, this.isCurrentUser});

  final String text;
  final String userName;
  final bool isCurrentUser;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:
            isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            '$userName',
            style: TextStyle(color: Colors.grey[600], fontSize: 13),
          ),
          SizedBox(height: 1),
          Material(
            borderRadius: isCurrentUser
                ? kBorderRadiusCurrentUser
                : kBorderRadiusOtherUser,
            elevation: 8,
            color: isCurrentUser ? Colors.indigoAccent : Colors.deepPurple,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: Text(
                '$text',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
