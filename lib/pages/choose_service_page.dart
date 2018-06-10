import 'dart:async';
import 'dart:io' as io;
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter_flux/flutter_flux.dart';

import 'package:youtrackr/stores/stores.dart';
import 'package:youtrackr/widgets/background.dart';
import 'package:youtrackr/widgets/progress_indicator.dart';

class ChooseServicePage extends StatefulWidget {
  static String tag = 'choose-serevice-page';

  @override
  _ChooseServicePageState createState() => new _ChooseServicePageState();
}

class _ChooseServicePageState extends State<ChooseServicePage>
  with StoreWatcherMixin<ChooseServicePage> {

  LoadingStore loadingStore;

  @override
  void initState() {
    super.initState();

    loadingStore = listenToStore(loadingStoreToken);
  }

  void mockedRequest() {
    setLoading(); // LoadingStore action
    new Future.delayed(
      const Duration(seconds: 3), 
      unsetLoading // LoadingStore action
    );
  }

  final serviceInputIcon = /*networkError*/ false ? 
    new Icon(Icons.error_outline, color: Colors.red, size: 18.0,) :
    new Icon(Icons.public, color: Colors.white70, size: 18.0,);

  Widget serviceUrlInput(BuildContext context) {
    return TextFormField(
      // initialValue: 'wrer',
      keyboardType: TextInputType.url,
      autofocus: false,
      //validator: (val) => _validateServiceUrl(val),
      // controller: _controller,
      style: TextStyle(color: Colors.white70),
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        prefixIcon: serviceInputIcon,
        hintStyle: TextStyle(color: Colors.grey, fontSize: 13.0),
        hintText: ' Enter YouTrack Service URL',
        contentPadding: EdgeInsets.fromLTRB(0.0, 10.0, 20.0, 10.0),
        border: UnderlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(1.0)
          )
        ),
        // errorText: networkError ? 'Network error. Please try again.' : null,
      ),
    );
  } 

  Widget chooseServiceButton(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        border: Border.all(
          color: Colors.white70,
          width: 1.0,
        )
      ),
      child: Material(
        borderRadius: BorderRadius. all(Radius.circular(10.0)),
        color: Colors.transparent,
        child: MaterialButton(
          highlightColor: Colors.black.withOpacity(0.0),
          splashColor: Colors.purpleAccent,
          textColor: Colors.white70,
          child: Text('Next'),
          onPressed: mockedRequest,
          //onPressed: _handleServiceInformation,
        )
      )
    );
  }

  @override
    Widget build(BuildContext context) {

      return Scaffold(
        resizeToAvoidBottomPadding: false,
        body: Stack(children: <Widget>[
          background(context),
          Container(
            margin: EdgeInsets.all(25.0),
            child: Form(
              //key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  SizedBox(height: 50.0), //Application logo placeholder
                  serviceUrlInput(context),
                  chooseServiceButton(context)
                ],
              ),
            ),
          ),
          progressIndicator(loadingStore.isLoading)
        ])
      );
    }

}