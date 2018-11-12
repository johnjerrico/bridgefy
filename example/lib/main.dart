import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_bridgefy/flutter_bridgefy.dart';

void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _myId, _activePeers;
  var _flutterBridgefy = new FlutterBridgefy();

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String myId;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      await _flutterBridgefy.init('380948ce-a45c-4176-8508-dbff103bbd0a');
      await _flutterBridgefy.start();
      await _flutterBridgefy.backgroundModeEnabled(true);
      myId = await _flutterBridgefy.getCurrentUser();
    } on PlatformException {
      debugPrint('Error');
    }

    setState(() {
      _myId = myId;
    });
    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
  }

  Future<void> _getActivePeers() async {
    List<dynamic> activePeers;

    activePeers = await _flutterBridgefy.getActivePeers();
    
    print(await _flutterBridgefy.isSecureConnection('1c2e5c87-e08e-484f-9398-34552be422d2'));
    await _flutterBridgefy.sendDictionary({
      'dictionary' : ['MASUK'],
      'user': '1c2e5c87-e08e-484f-9398-34552be422d2'
    });
    // 1c2e5c87-e08e-484f-9398-34552be422d2

    // setState(() {
    //   _activePeers = activePeers.toString();
    // });
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
          appBar: new AppBar(
            title: const Text('Plugin example app'),
          ),
          body: new Center(
            child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Text('My Id: $_myId\n'),
                  new Text('Active Peers: $_activePeers\n')
                ]),
          ),
          floatingActionButton: new FloatingActionButton(
            onPressed: _getActivePeers,
            tooltip: 'Increment',
            child: new Icon(Icons.add),
          )),
    );
  }
}
