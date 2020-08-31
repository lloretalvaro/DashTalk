import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton({@required this.onPressed, this.title, this.color});

  final Function onPressed;
  final String title;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 7.0,
        color: color,
        borderRadius: BorderRadius.circular(20.0),
        child: MaterialButton(
          onPressed: onPressed,
          minWidth: 200.0,
          height: 59.0,
          child: Text(
            title,
            style: TextStyle(
                fontSize: 21, color: Colors.white, fontWeight: FontWeight.w700),
          ),
        ),
      ),
    );
  }
}
