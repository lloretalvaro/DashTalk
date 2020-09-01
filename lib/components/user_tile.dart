import 'package:dash_talk/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:dash_talk/constants.dart';

class UserTile extends StatelessWidget {
  UserTile({
    @required this.username,
    @required this.email,
    @required this.collectionName,
  });
  final String username;
  final String email;
  final String collectionName;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: kAppBarColor,
        borderRadius: BorderRadius.circular(11),
      ),
      margin: EdgeInsets.symmetric(vertical: 9),
      child: ListTile(
        leading: Icon(
          Icons.send,
          color: Colors.teal,
        ),
        title: Text(
          username,
          style: kUsernameChatSelectorTextStyle,
        ),
        subtitle: Text(
          email,
          style: kEmailChatSelectorTextStyle,
        ),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatScreen(
              title: username,
              collectionName: collectionName,
            ),
          ),
        ),
      ),
    );
  }
}
