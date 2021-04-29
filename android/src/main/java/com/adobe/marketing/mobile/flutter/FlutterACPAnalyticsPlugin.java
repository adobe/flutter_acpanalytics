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
package com.adobe.marketing.mobile.flutter;


import android.os.Handler;
import android.os.Looper;

import com.adobe.marketing.mobile.AdobeCallback;
import com.adobe.marketing.mobile.Analytics;

import androidx.annotation.NonNull;
import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

/**
 * FlutterACPAnalyticsPlugin
 */
public class FlutterACPAnalyticsPlugin implements FlutterPlugin, MethodCallHandler {

    private MethodChannel channel;

    @Override
    public void onAttachedToEngine(@NonNull final FlutterPluginBinding binding) {
        channel = new MethodChannel(binding.getBinaryMessenger(), "flutter_acpanalytics");
        channel.setMethodCallHandler(new FlutterACPAnalyticsPlugin());
    }

    @Override
    public void onDetachedFromEngine(@NonNull final FlutterPluginBinding binding) {
        if (channel != null) {
            channel.setMethodCallHandler(null);
        }
    }

    @Override
    public void onMethodCall(MethodCall call, Result result) {
        if ("extensionVersion".equals(call.method)) {
            result.success(Analytics.extensionVersion());
        } else if ("sendQueuedHits".equals((call.method))) {
            Analytics.sendQueuedHits();
            result.success(null);
        } else if ("clearQueue".equals((call.method))) {
            Analytics.clearQueue();
            result.success(null);
        } else if ("getQueueSize".equals((call.method))) {
            getQueueSize(result);
        } else if ("getTrackingIdentifier".equals((call.method))) {
            getTrackingIdentifier(result);
        } else if ("getVisitorIdentifier".equals((call.method))) {
            getVisitorIdentifier(result);
        } else if ("setVisitorIdentifier".equals((call.method))) {
            setVisitorIdentifier(call.arguments);
            result.success(null);
        } else {
            result.notImplemented();
        }
    }

    private void getQueueSize(final Result result) {
        Analytics.getQueueSize(new AdobeCallback<Long>() {
            @Override
            public void call(final Long queueSize) {
                runOnUIThread(new Runnable() {
                    @Override
                    public void run() {
                        result.success(queueSize);
                    }
                });
            }
        });
    }

    private void getTrackingIdentifier(final Result result) {
        Analytics.getTrackingIdentifier(new AdobeCallback<String>() {
            @Override
            public void call(final String trackingIdentifier) {
                runOnUIThread(new Runnable() {
                    @Override
                    public void run() {
                        result.success(trackingIdentifier);
                    }
                });
            }
        });
    }

    private void getVisitorIdentifier(final Result result) {
        Analytics.getVisitorIdentifier(new AdobeCallback<String>() {
            @Override
            public void call(final String visitorIdentifier) {
                runOnUIThread(new Runnable() {
                    @Override
                    public void run() {
                        result.success(visitorIdentifier);
                    }
                });
            }
        });
    }

    private void setVisitorIdentifier(final Object arguments) {
        if (arguments instanceof String) {
            String visitorId = (String) arguments;
            Analytics.setVisitorIdentifier(visitorId);
        }
    }

    private void runOnUIThread(Runnable runnable) {
        new Handler(Looper.getMainLooper()).post(runnable);
    }
}
