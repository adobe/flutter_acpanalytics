# flutter_acpanalytics

[![pub package](https://img.shields.io/pub/v/flutter_acpanalytics.svg)](https://pub.dartlang.org/packages/flutter_acpanalytics) ![Build](https://github.com/adobe/flutter_acpanalytics/workflows/Dart%20Unit%20Tests%20+%20Android%20Build%20+%20iOS%20Build/badge.svg) [![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

⚠️ This package is currently in beta, we are actively working to a release candidate. If you have any feedback please log an issue or submit a pull request.

`flutter_acpanalytics` is a flutter plugin for the iOS and Android [AEP Analytics SDK](https://aep-sdks.gitbook.io/docs/using-mobile-extensions/analytics) to allow for integration with flutter applications. Functionality to enable the Analytics extension is provided entirely through Dart documented below.

## Installation

Install instructions for this package can be found [here](https://pub.dev/packages/flutter_acpanalytics#-installing-tab-).

> Note: After you have installed the SDK, don't forget to run `pod install` in your `ios` directory to link the libraries to your Xcode project.

## Tests

Run:

```bash
flutter test
```

## Usage

### [Analytics](https://aep-sdks.gitbook.io/docs/using-mobile-extensions/analytics)

##### Importing the SDK:
```dart
import 'package:flutter_acpanalytics/flutter_acpanalytics.dart';
```

##### Getting the SDK version:
 ```dart
String version = await FlutterACPAnalytics.extensionVersion;
 ```

 ##### Registering the extension with ACPCore:

 > Note: It is required to initialize the SDK via native code inside your AppDelegate and MainApplication for iOS and Android respectively. For more information see how to initialize [Core](https://aep-sdks.gitbook.io/docs/getting-started/initialize-the-sdk).

 ##### **iOS**
Swift
 ```swift
import ACPAnalytics

ACPAnalytics.registerExtension()
 ```
Objective-C
 ```objective-c
#import "ACPAnalytics.h"

[ACPAnalytics registerExtension];
 ```

 ##### **Android:**
 ```java
import com.adobe.marketing.mobile.Analytics;

Analytics.registerExtension();
 ```

 ##### Get the tracking identifier:

 ```dart
String trackingId;

try {
	trackingId = await FlutterACPAnalytics.trackingIdentifier;
} on PlatformException {
	log("Failed to get the tracking identifier");
}
 ```

 ##### Send queued hits:

 ```dart
FlutterACPAnalytics.sendQueuedHits();
 ```

 ##### Get the queue size:

 ```dart
int queueSize;

try {
	queueSize = await FlutterACPAnalytics.queueSize;
} on PlatformException {
	log("Failed to get the queue size");
}
 ```

 ##### Clear queued hits:

 ```dart
FlutterACPAnalytics.clearQueue();
 ```

 ##### Set the custom visitor identifier:

 ```dart
FlutterACPAnalytics.setVisitorIdentifier("vid");
 ```

 ##### Get the custom visitor identifier:

 ```dart
String visitorId;

try {
	visitorId = await FlutterACPAnalytics.visitorIdentifier;
} on PlatformException {
	visitorId = "Failed to get the visitor identifier";
}
 ```

 ##### Track app actions:

 ```dart
FlutterACPCore.trackAction("myAction",  data: {"key1": "value1"});
 ```

 ##### Track app states:

 ```dart
FlutterACPCore.trackState("myState",  data: {"key1": "value1"});
 ```

## Contributing
See [CONTRIBUTING](CONTRIBUTING.md)

## License
See [LICENSE](LICENSE)
