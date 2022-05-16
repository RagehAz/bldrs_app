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
/// TESTED : WORKS PERFECT
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
/// TESTED : WORKS PERFECT
Future<bool> tryCatchAndReturnBool({
  @required BuildContext context,
  @required Function functions,
  ValueChanged<String> onError,
  String methodName = 'tryCatchAndReturnBool',
}) async {
  /// IF FUNCTIONS SUCCEED RETURN TRUE, IF ERROR CAUGHT RETURNS FALSE
  bool _success = true;

  /// TRY FUNCTIONS
  try {
    await functions();
  }

  /// CATCH EXCEPTION ERROR
  on Exception catch (error) {

    blog('$methodName : tryAndCatch ERROR : $error');

    if (onError != null) {
      onError(error.toString());
    }

    _success = false;
  }

  return _success;
}
// -----------------------------------------------------------------------------
