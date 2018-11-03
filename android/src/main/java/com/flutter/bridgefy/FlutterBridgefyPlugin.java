package com.flutter.bridgefy;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.EventChannel;
import io.flutter.plugin.common.EventChannel.StreamHandler;
import io.flutter.plugin.common.PluginRegistry.Registrar;

import com.bridgefy.sdk.client.Bridgefy;
import com.bridgefy.sdk.client.BridgefyClient;
import com.bridgefy.sdk.client.Device;
import com.bridgefy.sdk.client.Message;
import com.bridgefy.sdk.client.MessageListener;
import com.bridgefy.sdk.client.RegistrationListener;
import com.bridgefy.sdk.client.Session;
import com.bridgefy.sdk.client.StateListener;

/** FlutterBridgefyPlugin */
public class FlutterBridgefyPlugin implements MethodCallHandler, EventChannel.StreamHandler {
  private EventChannel.EventSink _eventSink;

  /** Plugin registration. */
  public static void registerWith(Registrar registrar) {
    final MethodChannel channel = new MethodChannel(registrar.messenger(), "flutter_bridgefy");
    final EventChannel eventChannel = new EventChannel(registrar.messenger(), "flutter_bridgefy_result");

    FlutterBridgefyPlugin instance = new FlutterBridgefyPlugin();
    channel.setMethodCallHandler(instance);
    eventChannel.setStreamHandler(instance);
  }

  @Override
  public void onMethodCall(MethodCall call, Result result) {

    if (call.method.equals("init")) {
      if (call.arguments != null) {
        result.success("Android " + android.os.Build.VERSION.RELEASE);
      } else {
        result.error("ERROR", "errorMessage", null);
      }
    } else if (call.method.equals("start")) {
      if (call.arguments != null) {
        result.success("Android " + android.os.Build.VERSION.RELEASE);
      } else {
        result.error("ERROR", "errorMessage", null);
      }
    } else {
      result.notImplemented();
    }
  }

  @Override
  public void onListen(Object arguments, EventChannel.EventSink events) {
    _eventSink = events;
  }

  @Override
  public void onCancel(Object arguments) {
    _eventSink = null;
  }

}
