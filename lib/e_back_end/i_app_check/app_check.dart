import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/theme/standards.dart';
import 'package:firebase_app_check/firebase_app_check.dart';

class AppCheck {
  // -----------------------------------------------------------------------------

  const AppCheck();

  // -----------------------------------------------------------------------------
  /// WILL COME TO YOU LATER
  static Future<void> preInitialize() async {

    blog('AppCheck INITIALIZATION START');
    await FirebaseAppCheck.instance.activate(
      // webRecaptchaSiteKey: 'recaptcha-v3-site-key',
      webRecaptchaSiteKey: Standards.recaptchaSiteKey,
      androidProvider: AndroidProvider.playIntegrity,
    );
    blog('AppCheck INITIALIZATION END');
  }
  // --------------------------------------------
  ///
  static Future<String> getToken() async {
    final String appCheckToken = await FirebaseAppCheck.instance.getToken();
    return appCheckToken;
  }
// -----------------------------------------------------------------------------
}
