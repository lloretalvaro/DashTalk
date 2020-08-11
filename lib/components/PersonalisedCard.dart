import 'package:flutter/material.dart';

class PersonalisedCard extends StatelessWidget {
  PersonalisedCard(
      {@required this.cardColor1,
      @required this.cardColor2,
      @required this.cardColor3,
      this.cardChild,
      this.onPress});

  final Color cardColor1;
  final Color cardColor2;
  final Color cardColor3;
  final Widget cardChild;
  final Function onPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        child: cardChild,
        margin: EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(
              colors: [cardColor1, cardColor2, cardColor3],
              begin: Alignment.bottomLeft,
              end: Alignment.topRight),
        ),
      ),
    );
  }
}
