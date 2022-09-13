import 'package:bldrs/a_models/secondary_models/error_helpers.dart';
import 'package:bldrs/b_views/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/f_helpers/drafters/text_checkers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
/// ------------------------------------------------o
/*
CLOUD FUNCTIONS ARTICLES

check this
https://jsmobiledev.com/article/firestore-functions/

AND THIS
https://stackoverflow.com/questions/66194726/how-do-i-query-a-token-and-send-push-notifications-inside-cloud-function

AND THIS
https://stackoverflow.com/questions/37990140/how-to-send-one-to-one-message-using-firebase-messaging

AND THIS
https://firebase.google.com/docs/cloud-messaging/android/client

AND THIS
https://engineering.monstar-lab.com/2021/02/09/Use-Firebase-Cloudfunctions-To-Send-Push-Notifications

{
likeCount: 50
}
FieldValue ++

// -----------------------------------------------------------------------------
*/
/// ------------------------------------------------o
class CloudFunction {
  // -----------------------------------------------------------------------------

  const CloudFunction();

  // -----------------------------------------------------------------------------

  /// CLOUD FUNCTIONS NAMES

  // --------------------
  static const String sendNotificationToDevice = 'sendNotificationToDevice';
  // -----------------------------------------------------------------------------

  /// CALLERS

  // --------------------
  /// TESTED :
  static Future<dynamic> callFunction({
    @required BuildContext context,
    String cloudFunctionName,
    Map<String, dynamic> toDBMap,
  }) async {

    /// http trigger -> ( callable function - end point request )

    final HttpsCallable _function = _getCallableFunction(
      funcName: cloudFunctionName,
    );

    dynamic _output;

    await tryAndCatch(
        context: context,
        methodName: 'CLOUD FUNCTIONS : callFunction',
        functions: () async {

          final Map<String, dynamic> _arguments = toDBMap ?? <String, dynamic>{};

          final HttpsCallableResult _result = await _function.call(_arguments);

          _output = _result.data;
        },
        onError: (String error) async {

          final bool _unauthenticated = TextCheck.stringContainsSubString(
            string: error,
            subString: '/unauthenticated]',
          );

          blog('callFunction : unauthenticated IS $_unauthenticated');

          if (_unauthenticated == true) {
            await CenterDialog.showCenterDialog(
              context: context,
              titleVerse: const Verse(
                pseudo: '##You Are not Signed in',
                text: 'phid_your_not_signed_in',
                translate: true,
              ),
              bodyVerse: const Verse(
                text: 'phid_please_sign_in_first',
                translate: true,
              ),
            );
          }

          else {
            await CenterDialog.showCenterDialog(
              context: context,
              titleVerse: const Verse(
                text: 'phid_error',
                translate: true,
              ),
              bodyVerse: Verse(
                text: error,
                translate: false,
              ),
            );
          }

        }
    );

    return _output;
  }
  // --------------------
  static HttpsCallable _getCallableFunction({String funcName}) {
    return FirebaseFunctions.instance.httpsCallable(
      funcName,
      options: HttpsCallableOptions(
        // timeout:
      ),
    );
  }
  // -----------------------------------------------------------------------------
}
/// ------------------------------------------------o
const String funcNameMyFunction = 'myFunction';
// String callable_toBlackHole = 'toBlackHole';
const String callableRandomNumber = 'randomNumber';
const String callableSayHello = 'x_sayHello';
/// ------------------------------------------------o
Future<String> deleteFirebaseUser({String userID}) async {
  blog('will delete user tomorrow isa, after 3eid');
  return 'rabena ysahhel';
}
/// ------------------------------------------------o
