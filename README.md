# Platform-Specific Build Instructions

This package requires a few manual configuration steps for building on Android and iOS. Please follow the instructions below for each platform.

## Android

For Android, you need to add the following permissions in your **AndroidManifest.xml** file.

 **Path:** `android/app/src/main/AndroidManifest.xml`  
 **Place these inside the `<manifest>` tag, but outside the `<application>` tag:**

```xml
<uses-permission android:name="android.permission.INTERNET"/>
<uses-permission android:name="android.permission.RECORD_AUDIO" />
<uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
<uses-permission android:name="android.permission.CHANGE_NETWORK_STATE" />
<uses-permission android:name="android.permission.MODIFY_AUDIO_SETTINGS" />
```

These permissions ensure that the app has the required access to network connectivity and audio features.

## iOS

For iOS, you must add specific usage descriptions in your **Info.plist** file.

 **Path:** `ios/Runner/Info.plist`  
 **Add the following entries inside the `<dict>` tag:**

```xml
<key>NSMicrophoneUsageDescription</key>
<string>$(PRODUCT_NAME) uses your microphone</string>
```

These keys are required for iOS to prompt the user for permission to access the microphone.

---

### iOS Build Error: Deployment Target

If you encounter an error like:

```
The plugin "flutter_webrtc" requires a higher minimum iOS deployment version than your application is targeting.
```

You need to update your iOS **Podfile** to target iOS 13.0 or higher.

**Path:** `ios/Podfile`  
**Find and update this line:**

```ruby
platform :ios, '13.0'
```

Then run the following commands in your terminal:

```bash
cd ios
pod install
```

Finally, return to your project root and run:

```bash
flutter clean
flutter run
```

This will ensure compatibility with plugins that require a minimum iOS version (like `flutter_webrtc`).

---

Once these changes are added, you’re all set to build and run the app on Android and iOS!
