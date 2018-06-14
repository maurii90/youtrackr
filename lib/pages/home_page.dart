import 'package:flutter/material.dart';
import 'package:flutter_flux/flutter_flux.dart';

import 'package:youtrackr/widgets/background.dart';
import 'package:youtrackr/widgets/progress_spinner.dart';
import 'package:youtrackr/pages/tracked_time_page.dart';
import 'package:youtrackr/pages/menu_page.dart';

class HomePage extends StatefulWidget {
  static String tag = 'home-page';

  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage>
  with StoreWatcherMixin<HomePage> {

  final List<Widget> _pages = <Widget>[
    MenuPage(),
    TrackedTimePage()
  ];

  @override
    Widget build(BuildContext context) {

      return new Scaffold(
        resizeToAvoidBottomPadding: false,
        body: new Stack(

          children: <Widget>[
            PageView.builder(
              reverse: true,
              itemCount: 2,
              itemBuilder: (BuildContext context, int index) {
                return _pages[index % _pages.length];
              },
            ),
          ],
        ),
      );

      // TODO: implement build
    }

}