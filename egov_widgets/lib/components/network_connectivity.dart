

import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkConnectivity {

  static StreamSubscription<ConnectivityResult>? _subscription;

  static Future<bool> isConnected() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    return ConnectivityResult.none != connectivityResult;
  }

  static void addConnectivityListener(
      Function(bool) callBack) {
    if(_subscription != null) _subscription?.cancel();
    _subscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) => callBack(result != ConnectivityResult.none));
  }
}