import 'package:flutter/material.dart';

const kMessageTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  hintText: 'Type here...',
  hintStyle: TextStyle(color: Colors.grey),
  border: InputBorder.none,
);

const kMessageContainerDecoration = BoxDecoration(
  border: Border(
    top: BorderSide(color: Colors.teal, width: 0.2),
  ),
);

const kTextFieldDecoration = InputDecoration(
  hintText: 'Enter your value',
  hintStyle: TextStyle(color: Color(0xFFBDBDBD)),
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(18.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.teal, width: 1.5),
    borderRadius: BorderRadius.all(Radius.circular(18.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.teal, width: 2.5),
    borderRadius: BorderRadius.all(Radius.circular(18.0)),
  ),
);

const kLoginColor = Color(0xFFab559b);
const kRegisterColor = Color(0xFF91307f);
const kAppBarColor = Color(0xFF212833);
const kSendMessageButtonColor = Colors.teal;

const kBorderRadiusCurrentUser = BorderRadius.only(
  topLeft: Radius.circular(15),
  topRight: Radius.circular(15),
  bottomLeft: Radius.circular(15),
);

const kBorderRadiusOtherUser = BorderRadius.only(
  topRight: Radius.circular(15),
  topLeft: Radius.circular(15),
  bottomRight: Radius.circular(15),
);
