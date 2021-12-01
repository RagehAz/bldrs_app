// -----------------------------------------------------------------------------
import 'package:bldrs/views/widgets/general/dialogs/center_dialog/center_dialog.dart';
import 'package:flutter/material.dart';

class HttpException implements Exception{
  final String message;

  HttpException(this.message);

  @override
  String toString(){
    return message;
    // return super.toString(); // instance of HttpException
  }
}
// -----------------------------------------------------------------------------
Future<void> tryAndCatch({
  @required BuildContext context,
  @required Function functions,
  String methodName,
  ValueChanged<String> onError,
}) async {
  try{
    await functions();
  } catch (error){

    print('$methodName : tryAndCatch ERROR : $error');

    if (onError != null){

      await onError(error);

    }
    else {

      await CenterDialog.showCenterDialog(
        context: context,
        boolDialog: false,
        body: error,
        title: 'Something Went Wrong !',
      );

    }

    // throw(error);
  }
}
// -----------------------------------------------------------------------------
Future<bool> tryCatchAndReturn({Function onError, BuildContext context, Function functions, String methodName}) async {
  try{
    await functions();
    return true;
  } catch (error){

    print('$methodName : tryAndCatch ERROR : $error');

    if (onError != null){

      await onError(error);

    }
    // else {
      // await CenterDialog.showCenterDialog(
      //   context: context,
      //   boolDialog: false,
      //   body: error,
      //   title: 'Something Went Wrong !',
      // );
    // }


    // throw(error);
    return error == null ? true : false;
  }
}
// -----------------------------------------------------------------------------
