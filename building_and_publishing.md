---
### ANDROID PUBLISHING INSTRUCTIONS


1. run 
flutter build appbundle

2. drag file in this location to play store
D:\projects\bldrs\bldrs_app\build\app\outputs\bundle\release
\app-release.aab

3. go to https://play.google.com/console/u/0/developers/6309889359528388528/app-list
4. go to select the app => click Production on the left => click Create Release Button on top right
5. upload new bundle

---

### to build clean ON IOS

    flutter clean
    rm ios/Podfile.lock pubspec.lock
    rm -rf ios/Pods ios/Runner.xcworkspace
    flutter build ios --build-name=1.0.0 --build-number=1 --release --dart-define=MY_APP_ENV=prod

---

### on ios error : No such module 'Flutter' : Xcode 13.2.1

    ### super duper clean
    delete ios/Pods
    delete ios/Podfile.lock
    delete pubspec.lock
    flutter clean
    flutter pub get
    pod deintegrate
    pod repo remove trunk
    sudo gem install cocoapods-deintegrate cocoapods-clean
    pod cache clean --all
    sudo gem uninstall cocoapods
    sudo gem install cocoapods
    pod setup
    pod install --verbose
    pod update --verbose
    flutter build ios-framework --output=Flutter

    ### just clean build
    delete ios/Pods
    delete ios/Podfile.lock
    delete pubspec.lock
    flutter clean
    flutter pub get
    pod deintegrate
    pod repo remove trunk
    pod setup
    pod install --verbose
    flutter build ios-framework --output=Flutter

if you want to create Release Files, 
you should use command

    flutter build ios-framework --no-debug --no-profile --release --output=Flutter

---

### to publish

1. run
    flutter build ipa

2. open folder in finder
   /Users/rageh/Developer/apps/bldrs/build/ios/archive/Runner.xcarchive

3. double click the Runner.xcarchive file
4. distribute app
https://www.youtube.com/watch?v=6QMadUJF78U


### PODS LOCATION
/Users/rageh/Library/Caches/CocoaPods/Pods

1. Bldrs.net does not track any data for advertising purpose neither shares it to any third party or any data broker.
2. Bldrs.net does not use user data for thrid party advertising or my advertising or marketing
3. data collection will only start if user decides to sign up a user account. and the default usage is the user uses the app anonymously
4. Any data collected are optional to the user to add but might be mandatory to open authenticated users only sections, and all data collected are properly addressed to the user
