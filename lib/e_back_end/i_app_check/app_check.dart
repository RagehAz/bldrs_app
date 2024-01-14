import 'package:basics/helpers/checks/device_checker.dart';
// import 'package:bldrs/bldrs_keys.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:flutter/foundation.dart';

/// LEARN : https://firebase.google.com/docs/app-check/flutter/debug-provider
/// TO IMPLEMENT ON IOS AND SEE IF IT WORKS
///
class AppCheck {
  // -----------------------------------------------------------------------------

  const AppCheck();

  // -----------------------------------------------------------------------------
  /// 8 DEC 2020 : THIS IS THE APP CHECK SECRET : 6dc38317-d40c-489a-9b46-13257524fab7
  ///                                          ->
  /// AT THE START OF ANY NEW EMULATOR : SEARCH PRINTED LOG FOR THIS LINE TO GET THE NEW SECRET:-
  /*
  Enter this debug secret into the allow list in the Firebase Console for your project
  */
  /// WILL COME TO YOU LATER
  static Future<void> preInitialize() async {

    // final bool _runAppCheck = checkCanRunAppCheck();
    //
    // if (_runAppCheck == true){
    //   await FirebaseAppCheck.instance.activate(
    //     // webProvider: WebProvider.,
    //     webRecaptchaSiteKey: BldrsKeys.recaptchaSiteKey, /// this is 'recaptcha-v3-site-key'
    //     androidProvider: kDebugMode == true ? AndroidProvider.debug : AndroidProvider.playIntegrity,
    //
    //   );
    // }

  }
  // --------------------
  ///
  static bool checkCanRunAppCheck(){

    if (kIsWeb == true){
      return false;
    }
    else if (DeviceChecker.deviceIsWindows() == true){
      return false;
    }
    else if (DeviceChecker.deviceIsIOS() == true){
      return false;
    }
    else if (DeviceChecker.deviceIsAndroid() == true){
      return true;
    }
    else {
      return false;
    }

  }
  // --------------------
  ///
  static Future<String?> getAppCheckToken() async {
    final String? appCheckToken = await FirebaseAppCheck.instance.getToken();
    return appCheckToken;
  }
  // -----------------------------------------------------------------------------
}
