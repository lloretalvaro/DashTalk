import 'package:firebase_auth/firebase_auth.dart';
import 'package:dash_talk/components/rounded_button.dart';

import 'package:flutter/material.dart';
import 'package:dash_talk/constants.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:dash_talk/components/ErrorAlert.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dash_talk/screens/chat_selection_screen.dart';

class RegistrationScreen extends StatefulWidget {
  static const id = '/registration';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  String username;
  String email;
  String password;
  String confirmedPassword;
  final _auth = FirebaseAuth.instance;
  bool showSpinner = false;

  Widget registrationTextfieldWidgets() {
    return Column(
      children: <Widget>[
        TextField(
          onChanged: (value) {
            username = value;
          },
          style: kLoginRegistrationTextStyle.copyWith(
              fontSize: MediaQuery.of(context).size.width / 17),
          decoration: kTextFieldDecoration.copyWith(
              hintText: 'Your cool username',
              hintStyle: kHintTextStyle.copyWith(
                fontSize: MediaQuery.of(context).size.width / 20,
              ),
              prefixIcon: Icon(
                Icons.person,
                color: kIconColorLoginRegistration,
                size: kIconSizeLoginRegistration,
              )),
        ),
        SizedBox(
          height: 7.0,
        ),
        TextField(
          keyboardType: TextInputType.emailAddress,
          onChanged: (value) {
            email = value;
          },
          style: kLoginRegistrationTextStyle.copyWith(
              fontSize: MediaQuery.of(context).size.width / 17),
          decoration: kTextFieldDecoration.copyWith(
              hintText: 'Your email',
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
          height: 7.0,
        ),
        TextField(
          obscureText: true,
          onChanged: (value) {
            password = value;
          },
          style: kLoginRegistrationTextStyle.copyWith(
              fontSize: MediaQuery.of(context).size.width / 17),
          decoration: kTextFieldDecoration.copyWith(
              hintText: 'Your new password',
              hintStyle: kHintTextStyle.copyWith(
                fontSize: MediaQuery.of(context).size.width / 20,
              ),
              prefixIcon: Icon(
                Icons.lock_outline,
                color: kIconColorLoginRegistration,
                size: kIconSizeLoginRegistration,
              )),
        ),
        SizedBox(
          height: 7.0,
        ),
        TextField(
          obscureText: true,
          onChanged: (value) {
            confirmedPassword = value;
          },
          style: kLoginRegistrationTextStyle.copyWith(
              fontSize: MediaQuery.of(context).size.width / 17),
          decoration: kTextFieldDecoration.copyWith(
              hintText: 'Confirm password',
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

  void registerUser() async {
    try {
      final newUser = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      if (newUser != null) {
        //-------------------------------------------------------------
        // Current way to save the username into the database
        final user = await _auth.currentUser();
        if (user != null) {
          Firestore.instance.collection('users').document().setData(
              {'uid': user.uid, 'username': username, 'email': user.email});
        }
        //-------------------------------------------------------------
        Navigator.pushNamed(context, ChatSelectionScreen.id);
      }
    } catch (e) {
      setState(() {
        showSpinner = false;
      });
      String errorCode = e.toString();
      if (errorCode.contains('ERROR_INVALID_EMAIL')) {
        showErrorAlert('Invalid email, try again please');
      } else if (errorCode.contains('ERROR_WEAK_PASSWORD')) {
        showErrorAlert(
            'Password must be at least 6 characters, change it please');
      } else if (errorCode.contains('ERROR_EMAIL_ALREADY_IN_USE')) {
        showErrorAlert('This email is already registered, try again please');
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
              registrationTextfieldWidgets(),
              SizedBox(
                height: 24.0,
              ),
              Expanded(
                child: RoundedButton(
                  isRegistrationScreen: true,
                  title: 'Register',
                  color: kRegisterColor,
                  onPressed: () async {
                    if (username != null) {
                      if (email != null && password != null) {
                        if (password == confirmedPassword) {
                          setState(() {
                            showSpinner = true;
                          });
                          registerUser();
                          setState(() {
                            showSpinner = false;
                          });
                        } else {
                          showErrorAlert(
                              'Your password confirmation is not correct');
                        }
                      } else {
                        showErrorAlert(
                            'Please don\'t leave your email/password blank');
                      }
                    } else {
                      showErrorAlert('Please don\'t leave your username empty');
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
