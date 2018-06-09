import 'routes.dart';
import 'package:flutter/material.dart';
import 'package:youtrackr/pages/choose_service_page.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "Youtrack Timer",
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new ChooseServicePage(),
      routes: routes,
    );
  }
}
