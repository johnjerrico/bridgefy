import 'package:flutter/material.dart';
import 'dart:async';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bridgefy/flutter_bridgefy.dart';
import 'dart:io';
import 'dart:convert';

void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _myId, _activePeers;
  File _image;

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
      'user': '0409ee64-6e96-46dc-a51a-f30515f2fa0b'
    });
  }

  Future<void> _sendData() async {
    await _flutterBridgefy
        .sendData({'data': _image.path, 'user': '0409ee64-6e96-46dc-a51a-f30515f2fa0b'});
  }

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      _image = image;
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
                  new Text('Active Peers: $_activePeers\n'),
                  _image == null
                      ? new Text('No _image selected.')
                      : new Text(_image.path),
                  new RaisedButton(
                      onPressed: _sendDictionary,
                      color: Theme.of(context).accentColor,
                      elevation: 4.0,
                      splashColor: Colors.blueGrey,
                      child: new Text('Send'))
                ]),
          ),
          floatingActionButton: new FloatingActionButton(
            onPressed: getImage,
            tooltip: 'Select file',
            child: new Icon(Icons.file_upload),
          )),
    );
  }
}
