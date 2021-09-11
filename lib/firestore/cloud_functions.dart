import 'package:bldrs/controllers/drafters/text_checkers.dart';
import 'package:bldrs/views/widgets/dialogs/center_dialog/center_dialog.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';

class CloudFunctionz{

  static String funcName_myFunction = 'myFunction';
  // static String callable_toBlackHole = 'toBlackHole';
  static String callable_randomNumber = 'randomNumber';
  static String callable_sayHello = 'x_sayHello';

  /// http trigger -> ( callable function - end point request )
  static Future<dynamic> callFunction({@required BuildContext context, String cloudFunctionName, Map<String, dynamic> toDBMap}) async {
    final HttpsCallable function = _getCallableFunction(funcName: cloudFunctionName);

    try {

      Map<String, dynamic> arguments = toDBMap == null ? {} : toDBMap;

      final _result = await function.call(arguments);

      return _result.data;
    }

    catch (e) {

      print('THE ERROR IS : xxxxx[${e.toString()}]xxxxx');

      bool unauthenticated = TextChecker.stringContainsSubString(
        string: e.toString(),
        subString: '/unauthenticated]',
        caseSensitive: true,
        multiLine: true,
      );

      print('unauthenticated IS $unauthenticated');


      if (unauthenticated == true){

        await CenterDialog.showCenterDialog(
          context: context,
          title: 'You Are not Signed in',
          body: 'Please Sign in into your account first',
          boolDialog: false,
        );

      }

      else {

        await CenterDialog.showCenterDialog(
          context: context,
          title: 'error',
          body: e.toString(),
          boolDialog: false,
        );

      }

      // rethrow;
    }

  }

  static HttpsCallable _getCallableFunction({String funcName}){
    return
        FirebaseFunctions.instance.httpsCallable(
          funcName,
          options: HttpsCallableOptions(timeout: const Duration(seconds: 60)),
        );
  }

  static Future<String> deleteFirebaseUser({String userID}) async {
    print('will delete user tomorrow isa, after 3eid');
    return 'rabena ysahhel';
  }

}