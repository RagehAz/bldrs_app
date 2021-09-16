// -----------------------------------------------------------------------------
import 'package:bldrs/views/widgets/dialogs/center_dialog/center_dialog.dart';
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
Future<void> tryAndCatch({Function onError, BuildContext context, Function functions, String methodName,}) async {
  try{
    await functions();
  } catch (error){

    print('$methodName : tryAndCatch ERROR : $error');

    if (onError != null){

      onError(error);

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
Future<dynamic> tryCatchAndReturn({Function finals, BuildContext context, Function functions, String methodName,}) async {
  try{
    await functions();
  } catch (error){

    // await superDialog(
    //   context: context,
    //   title: 'ops',
    //   body: error,
    //   boolDialog: false,
    // );

    print('$methodName : tryAndCatch ERROR : $error');

    return error.toString();
  }
}
// -----------------------------------------------------------------------------
