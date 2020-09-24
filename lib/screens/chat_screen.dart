import 'package:dash_talk/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:dash_talk/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dash_talk/components/message_bubble.dart';

final _firestore = Firestore.instance;
FirebaseUser loggedInUser;

class ChatScreen extends StatefulWidget {
  ChatScreen({@required this.title, @required this.collectionName});
  static const id = '/chat';
  final String title;
  final String collectionName;

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _auth = FirebaseAuth.instance;
  String messageText;
  final messageTextController = TextEditingController();
  String username;
  String appbarTitle;
  String tableName;

  @override
  void initState() {
    super.initState();

    appbarTitle = widget.title;
    tableName = widget.collectionName;

    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        loggedInUser = user;
        //-----------------------------------------------------------
        // Getting the name of the user to display it on the messages
        final queryUserSnapshot = await _firestore
            .collection('users')
            .where('uid', isEqualTo: user.uid)
            .getDocuments();
        final queryUserDocumentSnapshotList = queryUserSnapshot.documents;

        //I write .first because the uid is unique for each user so the list should only have 1 element
        username = queryUserDocumentSnapshotList.first.data['username'];
        //-----------------------------------------------------------
      }
    } catch (e) {
      print(e);
    }
  }

  void sendMessage() async {
    messageTextController.clear();
    DateTime currentDate = DateTime.now();
    Timestamp timestampMessage = Timestamp.fromDate(currentDate);

    _firestore.collection(tableName).add({
      'text': messageText,
      'username': username,
      'sender': loggedInUser.email,
      'timeSent': timestampMessage
    });
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
          leading: SizedBox(),
          actions: <Widget>[
            IconButton(
                color: Colors.red,
                icon: Icon(
                  Icons.phonelink_erase,
                  size: MediaQuery.of(context).size.width / 13,
                ),
                onPressed: () {
                  //Implement logout functionality
                  _auth.signOut();
                  Navigator.pushNamed(context, WelcomeScreen.id);
                }),
          ],
          centerTitle: true,
          title: Text(
            appbarTitle,
            style: kAppbarTitleTextStyle.copyWith(
                fontSize: MediaQuery.of(context).size.width / 16),
          ),
          backgroundColor: kAppBarColor,
        ),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              MessagesStream(
                tableName: tableName,
              ),
              Container(
                decoration: kMessageContainerDecoration,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        style: kTextfieldMessageTextStyle.copyWith(
                          fontSize: MediaQuery.of(context).size.width / 18,
                        ),
                        controller: messageTextController,
                        onChanged: (value) {
                          messageText = value;
                        },
                        decoration: kMessageTextFieldDecoration,
                      ),
                    ),
                    FlatButton(
                      onPressed: () {
                        sendMessage();
                      },
                      child: Icon(
                        Icons.near_me,
                        size: MediaQuery.of(context).size.width / 13,
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
  MessagesStream({@required this.tableName});

  final String tableName;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _firestore.collection(tableName).orderBy('timeSent').snapshots(),
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
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
            children: messageBubbles,
          ),
        );
      },
    );
  }
}
