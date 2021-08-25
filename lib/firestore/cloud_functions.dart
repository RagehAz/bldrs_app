import 'package:cloud_functions/cloud_functions.dart';

class CloudFunctionz{

  Future<dynamic> getTheThing() async {
    final function = _getCallableFunction(funcName: 'theThing');

    try {

      final _result = await function.call({
        // arguments here
      });

      return _result.data;
    }

    catch (e) {
      print('getTheThing error is : $e');
      rethrow;
    }

  }

  HttpsCallable _getCallableFunction({String funcName}){
    return
        FirebaseFunctions.instance.httpsCallable(
          funcName,
          options: HttpsCallableOptions(timeout: const Duration(seconds: 60)),
        );
  }

}