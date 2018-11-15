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

  getActivePeers() async {
    return await _methodChannel.invokeMethod('getActivePeers');
  }

  getCurrentUser() async {
    return await _methodChannel.invokeMethod('getCurrentUser');
  }

  getLocalPublicKey() async {
    return await _methodChannel.invokeMethod('getLocalPublicKey');
  }

  hasSession() async {
    return await _methodChannel.invokeMethod('hasSession');
  }

  isStarted() async {
    return await _methodChannel.invokeMethod('isStarted');
  }

  getNetworkStatus() async {
    return await _methodChannel.invokeMethod('getNetworkStatus');
  }

  isBackgroundModeEnabled() async {
    return await _methodChannel.invokeMethod('isBackgroundModeEnabled');
  }

  backgroundModeEnabled(value) async {
    return await _methodChannel.invokeMethod('backgroundModeEnabled', value);
  }

  isBroadcastReceptionEnabled() async {
    return await _methodChannel.invokeMethod('isBroadcastReceptionEnabled');
  }

  broadcastReceptionEnabled(value) async {
    return await _methodChannel.invokeMethod(
        'broadcastReceptionEnabled', value);
  }

  isUserAvailable(value) async {
    return await _methodChannel.invokeMethod('isUserAvailable', value);
  }

  isSecureConnection(value) async {
    return await _methodChannel.invokeMethod('isSecureConnection', value);
  }

  establishSecureConnection(value) async {
    return await _methodChannel.invokeMethod(
        'establishSecureConnection', value);
  }

  destroySession() async {
    return await _methodChannel.invokeMethod('destroySession');
  }

  saveState() async {
    return await _methodChannel.invokeMethod('saveState');
  }

  savePublicKey(value) async {
    return await _methodChannel.invokeMethod('savePublicKey', value);
  }

  existsKeyForUser(value) async {
    return await _methodChannel.invokeMethod('existsKeyForUser', value);
  }

  getSecureConnectionExpirationLimit() async {
    return await _methodChannel
        .invokeMethod('getSecureConnectionExpirationLimit');
  }

  setSecureConnectionExpirationLimit(value) async {
    return await _methodChannel.invokeMethod(
        'setSecureConnectionExpirationLimit', value);
  }

  sendDictionary(value) async {
    return await _methodChannel.invokeMethod('sendDictionary', value);
  }

  sendData(value) async {
    return await _methodChannel.invokeMethod('sendData', value);
  }

  sendDictionaryWithData(value) async {
    return await _methodChannel.invokeMethod('sendDictionaryWithData', value);
  }
}
