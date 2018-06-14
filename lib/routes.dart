import 'package:flutter/material.dart';
import 'package:youtrackr/pages/service_page.dart';
import 'package:youtrackr/pages/login_page.dart';
import 'package:youtrackr/pages/menu_page.dart';

final routes = <String, WidgetBuilder> {
  ServicePage.tag: (context) => new ServicePage(),
  LoginPage.tag: (context) => new LoginPage(),
  MenuPage.tag: (context) => new MenuPage()
};