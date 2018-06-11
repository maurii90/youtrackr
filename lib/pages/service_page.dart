import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_flux/flutter_flux.dart';

import 'package:youtrackr/stores/stores.dart';
import 'package:youtrackr/widgets/background.dart';
import 'package:youtrackr/widgets/progress_spinner.dart';
import 'package:youtrackr/utils/network_util.dart';
import 'package:youtrackr/utils/rest_urls.dart';


// TODO: try to find a good solution like a model
class _ServiceData {
  String serviceUrl = '';
}

class ServicePage extends StatefulWidget {
  static String tag = 'choose-serevice-page';

  @override
  _ServicePageState createState() => new _ServicePageState();
}

class _ServicePageState extends State<ServicePage>
  with StoreWatcherMixin<ServicePage> {

  ApplicationStore applicationStore;
  _ServiceData _serviceData = new _ServiceData();
  final formKey = new GlobalKey<FormState>();
  NetworkUtil _networkUtil = new NetworkUtil();

  @override
  void initState() {
    super.initState();

    applicationStore = listenToStore(applicationStoreToken);
  }

  Future<bool> fetchAndSaveServiceData () async {
    final form = formKey.currentState;

      if (form.validate()) {
        form.save();

        return await _networkUtil.get(_serviceData.serviceUrl + FETCH_SERVICE_INFORMATION_URL)
        .then((dynamic res) {
          setServiceUrl(_serviceData.serviceUrl);
          setServiceSecret(res['mobile']['serviceSecret']);
          setServiceId(res['mobile']['serviceId']);
          setRingServiceId(res['ring']['serviceId']);
          setServiceHubUrl(res['ring']['url']);
          return true;
        });
      }
      return false;
  }

  final serviceInputIcon = /*networkError*/ false ? 
    new Icon(Icons.error_outline, color: Colors.red, size: 18.0,) :
    new Icon(Icons.public, color: Colors.white70, size: 18.0,);

  Widget serviceUrlInput(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.url,
      autofocus: false,
      validator: (val) {
        if (val.isEmpty) {
          return 'Please enter a YouTrack URL';
        }
      },
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
        errorText: applicationStore.networkError ? 'Network error. Please try again.' : null,
      ),
      onSaved: (String value) {
        _serviceData.serviceUrl = value;
      },
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
          onPressed: () async {
            setLoading();
            if (await fetchAndSaveServiceData()) {
              // TODO: Save service data in local storage
              // Navigator.of(context).pushNamed(LoginPage.tag);
            }
            unsetLoading();
          },
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
              key: formKey,
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
          ProgressSpinner()
        ])
      );
    }

}