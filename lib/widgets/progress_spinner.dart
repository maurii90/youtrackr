import 'package:flutter/material.dart';
import 'package:flutter_flux/flutter_flux.dart';

import 'package:youtrackr/stores/stores.dart';

class ProgressSpinner extends StatefulWidget {
  @override
  _ProgressSpinnerState createState() => new _ProgressSpinnerState();
}

class _ProgressSpinnerState extends State<ProgressSpinner>
  with StoreWatcherMixin<ProgressSpinner> {

  ApplicationStore applicationStore;

  @override
  void initState() {
    super.initState();

    applicationStore = listenToStore(applicationStoreToken);
  }

  @override
  Widget build(BuildContext context) {
    return applicationStore.isLoading 
      ? new Stack(
          children: [
            new Opacity(
              opacity: 0.7,
              child: const ModalBarrier(dismissible: false, color: Colors.black),
            ),
            new Center(
              child: new CircularProgressIndicator(),
            ),
          ],
        ) 
      : new Container(width: 0.0, height: 0.0);
    }

}