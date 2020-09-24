import 'package:flutter/material.dart';
import 'package:dash_talk/constants.dart';
import 'package:dash_talk/screens/welcome_screen.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dash_talk/components/user_tile.dart';

final _firestore = Firestore.instance;
final _auth = FirebaseAuth.instance;
FirebaseUser loggedInUser;

class ChatSelectionScreen extends StatefulWidget {
  static const id = '/selection';
  @override
  _ChatSelectionScreenState createState() => _ChatSelectionScreenState();
}

class _ChatSelectionScreenState extends State<ChatSelectionScreen> {
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
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          'DashTalk 🗣️',
          style: TextStyle(fontSize: MediaQuery.of(context).size.width / 15),
        ),
        backgroundColor: kAppBarColor,
      ),
      body: Center(
        child: Container(
          color: Colors.indigo[800],
          child: UsersStream(),
        ),
      ),
    );
  }
}

class UsersStream extends StatelessWidget {
  int getASCIIvalue(String text) {
    int valueString = 0;
    for (int i = 0; i < text.length; i++) {
      valueString += text.codeUnitAt(i);
    }
    return valueString;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _firestore.collection('users').orderBy('uid').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.teal,
            ),
          );
        }
        final users = snapshot.data.documents.reversed;
        List<UserTile> userSelectors = [
          UserTile(
            username: 'Global Chat 🗣️',
            email: 'Join and talk with all users!',
            collectionName: 'messages',
          )
        ];

        int asciiValueLoggedInUserUid = getASCIIvalue(loggedInUser.uid);
        for (var user in users) {
          final userUsername = user.data['username'];
          final userEmail = user.data['email'];
          final userUid = user.data['uid'];
          UserTile userTile;

          if (loggedInUser.uid != userUid) {
            String collectionName = 'messages';
            if (asciiValueLoggedInUserUid >= getASCIIvalue(userUid)) {
              collectionName += loggedInUser.uid;
              collectionName += userUid;
            } else {
              collectionName += userUid;
              collectionName += loggedInUser.uid;
            }

            userTile = UserTile(
              username: userUsername,
              email: userEmail,
              collectionName: collectionName,
            );
            userSelectors.add(userTile);
          }
        }
        return Expanded(
          child: ListView(
            padding: EdgeInsets.symmetric(vertical: 7, horizontal: 7),
            children: userSelectors,
          ),
        );
      },
    );
  }
}
