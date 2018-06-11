import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:youtrackr/stores/stores.dart';

class NetworkUtil {

  // Singleton
  // static NetworkUtil _instance = new NetworkUtil();
  // NetworkUtil.internal();
  // factory NetworkUtil() => _instance;

  final JsonDecoder _decoder = new JsonDecoder();

  Future<dynamic> get(String url, { Map headers }) {
    return http.get(url, headers: headers)
    .then((http.Response response) {
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        setNetworkError();
      }

      return _decoder.convert(response.body);
    }).catchError((error){
      setNetworkError();
      return error;
    });
  }

  Future<dynamic> post(String url, {Map headers, body, encoding}) {
    return http.post(url, headers: headers, body: body, encoding: encoding)
    .then((http.Response response) {
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        setNetworkError();
      }

      return _decoder.convert(response.body);
    }).catchError((error){
      setNetworkError();
    });
  }

  // @override
  // void initStores(ListenToStore listenToStore) {
  //   // TODO: implement initStores
  //   applicationStore = listenToStore(applicationStoreToken);
  // }

}