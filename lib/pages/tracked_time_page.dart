import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_flux/flutter_flux.dart';

import 'package:youtrackr/widgets/background.dart';
import 'package:youtrackr/widgets/progress_spinner.dart';
import 'package:youtrackr/stores/stores.dart';
import 'package:youtrackr/utils/network_util.dart';
import 'package:youtrackr/utils/rest_urls.dart';

class TrackedTimePage extends StatefulWidget {

  @override
  _TrackedTimePageState createState() => new _TrackedTimePageState();
}

class _TrackedTimePageState extends State<TrackedTimePage>
  with StoreWatcherMixin<TrackedTimePage> {

  ServiceStore serviceStore;
  UserStore userStore;
  NetworkUtil _networkUtil = new NetworkUtil();
  var now = new DateTime.now();
  var issuesList = [];
  var workItemsList = [];

  @override
  void initState() {
    serviceStore = listenToStore(serviceStoreToken);
    userStore = listenToStore(userStoreToken);
    fetchAndSaveAccessToken();
    super.initState();
  }

  Map<String, String> createBearerAuthHeader() {
    return {
      'Accept': 'application/json',
      'Authorization': userStore.tokenType + ' ' + userStore.authToken,
    };
  }

  Future<bool> fetchAndSaveAccessToken() async {
    setLoading();
    return await _networkUtil.get(
      serviceStore.serviceUrl + FETCH_TODAY_UPDATED_ISSUES_URL.replaceFirst('{username}', userStore.username), 
      headers: createBearerAuthHeader(), 
    ).then((dynamic res) {

      for(var issue in res['issue']) {
        issuesList.add(issue['id'].toString());
      }

      fetchTimeTrackingWorkItems();
    });
  }

  fetchTimeTrackingWorkItems() async {
    var futures = [];
    for(String issue in issuesList) {
      futures.add(_networkUtil.get(
          serviceStore.serviceUrl + FETCH_ISSUE_TIME_TRACKING_WORK_ITEMS_URL.replaceFirst('{issue}', issue), 
          headers: createBearerAuthHeader(), 
        ).then((workItems) {
          for(var workItem in workItems) {
            if(workItem['author']['login'] == userStore.username &&
              workItem['date'] == new DateTime(now.year, now.month, now.day, 0, 0, 0).millisecondsSinceEpoch) {
                workItemsList.add({
                  'issueName': issue,
                  'description': workItem['description'],
                  'duration': workItem['duration'],
                  'worktype': workItem['worktype']['name'],
                });
            }
          }
        })
      );
    }
    await Future.wait(futures.map((f) => f));

    unsetLoading();
  }
    
  @override
    Widget build(BuildContext context) {

      return new Scaffold(
        resizeToAvoidBottomPadding: false,
        body: new Stack(
          children: <Widget>[
            background(),
            Center(
              child: Text('Tracked Time Page', style: TextStyle(color: Colors.white70)),
            ),
            ProgressSpinner()
          ],
        ),
      );

      // TODO: implement build
    }

}