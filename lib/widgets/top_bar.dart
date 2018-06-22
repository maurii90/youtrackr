import 'package:flutter/material.dart';

import 'package:youtrackr/stores/stores.dart';

class TopBar extends StatefulWidget {
  @override
  _TopBarState createState() => new _TopBarState();
}

class _TopBarState extends State<TopBar> {

  ApplicationStore applicationStore;

  @override
  void initState() {
    super.initState();
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
                  icon: Icon(Icons.account_circle ),
                  onPressed: (){},
                ),
              )          
            ],
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