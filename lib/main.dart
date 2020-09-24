import 'package:flutter/material.dart';
import 'package:dash_talk/screens/welcome_screen.dart';
import 'package:dash_talk/screens/login_screen.dart';
import 'package:dash_talk/screens/registration_screen.dart';
import 'package:dash_talk/screens/chat_selection_screen.dart';
import 'package:dash_talk/screens/chat_screen.dart';

void main() => runApp(DashTalk());

class DashTalk extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
        ChatSelectionScreen.id: (context) => ChatSelectionScreen(),
        ChatScreen.id: (context) => ChatScreen(),
      },
    );
  }
}
