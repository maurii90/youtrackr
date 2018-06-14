import 'package:flutter/material.dart';
import 'package:youtrackr/pages/service_page.dart';
import 'package:youtrackr/pages/login_page.dart';
import 'package:youtrackr/pages/home_page.dart';

final routes = <String, WidgetBuilder> {
  ServicePage.tag: (context) => new ServicePage(),
  LoginPage.tag: (context) => new LoginPage(),
  HomePage.tag: (context) => new HomePage(),
};