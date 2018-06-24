import 'package:flutter/material.dart';
import 'package:flutter_flux/flutter_flux.dart';

import 'package:youtrackr/stores/stores.dart';

class TopBar extends StatefulWidget {
  @override
  _TopBarState createState() => new _TopBarState();
}

class _TopBarState extends State<TopBar> 
  with StoreWatcherMixin<TopBar>{

  ApplicationStore applicationStore;
  UserStore userStore;

  @override
  void initState() {
    super.initState();

    applicationStore = listenToStore(applicationStoreToken);
    userStore = listenToStore(userStoreToken);
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      // color: Colors.yellowAccent,
      height: 50.0,
      margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          // Leading
          IconButton(
            padding: EdgeInsets.all(10.0),
            iconSize: 18.0,
            color: Colors.white70,
            splashColor: Colors.purpleAccent,
            icon: userStore.avatarUrl.isNotEmpty ? Image.network(userStore.avatarUrl) : Container(),
            onPressed: openDrawer,
          ),
 
          // Title
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Application Bar', 
                style: TextStyle(
                  color: Colors.white70, 
                  fontSize: 18.0
                )
              )
            ],
          ),
          
          // Actions
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Material(

                borderRadius: BorderRadius. all(Radius.circular(25.0)),
                color: Colors.transparent,
                child: IconButton(
                  iconSize: 18.0,
                  color: Colors.white70,
                  splashColor: Colors.purpleAccent,
                  icon: Icon(Icons.settings),
                  onPressed: (){},
                ),
              )          
            ],
          ),
        ],
      )
    );
  }
}