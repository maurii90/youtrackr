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
            Column(
              children: <Widget>[
                TopBar(),
                Container(
                  margin: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 20.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(bottom: 20.0),
                            height: MediaQuery.of(context).size.width / 2 - 30,
                            width: MediaQuery.of(context).size.width / 2 - 30,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(10.0)),
                              border: Border.all(
                                color: Colors.pinkAccent,
                                width: 1.0,
                              )
                            ),
                            child: Material(
                              borderRadius: BorderRadius. all(Radius.circular(10.0)),
                              color: Colors.transparent,
                              child: MaterialButton(
                                highlightColor: Colors.black.withOpacity(0.0),
                                splashColor: Colors.pinkAccent,
                                textColor: Colors.white70,
                                child: Container(
                                  padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Container(
                                        margin: EdgeInsets.only(left: 10.0, right: 10.0),
                                        child: Image.asset('assets/icons/icon-timer.png'),
                                      ),
                                      Text('Stopwatch', style: TextStyle(fontSize: 16.0, color: Colors.white))
                                    ],
                                  ),
                                ),
                                onPressed: () {},
                              )
                            )
                          ),

                          Container(
                            margin: EdgeInsets.only(bottom: 20.0),
                            height: MediaQuery.of(context).size.width / 2 - 30,
                            width: MediaQuery.of(context).size.width / 2 - 30,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(10.0)),
                              border: Border.all(
                                color: Colors.indigoAccent,
                                width: 1.0,
                              )
                            ),
                            child: Material(
                              borderRadius: BorderRadius. all(Radius.circular(10.0)),
                              color: Colors.transparent,
                              child: MaterialButton(
                                highlightColor: Colors.black.withOpacity(0.0),
                                splashColor: Colors.indigoAccent,
                                textColor: Colors.white70,
                                child: Container(
                                  padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Container(
                                        margin: EdgeInsets.only(left: 10.0, right: 10.0),
                                        child: Image.asset('assets/icons/icon-list-tickets.png'),
                                      ),
                                      Text('Search List', style: TextStyle(fontSize: 16.0, color: Colors.white))
                                    ],
                                  ),
                                ),
                                onPressed: () {},
                              )
                            )
                          ),

                        ],
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Container(
                            height: MediaQuery.of(context).size.width / 2 - 30,
                            width: MediaQuery.of(context).size.width / 2 - 30,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(10.0)),
                              border: Border.all(
                                color: Colors.limeAccent,
                                width: 1.0,
                              )
                            ),
                            child: Material(
                              borderRadius: BorderRadius. all(Radius.circular(10.0)),
                              color: Colors.transparent,
                              child: MaterialButton(
                                highlightColor: Colors.black.withOpacity(0.0),
                                splashColor: Colors.limeAccent,
                                textColor: Colors.white70,
                                child: Container(
                                  padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Container(
                                        margin: EdgeInsets.only(left: 10.0, right: 10.0),
                                        child: Image.asset('assets/icons/icon-sprint-tickets.png'),
                                      ),
                                      Text('Actual Sprint', style: TextStyle(fontSize: 16.0, color: Colors.white))
                                    ],
                                  ),
                                ),
                                onPressed: () {},
                              )
                            )
                          ),

                          Container(
                            height: MediaQuery.of(context).size.width / 2 - 30,
                            width: MediaQuery.of(context).size.width / 2 - 30,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(10.0)),
                              border: Border.all(
                                color: Colors.tealAccent,
                                width: 1.0,
                              )
                            ),
                            child: Material(
                              borderRadius: BorderRadius. all(Radius.circular(10.0)),
                              color: Colors.transparent,
                              child: MaterialButton(
                                highlightColor: Colors.black.withOpacity(0.0),
                                splashColor: Colors.tealAccent,
                                textColor: Colors.white70,
                                child: Container(
                                  padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Container(
                                        margin: EdgeInsets.only(left: 10.0, right: 10.0),
                                        child: Image.asset('assets/icons/icon-quick-record.png'),
                                      ),
                                      Text('Quick Record', style: TextStyle(fontSize: 16.0, color: Colors.white))
                                    ],
                                  ),
                                ),
                                onPressed: () {},
                              )
                            )
                          ),

                        ],
                      )

                    ],
                  ),
                ),
              ],
            ),
            ProgressSpinner()
          ],
        ),
      );

      // TODO: implement build
    }

}