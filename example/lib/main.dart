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
    List<dynamic> activePeers;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      await _flutterBridgefy.init('380948ce-a45c-4176-8508-dbff103bbd0a');
      await _flutterBridgefy.start();
      await _flutterBridgefy.backgroundModeEnabled(true);
      myId = await _flutterBridgefy.getCurrentUser();
      activePeers = await _flutterBridgefy.getActivePeers();
      print(activePeers);
    } on PlatformException {
      debugPrint('Error');
    }

    setState(() {
      _myId = myId;
      _activePeers = activePeers.toString();
    });
    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
  }

  Future<void> _sendDictionary() async {
    await _flutterBridgefy.sendDictionary({
      'dictionary': {'value': 'MASUK'},
      'user': '4ac9f903-6154-4167-a501-5d1c70704da7'
    });
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
            onPressed: _sendDictionary,
            tooltip: 'Increment',
            child: new Icon(Icons.add),
          )),
    );
  }
}
