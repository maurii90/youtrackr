import 'package:flutter/material.dart';
import 'package:flutter_flux/flutter_flux.dart';

import 'package:youtrackr/stores/stores.dart';

class UserDrawer extends StatefulWidget {
  @override
  _UserDrawerState createState() => new _UserDrawerState();
}

class _UserDrawerState extends State<UserDrawer> 
  with StoreWatcherMixin<UserDrawer>{

  UserStore userStore;

  @override
  void initState() {
    super.initState();

    userStore = listenToStore(userStoreToken);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Color.fromRGBO(36, 43, 43, 1.0),
        child: ListView(
          children: <Widget> [
            DrawerHeader(
              padding: EdgeInsets.all(0.0),
              child: Container(
                height: 60.0,
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      CircleAvatar(
                        radius: 60.0,
                        backgroundImage: NetworkImage(userStore.avatarUrl),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                        child: Text(
                          userStore.fullName, 
                          style: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold)
                        )
                      )
                    ],
                  ) 
                )
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 20.0),
              child: Text(
                'Preferences', 
                style: TextStyle(color: Colors.white70, fontSize: 10.0, fontWeight: FontWeight.bold, )
              ),
            ),
            // ListTile(
            //   title: new Text('Preferences', style: TextStyle(color: Colors.white70, fontSize: 10.0)),
            // ),
          ],
        ),
      )
    );
    // TODO: implement build
  }

}