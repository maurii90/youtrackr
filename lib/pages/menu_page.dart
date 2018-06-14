import 'package:flutter/material.dart';
import 'package:flutter_flux/flutter_flux.dart';

import 'package:youtrackr/stores/stores.dart';
import 'package:youtrackr/widgets/background.dart';
import 'package:youtrackr/widgets/progress_spinner.dart';

class MenuPage extends StatefulWidget {
  static String tag = 'menu-page';

  @override
  _MenuPageState createState() => new _MenuPageState();
}

class _MenuPageState extends State<MenuPage>
  with StoreWatcherMixin<MenuPage> {
    
  @override
    Widget build(BuildContext context) {

      return new Scaffold(
        resizeToAvoidBottomPadding: false,
        body: new Stack(
          children: <Widget>[
            background(),
            Center(
              child: Text('Menu Page', style: TextStyle(color: Colors.white70)),
            ),
            ProgressSpinner()
          ],
        ),
      );

      // TODO: implement build
    }

}