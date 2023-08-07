# flutter_acpanalytics

## Notice of deprecation

Since *April 25, 2023*, [Apple has required](https://developer.apple.com/news/?id=jd9wcyov) apps submitted to the App Store to be built with Xcode 14.1 or later. The Experience Platform Mobile SDKs and extensions outlined below were built with prior versions of Xcode and are no longer compatible with iOS and iPadOS given Apple’s current App Store requirements. Consequently, on *August 31, 2023*, Adobe will be deprecating support for the following Experience Platform Mobile SDKs and wrapper extensions:

- [ACP iOS SDK](https://developer.adobe.com/client-sdks/previous-versions/documentation/sdk-versions/#ios)
- [Cordova](https://developer.adobe.com/client-sdks/previous-versions/documentation/sdk-versions/#cordova)
- [Flutter for ACP](https://developer.adobe.com/client-sdks/previous-versions/documentation/sdk-versions/#flutter)
- [React Native for ACP](https://developer.adobe.com/client-sdks/previous-versions/documentation/sdk-versions/#react-native)
- [Xamarin](https://developer.adobe.com/client-sdks/previous-versions/documentation/sdk-versions/#xamarin)

After *August 31, 2023*, applications already submitted to the App Store that contain these SDKs and wrapper extensions will continue to operate, however, Adobe will not be providing security updates or bug fixes, and these SDKs and wrapper extensions will be provided as-is exclusive of any warranty, due to the App Store policy outlined above.

We encourage all customers to migrate to the latest Adobe Experience Platform versions of the Mobile SDK to ensure continued compatibility and support. Documentation for the latest versions of the Adobe Experience Platform Mobile SDKs can be found [here](https://developer.adobe.com/client-sdks/documentation/current-sdk-versions/). The iOS migration guide can be found [here](https://developer.adobe.com/client-sdks/previous-versions/documentation/migrate-to-swift/).

---

[![pub package](https://img.shields.io/pub/v/flutter_acpanalytics.svg)](https://pub.dartlang.org/packages/flutter_acpanalytics) ![Build](https://github.com/adobe/flutter_acpanalytics/workflows/Dart%20Unit%20Tests%20+%20Android%20Build%20+%20iOS%20Build/badge.svg) [![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

`flutter_acpanalytics` is a flutter plugin for the iOS and Android [AEP Analytics SDK](https://developer.adobe.com/client-sdks/previous-versions/documentation/adobe-analytics/) to allow for integration with flutter applications. Functionality to enable the Analytics extension is provided entirely through Dart documented below.

## Installation

Install instructions for this package can be found [here](https://pub.dev/packages/flutter_acpanalytics/install).

> Note: After you have installed the SDK, don't forget to run `pod install` in your `ios` directory to link the libraries to your Xcode project.

## Tests

Run:

```bash
flutter test
```

## Usage

### Analytics

##### Importing the SDK:
```dart
import 'package:flutter_acpanalytics/flutter_acpanalytics.dart';
```

##### Getting the SDK version:
 ```dart
String version = await FlutterACPAnalytics.extensionVersion;
 ```

 ##### Registering the extension with ACPCore:

 > Note: It is required to initialize the SDK via native code inside your AppDelegate and MainApplication for iOS and Android respectively. For more information see how to initialize [Core](https://developer.adobe.com/client-sdks/previous-versions/documentation/mobile-core/api-reference/#registerextensions).

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
