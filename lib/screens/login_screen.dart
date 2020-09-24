import 'package:dash_talk/constants.dart';

import 'package:flutter/material.dart';
import 'package:dash_talk/components/rounded_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:dash_talk/components/ErrorAlert.dart';
import 'package:dash_talk/screens/chat_selection_screen.dart';

class LoginScreen extends StatefulWidget {
  static const id = '/login';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email;
  String password;
  final _auth = FirebaseAuth.instance;
  bool showSpinner = false;

  Widget loginTextfieldWidgets() {
    return Column(
      children: <Widget>[
        TextField(
          keyboardType: TextInputType.emailAddress,
          onChanged: (value) {
            email = value;
          },
          style: kLoginRegistrationTextStyle,
          decoration: kTextFieldDecoration.copyWith(
              hintText: 'Email',
              hintStyle: kHintTextStyle.copyWith(
                fontSize: MediaQuery.of(context).size.width / 20,
              ),
              prefixIcon: Icon(
                Icons.email,
                color: kIconColorLoginRegistration,
                size: kIconSizeLoginRegistration,
              )),
        ),
        SizedBox(
          height: 8.0,
        ),
        TextField(
          obscureText: true,
          onChanged: (value) {
            password = value;
          },
          style: kLoginRegistrationTextStyle,
          decoration: kTextFieldDecoration.copyWith(
              hintText: 'Password',
              hintStyle: kHintTextStyle.copyWith(
                fontSize: MediaQuery.of(context).size.width / 20,
              ),
              prefixIcon: Icon(
                Icons.lock,
                color: kIconColorLoginRegistration,
                size: kIconSizeLoginRegistration,
              )),
        ),
      ],
    );
  }

  void loginUser() async {
    try {
      final user = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (user != null) {
        Navigator.pushNamed(context, ChatSelectionScreen.id);
      }
    } catch (e) {
      setState(() {
        showSpinner = false;
      });
      String errorCode = e.toString();
      if (errorCode.contains('ERROR_INVALID_EMAIL')) {
        showErrorAlert('Invalid email, try again please');
      } else if (errorCode.contains('ERROR_WRONG_PASSWORD')) {
        showErrorAlert('Wrong password, try again please');
      } else if (errorCode.contains('ERROR_USER_NOT_FOUND')) {
        showErrorAlert('The user for the given email is not found');
      } else if (errorCode.contains('ERROR_USER_DISABLED')) {
        showErrorAlert('The user has been disabled, try again please');
      } else if (errorCode.contains('ERROR_TOO_MANY_REQUESTS')) {
        showErrorAlert('Too many attempts to log in, try again please');
      } else if (errorCode.contains('ERROR_OPERATION_NOT_ALLOWED')) {
        showErrorAlert('Email/password account not allowed, try again please');
      } else {
        showErrorAlert('An unexpected error occurred, try again please');
      }
    }
  }

  void showErrorAlert(String errorMessage) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return ErrorAlert(
            messageError: errorMessage,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo[800],
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Hero(
                  tag: 'logo',
                  child: Container(
                    height: MediaQuery.of(context).size.height / 5,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              loginTextfieldWidgets(),
              SizedBox(
                height: 24.0,
              ),
              RoundedButton(
                isRegistrationScreen: false,
                title: 'Log in',
                color: kLoginColor,
                onPressed: () async {
                  if (email != null && password != null) {
                    setState(() {
                      showSpinner = true;
                    });
                    loginUser();
                    setState(() {
                      showSpinner = false;
                    });
                  } else {
                    showErrorAlert(
                        'Please don\'t leave your email/password blank');
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
