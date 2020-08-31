import 'package:flutter/material.dart';
import 'package:dash_talk/screens/welcome_screen.dart';
import 'package:dash_talk/screens/login_screen.dart';
import 'package:dash_talk/screens/registration_screen.dart';
import 'package:dash_talk/screens/chat_selection_screen.dart';
import 'package:dash_talk/screens/chat_screen.dart';
import 'package:responsive_framework/responsive_framework.dart';

void main() => runApp(DashTalk());

class DashTalk extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, child) => ResponsiveWrapper.builder(
        child,
        minWidth: 480,
        maxWidth: 1440,
        defaultScale: true,
        breakpoints: [
          ResponsiveBreakpoint.resize(480, name: MOBILE),
          ResponsiveBreakpoint.resize(800, name: TABLET),
          ResponsiveBreakpoint.resize(1000, name: DESKTOP),
        ],
      ),
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
