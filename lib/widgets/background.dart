import 'package:flutter/material.dart';

Widget background(BuildContext context) {
  return Stack(
    children: <Widget>[
      Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            alignment: Alignment.centerRight,
            image: AssetImage('assets/images/background.jpeg')
          ),
        )
      ),
      Container(
        decoration: BoxDecoration(
          color: Colors.black.withAlpha(255).withOpacity(0.8),
        ),
      ),
    ]);
}