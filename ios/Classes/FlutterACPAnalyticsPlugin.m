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

#import "FlutterACPAnalyticsPlugin.h"
#import "ACPAnalytics.h"

@implementation FlutterACPAnalyticsPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"flutter_acpanalytics"
            binaryMessenger:[registrar messenger]];
  FlutterACPAnalyticsPlugin* instance = [[FlutterACPAnalyticsPlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
    if ([@"extensionVersion" isEqualToString:call.method]) {
        result([ACPAnalytics extensionVersion]);
    } else if ([@"sendQueuedHits" isEqualToString:call.method]) {
        [ACPAnalytics sendQueuedHits];
        result(nil);
    } else if ([@"clearQueue" isEqualToString:call.method]) {
        [ACPAnalytics clearQueue];
        result(nil);
    } else if ([@"getQueueSize" isEqualToString:call.method]) {
        [self getQueueSize:call result:result];
    } else if ([@"getTrackingIdentifier" isEqualToString:call.method]) {
        [self getTrackingIdentifier:call result:result];
    } else if ([@"getVisitorIdentifier" isEqualToString:call.method]) {
        [self getVisitorIdentifier:call result:result];
    } else if ([@"setVisitorIdentifier" isEqualToString:call.method]) {
        NSString *vid = call.arguments;
        [ACPAnalytics setVisitorIdentifier:vid];
        result(nil);
    } else {
        result(FlutterMethodNotImplemented);
    }
}

- (void)getQueueSize:(FlutterMethodCall *)call result:(FlutterResult)result {
    [ACPAnalytics getQueueSize:^(NSUInteger queueSize) {
        result(@(queueSize));
    }];
}

- (void)getTrackingIdentifier:(FlutterMethodCall *)call result:(FlutterResult)result {
    [ACPAnalytics getTrackingIdentifier:^(NSString * _Nullable trackingIdentifier) {
        result(trackingIdentifier);
    }];
}

- (void)getVisitorIdentifier:(FlutterMethodCall *)call result:(FlutterResult)result {
    [ACPAnalytics getVisitorIdentifier:^(NSString * _Nullable visitorIdentifier) {
        result(visitorIdentifier);
    }];
}

@end
