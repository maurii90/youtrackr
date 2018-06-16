import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_flux/flutter_flux.dart';

import 'package:youtrackr/widgets/background.dart';
import 'package:youtrackr/widgets/progress_spinner.dart';
import 'package:youtrackr/stores/stores.dart';
import 'package:youtrackr/utils/network_util.dart';
import 'package:youtrackr/utils/rest_urls.dart';

class WorkItem {
  WorkItem(this.issueName, this.description, this.worktype, this.duration);
  String issueName;
  String description;
  String worktype;
  int duration;
}

class TrackedTimePage extends StatefulWidget {

  @override
  _TrackedTimePageState createState() => new _TrackedTimePageState();
}

class _TrackedTimePageState extends State<TrackedTimePage>
  with StoreWatcherMixin<TrackedTimePage> {

  ApplicationStore applicationStore;
  ServiceStore serviceStore;
  UserStore userStore;
  NetworkUtil _networkUtil = new NetworkUtil();
  var now = new DateTime.now();
  var issuesList = [];
  var workItemsList = new List<WorkItem>();

  @override
  void initState() {
    applicationStore = listenToStore(applicationStoreToken);
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
              workItem['date'] == new DateTime(now.year, now.month, now.day-1, 0, 0, 0).millisecondsSinceEpoch) {
                workItemsList.add(new WorkItem(
                  issue, 
                  workItem['description'], 
                  workItem['worktype']['name'], 
                  workItem['duration']
                ));
            }
          }
          print(workItemsList.toString());
        })
      );
    }
    await Future.wait(futures.map((f) => f));

    setWorkItems(workItemsList);
    unsetLoading();
  }
    
  @override
    Widget build(BuildContext context) {

      return Scaffold(
        resizeToAvoidBottomPadding: false,
        body: Stack(
          children: <Widget>[
            background(),
            Text('Today:', style: TextStyle(color: Colors.white70, fontSize: 18.0)),
            ListView(
              children:
              applicationStore.workItemsList.map((workItem) {
                return Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: <Widget>[
                          Text(
                            (workItem.duration/60).toString() + 'h',
                            style: TextStyle(color: Colors.white70),
                            textAlign: TextAlign.left,
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: new Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  Text(
                                    workItem.worktype,
                                    style: TextStyle(color: Colors.white70)
                                  )
                                ],
                              ),
                              Column(
                                children: <Widget>[
                                  Text(
                                    workItem.issueName,
                                    style: TextStyle(color: Colors.white70)
                                  )
                                ],
                              )
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Text(
                                workItem.description,
                                style: TextStyle(color: Colors.white70)
                              )
                            ],
                          )                 
                        ],
                      ),
                    )
                    // new Text(workItem.issueName, style: TextStyle(color: Colors.white70))
                  ],
                );
              }).toList(),
            ),
            // Center(
            //   child: Text('Tracked Time Page', style: TextStyle(color: Colors.white70)),
            // ),
            ProgressSpinner()
          ],
        ),
      );

      // TODO: implement build
    }

}