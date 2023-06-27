import 'package:basics/helpers/classes/checks/device_checker.dart';
import 'package:bldrs/bldrs_keys.dart';
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

    /// TRIAL ONE
    // blog('AppCheck INITIALIZATION START');
    if (DeviceChecker.deviceIsWindows() == false){
      await FirebaseAppCheck.instance.activate(
        webRecaptchaSiteKey: BldrsKeys.recaptchaSiteKey, /// this is 'recaptcha-v3-site-key'
        androidProvider: kDebugMode == true ? AndroidProvider.debug : AndroidProvider.playIntegrity,
      );
    }
    // blog('AppCheck INITIALIZATION END');


  }
  // --------------------------------------------
  ///
  static Future<String> getAppCheckToken() async {
    final String appCheckToken = await FirebaseAppCheck.instance.getToken();
    return appCheckToken;
  }
// -----------------------------------------------------------------------------
}
