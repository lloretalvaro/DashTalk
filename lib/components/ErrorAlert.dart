import 'package:dash_talk/constants.dart';
import 'package:flutter/material.dart';

import 'PersonalisedCard.dart';

class ErrorAlert extends StatelessWidget {
  ErrorAlert({this.messageError});

  final String messageError;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        //MediaQuery.of(context).size.height / 5,
        // MediaQuery.of(context).size.height / 3,
        margin: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height / 5,
          horizontal: MediaQuery.of(context).size.width / 20,
        ),
        child: PersonalisedCard(
          cardColor1: Colors.indigo[400],
          cardColor2: Colors.indigo[600],
          cardColor3: Colors.blue[800],
          cardChild: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 5,
              ),
              Expanded(
                child: Image.asset('images/error_storm.png'),
              ),
              Expanded(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                  child: Text(
                    messageError,
                    textAlign: TextAlign.center,
                    style: kErrorAlertTextStyle.copyWith(
                        fontSize: MediaQuery.of(context).size.width / 18),
                  ),
                ),
              ),
              RaisedButton(
                elevation: 10,
                color: Colors.yellow[300],
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'Ok',
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
              ),
              SizedBox(
                height: 5,
              )
            ],
          ),
        ),
      ),
    );
  }
}
