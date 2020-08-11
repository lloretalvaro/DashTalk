import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:dash_talk/screens/welcome_screen.dart';

class LoadingScreen extends StatefulWidget {
  static const id = '/';
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 2200), () {
      Navigator.pushNamed(context, WelcomeScreen.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo,
      body: Center(
        child: SpinKitSquareCircle(
          color: Colors.white,
          size: 100,
        ),
      ),
    );
  }
}
