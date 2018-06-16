import 'package:flutter_flux/flutter_flux.dart';

class ApplicationStore extends Store {
  ApplicationStore() {
    triggerOnAction(setLoading, (bool value) {
      _isLoading = true;
    });

    triggerOnAction(unsetLoading, (bool value) {
      _isLoading = false;
    });

    triggerOnAction(setNetworkError, (bool value) {
      _networkError = true;
    });

    triggerOnAction(setWorkItems, (List value) {
      _workItemsList = value;
    });
  }

  bool _isLoading = false;
  bool _networkError = false;
  List _workItemsList = [];

  bool get isLoading => _isLoading;
  bool get networkError => _networkError;
  List get workItemsList => _workItemsList;
}

final Action<bool> setLoading = new Action<bool>();
final Action<bool> unsetLoading = new Action<bool>();
final Action<bool> setNetworkError = new Action<bool>(); 
final Action<List> setWorkItems = new Action<List>();

final StoreToken applicationStoreToken = new StoreToken(new ApplicationStore());

class ServiceStore extends Store {
  ServiceStore() {
    triggerOnAction(setServiceUrl, (String value) {
      _serviceUrl = value;
    });

    triggerOnAction(setServiceId, (String value) {
      _serviceId = value;
    });

    triggerOnAction(setServiceSecret, (String value) {
      _serviceSecret = value;
    });

    triggerOnAction(setRingServiceId, (String value) {
      _ringServiceId = value;
    });

    triggerOnAction(setServiceHubUrl, (String value) {
      _serviceHubUrl = value;
    });
  }

  String _serviceUrl = '';
  String _serviceId = '';
  String _serviceSecret = '';
  String _ringServiceId = '';
  String _serviceHubUrl = '';

  String get serviceUrl => _serviceUrl;
  String get serviceId => _serviceId;
  String get serviceSecret => _serviceSecret;
  String get ringServiceId => _ringServiceId;
  String get serviceHubUrl => _serviceHubUrl;
}

final Action<String> setServiceUrl = new Action<String>();
final Action<String> setServiceId = new Action<String>();
final Action<String> setServiceSecret = new Action<String>();
final Action<String> setRingServiceId = new Action<String>();
final Action<String> setServiceHubUrl = new Action<String>();

final StoreToken serviceStoreToken = new StoreToken(new ServiceStore());

class UserStore extends ServiceStore {
  UserStore() {
    triggerOnAction(setLoggedIn, (bool value){
      _loggedIn = value;
    });

    triggerOnAction(setTokenType, (String value){
      _tokenType = value;
    });

    triggerOnAction(setAccessToken, (String value){
      _accessToken = value;
    });

    triggerOnAction(setUsername, (String value){
      _username = value;
    });
  }

  bool _loggedIn = false;
  String _accessToken = '';
  String _tokenType = '';
  String _username = '';

  bool get isLoggedIn => _loggedIn;
  String get authToken => _accessToken;
  String get tokenType => _tokenType;
  String get username => _username;
}

final Action<bool> setLoggedIn = new Action<bool>();
final Action<String> setAccessToken = new Action<String>();
final Action<String> setTokenType = new Action<String>();
final Action<String> setUsername = new Action<String>();

final StoreToken userStoreToken = new StoreToken(new UserStore());