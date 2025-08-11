# Samora Flutter Widget

A Flutter widget that allows integration of a Samora voice assistant agent into your app. Make sure you follow the platform-specific build setup before using the widget.

---

## 📦 Installation

You can install this package by adding the following to your `pubspec.yaml`:

```yaml
dependencies:
  b2b_agent_flutter_widget:
    git:
      url: https://github.com/I-Stem/b2b-agent-flutter-widget
```

Then run:

```bash
flutter pub get
```

---

## 🚀 Usage

You can embed the widget in your app like this:

```dart
import 'package:b2b_agent_flutter_widget/b2b_agent_flutter_widget.dart';

...

child: B2BAgentFlutterWidget(
  participantId: '<participant-id>',
  agentId: '<agent-id>',
  publicKey: '<org-public-key>',
),
```

---

## ⚠️ Breaking changes (latest)

- Removed `companyId` and `agentServiceKey` from `B2BAgentFlutterWidget`. Use `publicKey` instead.

---

## ⚙️ Platform-Specific Build Instructions

This package requires a few manual configuration steps for building on Android and iOS. Please follow the instructions below for each platform.

---

### 🤖 Android

For Android, you need to add the following permissions in your **AndroidManifest.xml** file.

📍 **Path:** `android/app/src/main/AndroidManifest.xml`  
📌 **Place these inside the `<manifest>` tag, but outside the `<application>` tag:**

```xml
<uses-permission android:name="android.permission.INTERNET"/>
<uses-permission android:name="android.permission.RECORD_AUDIO" />
<uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
<uses-permission android:name="android.permission.CHANGE_NETWORK_STATE" />
<uses-permission android:name="android.permission.MODIFY_AUDIO_SETTINGS" />
```

---

### 🍏 iOS

For iOS, you must add specific usage descriptions in your **Info.plist** file.

📍 **Path:** `ios/Runner/Info.plist`  
📌 **Add the following entry inside the `<dict>` tag:**

```xml
<key>NSMicrophoneUsageDescription</key>
<string>$(PRODUCT_NAME) uses your microphone</string>
```

---

#### ❗ iOS Build Error: Deployment Target

If you encounter an error like:

```
The plugin "flutter_webrtc" requires a higher minimum iOS deployment version than your application is targeting.
```

You need to update your iOS **Podfile** to target iOS 13.0 or higher.

📍 **Path:** `ios/Podfile`  
📌 **Find and update this line:**

```ruby
platform :ios, '13.0'
```

Then run:

```bash
cd ios
pod install
```

Finally, return to your project root and run:

```bash
flutter clean
flutter run
```

---

✅ Once these changes are made, you’re all set to build and run the app with `B2BAgentFlutterWidget` on both Android and iOS!
