import 'package:flutter/material.dart';
import 'package:flutter_flux/flutter_flux.dart';

import 'package:youtrackr/pages/tracked_time_page.dart';
import 'package:youtrackr/pages/menu_page.dart';
import 'package:youtrackr/stores/stores.dart';
import 'package:youtrackr/utils/network_util.dart';
import 'package:youtrackr/utils/rest_urls.dart';

class HomePage extends StatefulWidget {
  static String tag = 'home-page';

  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage>
  with StoreWatcherMixin<HomePage> {

  ServiceStore serviceStore;
  UserStore userStore;
  NetworkUtil _networkUtil = new NetworkUtil();
  final List<Widget> _pages = <Widget>[
    MenuPage(),
    TrackedTimePage()
  ];

  Map<String, String> createBasicAuthHeader(String id, String secret) {
    return {
      'Accept': 'application/json',
      'Authorization': 'Bearer ' + userStore.authToken
    };
  }

  @override
    void initState() {
      serviceStore = listenToStore(serviceStoreToken);
      userStore = listenToStore(userStoreToken);

      _networkUtil
        .get(serviceStore.serviceHubUrl + FETCH_USER_DATA_URL, 
          headers: createBasicAuthHeader(serviceStore.serviceId, serviceStore.serviceSecret)
        ). then((res) {
          setFullName(res['name']);
          setAvatarUrl(res['profile']['avatar']['url']);
        });
      

      super.initState();
    }

  @override
    Widget build(BuildContext context) {

      return new Scaffold(
        resizeToAvoidBottomPadding: false,
        body: new Stack(
          children: <Widget>[
            PageView.builder(
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