import 'dart:async';
import 'dart:convert';
import "package:flutter/material.dart";
import 'package:flutter_flux/flutter_flux.dart';

import 'package:youtrackr/widgets/background.dart';
import 'package:youtrackr/widgets/progress_spinner.dart';
import 'package:youtrackr/stores/stores.dart';
import 'package:youtrackr/utils/network_util.dart';
import 'package:youtrackr/utils/rest_urls.dart';
import 'package:youtrackr/pages/service_page.dart';
import 'package:youtrackr/pages/home_page.dart';

class LoginPage extends StatefulWidget {
  static String tag = 'login-page';

  @override
    State<StatefulWidget> createState() => new _LoginPageState();
}

class _LoginData {
  String username = '';
  String password = '';
}

class _LoginPageState extends State<LoginPage> 
  with StoreWatcherMixin<LoginPage>{

  final GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  _LoginData loginData = new _LoginData();
  bool isLoading = false;
  ApplicationStore applicationStore;
  ServiceStore serviceStore;
  UserStore userStore;
  NetworkUtil _networkUtil = new NetworkUtil();

  @override
  void initState() {

    applicationStore = listenToStore(applicationStoreToken);
    serviceStore = listenToStore(serviceStoreToken);
    userStore = listenToStore(userStoreToken);

    super.initState();
  }

  Map<String, String> createBasicAuthHeader(String id, String secret) {
    Base64Encoder _base64Encoder = new Base64Encoder();
    Utf8Encoder _utf8Encoder = new Utf8Encoder();    

    return {
      'Authorization': 'Basic ' + _base64Encoder.convert(_utf8Encoder.convert(id + ':' + secret)),
      'Content-Type': 'application/x-www-form-urlencoded'
    };
  }

  Future<bool> fetchAndSaveAccessToken() async {
    final form = formKey.currentState;

    if (form.validate()) {
      form.save();

      return await _networkUtil.post(
        serviceStore.serviceHubUrl + REQUEST_AUTH_TOKEN_URL, 
        headers: createBasicAuthHeader(serviceStore.serviceId, serviceStore.serviceSecret), 
        body: {
          'username': loginData.username, 
          'password': loginData.password, 
          'grant_type':'password',
          'scope': '0-0-0-0-0' + ' ' + serviceStore.ringServiceId
        }
      ).then((dynamic res) {
        setAccessToken(res['access_token']);
        setTokenType(res['token_type']);
        return true;
      });
    }
    return false;
  }

  final text = new Center(
    child: new Text('YouTrack Login',
      style: new TextStyle(fontSize: 30.0, fontWeight: FontWeight.w700)
    )
  );

  Widget usernameInput(BuildContext context) {
    return new TextFormField(
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      style: new TextStyle(color: Colors.white70),
      decoration: new InputDecoration(
        hintText: "Username",
        prefixIcon: new Container(
          padding: new EdgeInsets.only(left: 5.0, right: 10.0),
          child: new Icon(
            Icons.face,
            color: Colors.white70,
            size: 18.0,
          ),
        ),
        hintStyle: new TextStyle(color: Colors.grey, fontSize: 13.0),
        errorText: applicationStore.networkError ? 'Network error. Please try again.' : null,
        contentPadding: new EdgeInsets.fromLTRB(0.0, 10.0, 20.0, 10.0)
      ),
      validator: (val) => val.isEmpty ? 'Username can\'t be empty.' : null,
      onSaved: (String value) {
        loginData.username = value;
      },
    );
  }

  Widget passwordInput(BuildContext context) {
    return new TextFormField(
      keyboardType: TextInputType.text,
      obscureText: true,
      autofocus: false,
      style: new TextStyle(color: Colors.white70),
      decoration: new InputDecoration(
        prefixIcon: new Container(
          padding: new EdgeInsets.only(left: 5.0, right: 10.0),
          child: new Icon(
            Icons.lock_outline,
            color: Colors.white70,
            size: 18.0,  
          ),
        ),
        hintText: "Password",
        hintStyle: new TextStyle(color: Colors.grey, fontSize: 13.0),
        contentPadding: new EdgeInsets.fromLTRB(0.0, 10.0, 20.0, 10.0),
      ),
      validator: (val) => val.isEmpty ? 'Password can\'t be empty.' : null,
      onSaved: (String value) {
        loginData.password = value;
      },
    );
  } 

  Widget loginButton(BuildContext context) {
    return new Container(
      decoration: new BoxDecoration(
        borderRadius: new BorderRadius.all(new Radius.circular(10.0)),
        border: new Border.all(
          color: Colors.white70,
          width: 1.0,
        )
      ),
      child: new Material(
        borderRadius: new BorderRadius.all(new Radius.circular(10.0)),
        color: Colors.transparent,
        child: new MaterialButton(
          highlightColor: Colors.black.withOpacity(0.0),
          splashColor: Colors.purpleAccent,
          textColor: Colors.white70,
          // onPressed: _submitLogin,
          onPressed: () async {
            if (await fetchAndSaveAccessToken()) {
              setLoggedIn(true);
              setUsername(loginData.username);
              // TODO: Save Token in local storage 
              Navigator.of(context).pushNamed(HomePage.tag);
            }
          },
          child: new Text('Log In'),
        ),
      ),
    );
  } 

  @override
    Widget build(BuildContext context) {

      return new Scaffold(
        resizeToAvoidBottomPadding: false,
        body: new Stack(
          children: <Widget>[
            background(),
            new Center(
              child: new Container(
                child: new Form(
                  key: formKey,
                  child: new Padding(
                    padding: new EdgeInsets.all(25.0),
                    child: new Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        new SizedBox(height: 50.0), //Application logo placeholder
                        new Column(
                          children: <Widget>[
                            usernameInput(context),
                            new SizedBox(height: 20.0),
                            passwordInput(context)
                          ],
                        ),
                        loginButton(context)
                      ],
                    ),
                  )
                ),
              ),
            ),
            ProgressSpinner(),
            new Container(
              margin: new EdgeInsets.only(top: 25.0),
              child: new FlatButton.icon(
                icon: new Icon(Icons.keyboard_arrow_left, color: Colors.purpleAccent),
                label: new Text('URL', style: new TextStyle(color: Colors.purpleAccent)),
                splashColor: Colors.transparent.withOpacity(0.0),
                highlightColor: Colors.transparent.withOpacity(0.0),
                onPressed: () {
                  // TODO: Remove ServiceInformation from state
                  Navigator.of(context).pushNamed(ServicePage.tag);
                },
              )
            )
          ],
        ),
      );

    }
}