import 'package:bldrs/helpers/drafters/tracers.dart';
import 'package:bldrs/views/widgets/general/dialogs/center_dialog/center_dialog.dart';
import 'package:flutter/material.dart';

class HttpException implements Exception{
  /// --------------------------------------------------------------------------
  HttpException(this.message);
  /// --------------------------------------------------------------------------
  final String message;
  /// --------------------------------------------------------------------------
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
  }
  on Exception catch (error){

    blog('$methodName : tryAndCatch ERROR : $error');

    if (onError != null){

      onError(error.toString());
      // await null;

    }
    else {

      await CenterDialog.showCenterDialog(
        context: context,
        body: error,
        title: 'Something Went Wrong !',
      );

    }

    // throw(error);
  }
}
// -----------------------------------------------------------------------------
Future<bool> tryCatchAndReturn({
  @required BuildContext context,
  @required Function functions,
  ValueChanged<String> onError,
  String methodName,
}) async {

  try{
    await functions();
    return true;
  }

  on Exception catch (error){

    blog('$methodName : tryAndCatch ERROR : $error');

    if (onError != null){
      onError(error.toString());
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

    bool _return;
    if (error == null){
      _return = true;
    }
    else {
      _return = false;
    }

    return _return;
  }
}
// -----------------------------------------------------------------------------
