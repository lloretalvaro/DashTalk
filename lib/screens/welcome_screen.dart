import 'package:dash_talk/constants.dart';
import 'package:dash_talk/screens/chat_selection_screen.dart';
import 'package:dash_talk/screens/login_screen.dart';
import 'package:dash_talk/screens/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:dash_talk/components/rounded_button.dart';
import 'package:firebase_auth/firebase_auth.dart';

class WelcomeScreen extends StatefulWidget {
  static const id = '/';
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation animation;
  FirebaseUser currentUserLogged;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1200));

    animation = CurvedAnimation(parent: controller, curve: Curves.easeIn);

    controller.forward();

    animation = ColorTween(begin: Colors.indigo, end: Colors.indigo[800])
        .animate(controller);

    controller.addListener(() async {
      setState(() {});
      await checkIfUserAlreadyLogged(context);
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future<void> checkIfUserAlreadyLogged(BuildContext context) async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    currentUserLogged = await _auth.currentUser();

    if (currentUserLogged != null) {
      Navigator.pushNamed(context, ChatSelectionScreen.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget animatedText = TypewriterAnimatedTextKit(
      text: ['Dash Talk'],
      speed: Duration(milliseconds: 300),
      repeatForever: true,
      textStyle: kAnimatedTextStyle,
    );

    Widget normalText = Text(
      'Dash Talk',
      style: kAnimatedTextStyle,
    );
    return Scaffold(
      backgroundColor: animation.value,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: Container(
                    child: Image.asset('images/logo.png'),
                    height: kLogoSizeWelcomeScreen,
                  ),
                ),
                currentUserLogged == null ? animatedText : normalText,
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            RoundedButton(
              title: 'Log In',
              color: kLoginColor,
              onPressed: () {
                //Go to login screen.
                Navigator.pushNamed(context, LoginScreen.id);
              },
            ),
            RoundedButton(
              title: 'Register',
              color: kRegisterColor,
              onPressed: () {
                //Go to registration screen.
                Navigator.pushNamed(context, RegistrationScreen.id);
              },
            ),
          ],
        ),
      ),
    );
  }
}
