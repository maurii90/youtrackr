import 'package:flutter/material.dart';
import 'package:flutter_flux/flutter_flux.dart';

import 'package:youtrackr/stores/stores.dart';
import 'package:youtrackr/widgets/background.dart';
import 'package:youtrackr/widgets/progress_spinner.dart';
import 'package:youtrackr/widgets/top_bar.dart';
import 'package:youtrackr/widgets/user_drawer.dart';

class MenuPage extends StatefulWidget {
  static String tag = 'menu-page';

  @override
  _MenuPageState createState() => new _MenuPageState();
}

class _MenuPageState extends State<MenuPage>
  with StoreWatcherMixin<MenuPage> {
    
  ApplicationStore applicationStore;
  UserStore userStore;
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
    void initState() {
      applicationStore = listenToStore(applicationStoreToken);
      userStore = listenToStore(userStoreToken);
      setCurrentScaffold(_scaffoldKey);
      super.initState();
    }

  @override
    Widget build(BuildContext context) {

      return Scaffold(
        key: _scaffoldKey,
        resizeToAvoidBottomPadding: false,
        drawer: UserDrawer(),
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