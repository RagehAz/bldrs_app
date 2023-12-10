
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

### OLD TALISMAN
    pod deintegrate
    pod repo remove trunk
    sudo gem install cocoapods-deintegrate cocoapods-clean
    pod cache clean --all
    sudo gem uninstall cocoapods
    sudo gem install cocoapods
    pod deintegrate
    pod repo remove trunk
    pod setup
    pod install --verbose
    pod update --verbose
    flutter build ios-framework --output=Flutter -v

## if you want to create Release Files, you should use command
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

## The Final Building Talisman

1. GO
cd /Users/rageh/Developer/apps/bldrs
rm pubspec.lock
rm -rf ios/Pods
rm ios/Podfile.lock
cd /Users/rageh/Developer/apps/bldrs
flutter clean
flutter pub get
brew reinstall cocoapods
echo 'export PATH=$HOME/.gem/ruby/2.6.0/bin:$PATH' >> ~/.bashrc
source ~/.bashrc
echo $PATH
pod --version
cd /Users/rageh/Developer/apps/bldrs/ios
pod deintegrate
pod setup
pod cache clean --all
pod install --verbose
pod update --verbose
flutter build ios-framework --output=Flutter -v




## REINSTALL COCOAPODS
gem install cocoapods --user-install

## check the log for ruby updates to run
gem update --system 3.4.22

## fix path
echo 'export PATH=$HOME/.gem/ruby/2.6.0/bin:$PATH' >> ~/.bashrc
source ~/.bashrc
echo $PATH
pod --version

## OTHER
brew install cocoapods






