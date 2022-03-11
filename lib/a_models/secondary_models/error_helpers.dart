import 'package:bldrs/b_views/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:flutter/material.dart';

class HttpException implements Exception {
  /// --------------------------------------------------------------------------
  HttpException(this.message);
  /// --------------------------------------------------------------------------
  final String message;
  /// --------------------------------------------------------------------------
  @override
  String toString() {
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
  bool showErrorDialog = false,
}) async {

  try {
    await functions();
  }

  on Exception catch (error) {
    blog('$methodName : tryAndCatch ERROR : $error');

    if (onError != null) {
      onError(error.toString());
    }

    if (showErrorDialog == true) {
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
/// RETURNS TRUE IF SUCCESS AND FALSE ON FAILURE
Future<bool> tryCatchAndReturnBool({
  @required BuildContext context,
  @required Function functions,
  ValueChanged<String> onError,
  String methodName,
}) async {

  try {
    await functions();
    return true;
  }

  on Exception catch (error) {
    blog('$methodName : tryAndCatch ERROR : $error');

    if (onError != null) {
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
    if (error == null) {
      _return = true;
    } else {
      _return = false;
    }

    return _return;
  }
}
// -----------------------------------------------------------------------------
