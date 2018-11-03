import 'dart:async';

import 'package:flutter/services.dart';

class FlutterBridgefy {
  static const MethodChannel _methodChannel =
      const MethodChannel('flutter_bridgefy');
  static const EventChannel _eventChannel =
      const EventChannel('flutter_bridgefy_result');

  FlutterBridgefy() {
    // Receive Event Result
    _eventChannel.receiveBroadcastStream().listen(_onEvent, onError: _onError);
  }

  Function _successCallback;
  Function _errorCallback;

  void _onEvent(Object event) {
    _successCallback(event);
  }

  void _onError(Object error) {
    _errorCallback(error);
  }

  init(apiKey) async {
    return await _methodChannel.invokeMethod('init', apiKey);
  }

  start() async {
    return await _methodChannel.invokeMethod('start');
  }

  stop() async {
    return await _methodChannel.invokeMethod('start');
  }

  backgroundModeEnabled(value) async {
    return await _methodChannel.invokeMethod('backgroundModeEnabled', value);
  }
}
