import 'package:cloud_functions/cloud_functions.dart';

class CloudFunctionz{

  static String funcName_myFunction = 'myFunction';
  static String funcName_randomNumber = 'randomNumber';
  static String funcName_toBlackHole = 'toBlackHole';
  static String funcName_sayHello = 'sayHello';

  /// http trigger -> ( callable function - end point request )
  static Future<dynamic> callFunction({String cloudFunctionName}) async {
    final HttpsCallable function = _getCallableFunction(funcName: cloudFunctionName);

    try {

      final _result = await function.call({
        // arguments here
        'name' : 'Abbas El Daw',
      });

      return _result.data;
    }

    catch (e) {
      print('getTheThing error is : $e');
      rethrow;
    }

  }

  static HttpsCallable _getCallableFunction({String funcName}){
    return
        FirebaseFunctions.instance.httpsCallable(
          funcName,
          options: HttpsCallableOptions(timeout: const Duration(seconds: 60)),
        );
  }

}