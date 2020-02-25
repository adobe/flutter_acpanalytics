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

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_acpanalytics/flutter_acpanalytics.dart';

void main() {
  const MethodChannel channel = MethodChannel('flutter_acpanalytics');

  TestWidgetsFlutterBinding.ensureInitialized();

  group('extensionVersion', () {
    final String testVersion = "2.5.0";
    final List<MethodCall> log = <MethodCall>[];

    setUp(() {
      channel.setMockMethodCallHandler((MethodCall methodCall) async {
        log.add(methodCall);
        return testVersion;
      });
    });

    test('invokes correct method', () async {
      await FlutterACPAnalytics.extensionVersion;

      expect(log, <Matcher>[
        isMethodCall(
          'extensionVersion',
          arguments: null,
        ),
      ]);
    });

    test('returns correct result', () async {
      expect(await FlutterACPAnalytics.extensionVersion, testVersion);
    });
  });

  group('sendQueuedHits', () {
    final List<MethodCall> log = <MethodCall>[];

    setUp(() {
      channel.setMockMethodCallHandler((MethodCall methodCall) async {
        log.add(methodCall);
        return null;
      });
    });

    test('invokes correct method', () async {
      await FlutterACPAnalytics.sendQueuedHits();

      expect(log, <Matcher>[
        isMethodCall(
          'sendQueuedHits',
          arguments: null,
        ),
      ]);
    });
  });

  group('clearQueue', () {
    final List<MethodCall> log = <MethodCall>[];

    setUp(() {
      channel.setMockMethodCallHandler((MethodCall methodCall) async {
        log.add(methodCall);
        return null;
      });
    });

    test('invokes correct method', () async {
      await FlutterACPAnalytics.clearQueue();

      expect(log, <Matcher>[
        isMethodCall(
          'clearQueue',
          arguments: null,
        ),
      ]);
    });
  });

  group('queueSize', () {
    final int testSize = 10;
    final List<MethodCall> log = <MethodCall>[];

    setUp(() {
      channel.setMockMethodCallHandler((MethodCall methodCall) async {
        log.add(methodCall);
        return testSize;
      });
    });

    test('invokes correct method', () async {
      await FlutterACPAnalytics.queueSize;

      expect(log, <Matcher>[
        isMethodCall(
          'getQueueSize',
          arguments: null,
        ),
      ]);
    });

    test('returns correct result', () async {
      expect(await FlutterACPAnalytics.queueSize, testSize);
    });
  });

  group('trackingIdentifier', () {
    final String testTrackingIdentifier = "test-identifier";
    final List<MethodCall> log = <MethodCall>[];

    setUp(() {
      channel.setMockMethodCallHandler((MethodCall methodCall) async {
        log.add(methodCall);
        return testTrackingIdentifier;
      });
    });

    test('invokes correct method', () async {
      await FlutterACPAnalytics.trackingIdentifier;

      expect(log, <Matcher>[
        isMethodCall(
          'getTrackingIdentifier',
          arguments: null,
        ),
      ]);
    });

    test('returns correct result', () async {
      expect(
          await FlutterACPAnalytics.trackingIdentifier, testTrackingIdentifier);
    });
  });

  group('visitorIdentifier', () {
    final String testVid = "test-vid";
    final List<MethodCall> log = <MethodCall>[];

    setUp(() {
      channel.setMockMethodCallHandler((MethodCall methodCall) async {
        log.add(methodCall);
        return testVid;
      });
    });

    test('invokes correct method', () async {
      await FlutterACPAnalytics.visitorIdentifier;

      expect(log, <Matcher>[
        isMethodCall(
          'getVisitorIdentifier',
          arguments: null,
        ),
      ]);
    });

    test('returns correct result', () async {
      expect(await FlutterACPAnalytics.visitorIdentifier, testVid);
    });
  });

  group('setVisitorIdentifier', () {
    final String testVid = "test-vid";
    final List<MethodCall> log = <MethodCall>[];

    setUp(() {
      channel.setMockMethodCallHandler((MethodCall methodCall) async {
        log.add(methodCall);
        return null;
      });
    });

    test('invokes correct method', () async {
      await FlutterACPAnalytics.setVisitorIdentifier(testVid);

      expect(log, <Matcher>[
        isMethodCall(
          'setVisitorIdentifier',
          arguments: testVid,
        ),
      ]);
    });
  });
}
