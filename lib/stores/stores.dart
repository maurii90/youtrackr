import 'package:flutter_flux/flutter_flux.dart';

class LoadingStore extends Store {
  LoadingStore() {
    triggerOnAction(setLoading, (bool value) {
      _isLoading = true;
    });

    triggerOnAction(unsetLoading, (bool value) {
      _isLoading = false;
    });
  }

  bool _isLoading = false;

  bool get isLoading => _isLoading;
}

final StoreToken loadingStoreToken = new StoreToken(new LoadingStore());

final Action<bool> setLoading = new Action<bool>();
final Action<bool> unsetLoading = new Action<bool>(); 