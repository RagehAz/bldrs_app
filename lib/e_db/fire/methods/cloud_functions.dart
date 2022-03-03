import 'package:bldrs/b_views/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/f_helpers/drafters/text_checkers.dart' as TextChecker;
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';

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

//------------------------------------------------------------------------------
const String funcNameMyFunction = 'myFunction';
// String callable_toBlackHole = 'toBlackHole';
const String callableRandomNumber = 'randomNumber';
const String callableSayHello = 'x_sayHello';
//------------------------------------------------------------------------------
/// http trigger -> ( callable function - end point request )
Future<dynamic> callFunction(
    {@required BuildContext context,
    String cloudFunctionName,
    Map<String, dynamic> toDBMap}) async {
  final HttpsCallable _function =
      _getCallableFunction(funcName: cloudFunctionName);

  try {
    final Map<String, dynamic> _arguments = toDBMap ?? <String, dynamic>{};

    final HttpsCallableResult _result = await _function.call(_arguments);

    return _result.data;
  } on Exception catch (e) {
    blog('THE ERROR IS : xxxxx[${e.toString()}]xxxxx');

    final bool _unauthenticated = TextChecker.stringContainsSubString(
      string: e.toString(),
      subString: '/unauthenticated]',
    );

    blog('unauthenticated IS $_unauthenticated');

    if (_unauthenticated == true) {
      await CenterDialog.showCenterDialog(
        context: context,
        title: 'You Are not Signed in',
        body: 'Please Sign in into your account first',
      );
    } else {
      await CenterDialog.showCenterDialog(
        context: context,
        title: 'error',
        body: e.toString(),
      );
    }

    // rethrow;
  }
}

//------------------------------------------------------------------------------
HttpsCallable _getCallableFunction({String funcName}) {
  return FirebaseFunctions.instance.httpsCallable(
    funcName,
    options: HttpsCallableOptions(),
  );
}

//------------------------------------------------------------------------------
Future<String> deleteFirebaseUser({String userID}) async {
  blog('will delete user tomorrow isa, after 3eid');
  return 'rabena ysahhel';
}
//------------------------------------------------------------------------------
