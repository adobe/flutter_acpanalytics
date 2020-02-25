/*
Copyright 2020 Adobe. All rights reserved.
This file is licensed to you under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License. You may obtain a copy
of the License at http://www.apache.org/licenses/LICENSE-2.0
Unless required by applicable law or agreed to in writing, software distributed under
the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR REPRESENTATIONS
OF ANY KIND, either express or implied. See the License for the specific language
governing permissions and limitations under the License.
*/
import 'dart:developer';

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_acpcore/flutter_acpcore.dart';
import 'package:flutter_acpanalytics/flutter_acpanalytics.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  int _queueSize = 0;
  String _trackingId = '';
  String _visitorId = '';

  @override
  void initState() {
    super.initState();
    initPlatformState();
    getQueueSize();
    getTrackingIdentifier();
    getVisitorIdentifier();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformVersion = await FlutterACPAnalytics.extensionVersion;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  Future<void> getQueueSize() async {
    int queueSize;
    try {
      queueSize = await FlutterACPAnalytics.queueSize;
    } on PlatformException {
      log("Failed to get the queue size");
      queueSize = 0;
    }

    if (!mounted) return;
    setState(() {
      _queueSize = queueSize;
    });
  }

  Future<void> getTrackingIdentifier() async {
    String trackingId;
    try {
      trackingId = await FlutterACPAnalytics.trackingIdentifier;
    } on PlatformException {
      log("Failed to get the tracking identifier");
    }

    if (!mounted) return;
    setState(() {
      _trackingId = trackingId;
    });
  }

  Future<void> getVisitorIdentifier() async {
    String visitorId;
    try {
      visitorId = await FlutterACPAnalytics.visitorIdentifier;
    } on PlatformException {
      visitorId = "Failed to get the visitor identifier";
    }

    if (!mounted) return;
    setState(() {
      _visitorId = visitorId;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(children: <Widget>[
            Text('ACPAnalytics version = $_platformVersion\n'),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  RaisedButton(
                    child: Text("ACPCore.trackState(...)"),
                    onPressed: () => FlutterACPCore.trackState("myState",
                        data: {"key1": "value1"}),
                  ),
                  RaisedButton(
                    child: Text("ACPCore.trackAction(...)"),
                    onPressed: () => FlutterACPCore.trackAction("myAction",
                        data: {"key1": "value1"}),
                  ),
                ]),
            RaisedButton(
              child: Text("ACPAnalytics.sendQueuedHits()"),
              onPressed: () => FlutterACPAnalytics.sendQueuedHits(),
            ),
            RaisedButton(
              child: Text("ACPAnalytics.clearQueue()"),
              onPressed: () => FlutterACPAnalytics.clearQueue(),
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  RaisedButton(
                    child: Text("ACPAnalytics.getQueueSize()"),
                    onPressed: () => getQueueSize(),
                  ),
                  Text('Queue size = $_queueSize\n'),
                ]),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  RaisedButton(
                    child: Text("ACPAnalytics.getTrackingIdentifier()"),
                    onPressed: () => getTrackingIdentifier(),
                  ),
                  Text('Tracking Id = $_trackingId\n'),
                ]),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  RaisedButton(
                    child: Text("ACPAnalytics.getVisitorIdentifier()"),
                    onPressed: () => getVisitorIdentifier(),
                  ),
                  Text('Visitor Id = $_visitorId\n'),
                ]),
            RaisedButton(
              child: Text("ACPAnalytics.setVisitorIdentifier(vid)"),
              onPressed: () => FlutterACPAnalytics.setVisitorIdentifier("vid"),
            ),
          ]),
        ),
      ),
    );
  }
}
