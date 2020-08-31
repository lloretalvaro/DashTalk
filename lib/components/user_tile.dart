import 'package:flutter/material.dart';
import 'package:dash_talk/constants.dart';

class UserTile extends StatelessWidget {
  UserTile(
      {@required this.username,
      @required this.email,
      @required this.screenToNavigate});
  final String username;
  final String email;
  final String screenToNavigate;

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
        onTap: () => Navigator.pushNamed(context, screenToNavigate),
      ),
    );
  }
}
