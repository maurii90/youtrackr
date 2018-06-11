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
  }

  bool _isLoading = false;
  bool _networkError = false;

  bool get isLoading => _isLoading;
  bool get networkError => _networkError;
}

final StoreToken applicationStoreToken = new StoreToken(new ApplicationStore());

final Action<bool> setLoading = new Action<bool>();
final Action<bool> unsetLoading = new Action<bool>();

final Action<bool> setNetworkError = new Action<bool>(); 

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