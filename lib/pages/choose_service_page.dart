import 'dart:async';
import 'dart:io' as io;
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

class ChooseServicePage extends StatefulWidget {
  static String tag = 'choose-serevice-page';

  @override
  _ChooseServicePageState createState() => new _ChooseServicePageState();
}

class _ChooseServicePageState extends State<ChooseServicePage> {

  @override
    Widget build(BuildContext context) {

      return new Scaffold(
        body: Center(
          child: Text('Choose Service Page'),
        ),
      );
    }
}