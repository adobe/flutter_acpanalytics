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

import 'dart:async';

import 'package:flutter/services.dart';

/// Adobe Experience Platform Analytics API.
class FlutterACPAnalytics {
  static const MethodChannel _channel =
      const MethodChannel('flutter_acpanalytics');

  /// Gets the current Analytics extension version.
  static Future<String> get extensionVersion async {
    final String version = await _channel.invokeMethod('extensionVersion');
    return version;
  }

  /// Sends all queued hits to Analytics, regardless of the current hit batch settings.
  static Future<void> sendQueuedHits() async {
    await _channel.invokeMethod<void>('sendQueuedHits');
  }

  /// Force delete, without sending to Analytics, all hits being stored or batched on the SDK.
  static Future<void> clearQueue() async {
    await _channel.invokeMethod<void>('clearQueue');
  }

  /// Retrieves the total number of Analytics hits in the tracking queue.
  static Future<int> get queueSize async {
    final int size = await _channel.invokeMethod('getQueueSize');
    return size;
  }

  /// Retrieves the Analytics tracking identifier that is generated for this app/device instance.
  static Future<String> get trackingIdentifier async {
    final String id = await _channel.invokeMethod('getTrackingIdentifier');
    return id;
  }

  /// Gets a custom Analytics visitor identifier.
  static Future<String> get visitorIdentifier async {
    final String vid = await _channel.invokeMethod('getVisitorIdentifier');
    return vid;
  }

  /// Sets a custom Analytics visitor identifier.
  static Future<void> setVisitorIdentifier(String vid) async {
    await _channel.invokeMethod<void>('setVisitorIdentifier', vid ?? "");
  }
}
