import 'package:flutter/material.dart';

import 'PersonalisedCard.dart';

class ErrorAlert extends StatelessWidget {
  ErrorAlert({this.messageError});

  final String messageError;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 200, horizontal: 50),
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
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        decoration: TextDecoration.none),
                  ),
                ),
              ),
              RaisedButton(
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
