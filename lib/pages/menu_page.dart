import 'package:flutter/material.dart';
import 'package:flutter_flux/flutter_flux.dart';

import 'package:youtrackr/stores/stores.dart';
import 'package:youtrackr/widgets/background.dart';
import 'package:youtrackr/widgets/progress_spinner.dart';
import 'package:youtrackr/widgets/top_bar.dart';

class MenuPage extends StatefulWidget {
  static String tag = 'menu-page';

  @override
  _MenuPageState createState() => new _MenuPageState();
}

class _MenuPageState extends State<MenuPage>
  with StoreWatcherMixin<MenuPage> {
    
  ApplicationStore applicationStore;
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
    void initState() {
      applicationStore = listenToStore(applicationStoreToken);
      setCurrentScaffold(_scaffoldKey);
      super.initState();
    }

  @override
    Widget build(BuildContext context) {

      return Scaffold(
        key: _scaffoldKey,
        resizeToAvoidBottomPadding: false,
        drawer: new Drawer(
          child: new ListView(
            children: <Widget> [
              new DrawerHeader(child: new Text('Header'),),
              new ListTile(
                title: new Text('First Menu Item'),
                onTap: () {},
              ),
              new ListTile(
                title: new Text('Second Menu Item'),
                onTap: () {},
              ),
              new Divider(),
              new ListTile(
                title: new Text('About'),
                onTap: () {},
              ),
            ],
          )
        ),
        body: Stack(
          children: <Widget>[
            background(),
            TopBar(),
            ProgressSpinner()
          ],
        ),
      );

      // TODO: implement build
    }

}