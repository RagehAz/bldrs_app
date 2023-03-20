// -----------------------------------------------------------------------------

/// APK BUILDING

// --------------------
/// flutter build apk --split-per-abi
// --------------------
/// to build clean ON IOS
/*
 flutter clean \
        && rm ios/Podfile.lock pubspec.lock \
        && rm -rf ios/Pods ios/Runner.xcworkspace \
        && flutter build ios --build-name=1.0.0 --build-number=1 --release --dart-define=MY_APP_ENV=prod
 */
// -----------------------------------------------------------------------------

/// CREATE ANDROID KEYSTORE

// --------------------
/*
/// RUN THIS COMMAND
 keytool -genkey -v -keystore /projects/bldrs/key.jks -storetype JKS -keyalg RSA -keysize 2048 -validity 10000 -alias upload
 */
// -----------------------------------------------------------------------------

/// WEB BUILDING

// --------------------
/// to run on web and be able to open on phone browser while testing
/*
// flutter run -d web-server --web-hostname 0.0.0.0
// http://192.168.1.6:55600
 */
// --------------------
/// steps to DEPLOY bldr_web
/*
// 1 - flutter build web
// 2 - fix build/web/main.dart.js in line 27435 and put this =>
// [else a.xZ(0,s,"Bldrs.net",b)},]
// [else a.nX(0,s,"Bldrs.net",b)},]
// 3 - firebase deploy
*/
// -----------------------------------------------------------------------------

/// DASHBOARD

// --------------------
///  TO SWITCH DASHBOARD ON AND
/*
  1. search lib for ( ONLY_FOR_BLDRS_DASHBOARD_VERSION )
  2. uncomment the following lines
 */
// -----------------------------------------------------------------------------

/// GITHUB

// --------------------
/// GIT HUB TOKEN
/*
token : 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
*/
// --------------------
/// GIT COMMANDS
/*
git remote set-head origin https://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@github.com/Bldrs-net/bldrs.net.git
git remote add origin https://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@github.com/Bldrs-net/bldrs.net.git
git remote add origin https://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@github.com/Bldrs-net/bldrscolors.git
git remote add origin https://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@github.com/Bldrs-net/bldrs.net.git

git remote remove origin
 */
// -----------------------------------------------------------------------------

/// PACKAGING

// --------------------
/// TO CREATE A NEW PACKAGE
/*
 1. cd .. to go to directory
 2. flutter create --template=package <package_name>
 3. open the new created project in new window
 4. clean lib file
 5. clean tests file
 6. adjust pubspec.yaml
   - description
   - environment: sdk: ">=2.10.5 <3.0.0"
   - homepage
   - add dependencies if any
   - add publish_to: none after version
 7. create package files - move code - do magic
 8. write the exports in the lib file
 X. add lint rules in analysis.options
 9. attach github
   - go to https://github.com/orgs/Bldrs-net/repositories
   - create new repo
   - open terminal in project window, cd to project directory
   - copy git repo https link to pubscpec.yaml homepage field
   - git init
   - git remote add origin ...............
   - commit and push (git add ., git commit -m "first commit", git push -u origin master)
   - go to github and check if it worked
 10. import package in bldrs project
   -    package_name:
     git:
       url: https://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@github.com/Bldrs-net/package_name.git

*/
// -----------------------------------------------------------------------------

/// NULL SAFETY ISSUE

// --------------------
/// until you upgrade to null safety code,, run these
/*
  dart --no-sound-null-safety run
  flutter run --no-sound-null-safety
 */
// -----------------------------------------------------------------------------

/// BUSINESS STUFF

// --------------------
/// INFO ABOUT ESTABLISHING COMPANY IN DUBAI FREE ZONE
/*
15'900 Dirhams
650 establishment fees
3500 processing / 2 years

free zone
17900 dirhams
2200 establishment fees
2500 professional fees
 = 150'000 EGP
 */
// ---------------------------------------------------------------------------
/// INFO ABOUT ESTABLISHING A COMPANY IN USA
/*
  siliconValleyBank.com
  accountantsOnAir.com
  dalware
 */
// ---------------------------------------------------------------------------

/// To run on my Note3 mobile,
/// flutter run --release -d 4d00c32746ba80bf

/// To run on all emulators',
/// flutter run --debug -d all', //'flutter run -d all',

/// Google Maps API key',
///'AIzaSyDQGuhqhKu1mSdNxAbS_BCP8NfCB1ENmaI',

/// 'Google Maps Platform API key',
/// 'AIzaSyDp6MMLw2LJflspqJ0x2uZCmQuZ32vS3XU', // AIzaSyD5CBTWvMaL6gU0X7gfdcnkpFmo-aNfgx4

// ---------------------------------------------------------------------------

/// CHAT GBT TEST REQUEST
/*

for the following flutter method, write group of test methods in one test group to assure its
perfectly working

 */

// ---------------------------------------------------------------------------
