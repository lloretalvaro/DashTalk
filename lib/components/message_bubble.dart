import 'package:flutter/material.dart';
import 'package:dash_talk/constants.dart';

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
            style: kUsernameMessageTextStyle,
          ),
          SizedBox(height: 1.5),
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
                style: kTextMessageTextStyle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
