import 'package:flutter/material.dart';
import 'package:flutter_flux/flutter_flux.dart';

import 'package:youtrackr/widgets/background.dart';
import 'package:youtrackr/widgets/progress_spinner.dart';

class TrackedTimePage extends StatefulWidget {

  @override
  _TrackedTimePageState createState() => new _TrackedTimePageState();
}

class _TrackedTimePageState extends State<TrackedTimePage>
  with StoreWatcherMixin<TrackedTimePage> {
    
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