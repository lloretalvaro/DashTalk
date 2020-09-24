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
      padding: const EdgeInsets.all(7.0),
      child: Column(
        crossAxisAlignment:
            isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            '$userName',
            style: kUsernameMessageTextStyle.copyWith(
                fontSize: MediaQuery.of(context).size.width / 30),
          ),
          SizedBox(height: 1.5),
          Material(
            borderRadius: isCurrentUser
                ? kBorderRadiusCurrentUser
                : kBorderRadiusOtherUser,
            elevation: 8,
            color: isCurrentUser ? Colors.indigoAccent : Colors.deepPurple,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 13),
              child: Text(
                '$text',
                style: kTextMessageTextStyle.copyWith(
                    fontSize: MediaQuery.of(context).size.width / 21),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
