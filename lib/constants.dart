import 'package:flutter/material.dart';

const kAnimatedTextStyle = TextStyle(
  color: Colors.white,
  fontSize: 56.0,
  fontWeight: FontWeight.w900,
);

const kErrorAlertTextStyle = TextStyle(
  color: Colors.white,
  fontSize: 23,
  fontWeight: FontWeight.w700,
  decoration: TextDecoration.none,
);

const kMessageTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  hintText: 'Type here...',
  hintStyle: TextStyle(color: Colors.grey, fontSize: 22),
  border: InputBorder.none,
);

const kMessageContainerDecoration = BoxDecoration(
  border: Border(
    top: BorderSide(color: Colors.teal, width: 0.2),
  ),
);

const kUsernameMessageTextStyle = TextStyle(
  color: Color(0xFF757575),
  fontSize: 18,
);

const kTextMessageTextStyle = TextStyle(
  color: Colors.white,
  fontSize: 24,
);
const double kLogoSizeWelcomeScreen = 95.0;
const double kLogoSizeLoginRegistration = 210.0;
const double kIconSizeLoginRegistration = 29.0;
const Color kIconColorLoginRegistration = Colors.greenAccent;

const kLoginRegistrationTextStyle = TextStyle(
  color: Colors.white,
  fontSize: 23,
  fontWeight: FontWeight.w500,
);

const kUsernameChatSelectorTextStyle = TextStyle(
  color: Colors.white,
  fontSize: 25,
  fontWeight: FontWeight.w500,
);

const kEmailChatSelectorTextStyle = TextStyle(
  color: Color(0xFFBDBDBD),
  fontSize: 20,
);

const kTextFieldDecoration = InputDecoration(
  hintText: 'Enter your value',
  hintStyle: TextStyle(
    color: Color(0xFFBDBDBD),
    fontSize: 23,
  ),
  contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 25.0),
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

const kAppbarTitleTextStyle = TextStyle(fontSize: 25, letterSpacing: 1);
const kTextfieldMessageTextStyle =
    TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w500);

const double kIconSizeChatScreen = 31;
