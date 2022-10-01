import 'dart:convert';

import 'package:bldrs/a_models/secondary_models/error_helpers.dart';
import 'package:bldrs/b_views/z_components/bubble/bubble_header.dart';
import 'package:bldrs/b_views/z_components/dialogs/dialogz/dialogs.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Rest {
  // -----------------------------------------------------------------------------

  const Rest();

  // -----------------------------------------------------------------------------

  /// CREATE

  // --------------------
  static Future<http.Response> postMap({
    @required BuildContext context,
    @required Map<String, dynamic> map,
    @required String rawLink,
    @required bool showErrorDialog,
    Map<String, String> headers,
    Encoding encoding,
    String invoker = '',
  }) async {

    http.Response _response;

    await tryAndCatch(
      context: context,
      methodName: 'REST : postMap : $invoker',
      functions: () async {

        /// POST REQUEST
        _response = await http.post(
          Uri.parse(rawLink),
          body: json.encode(map),
          headers: headers,
          encoding: encoding,
        );

      },

    );

    return _checkUpResponse(
      context: context,
      response: _response,
      showErrorDialog: showErrorDialog,
      invoker: invoker,
    );

  }
  // -----------------------------------------------------------------------------

  /// READ

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<http.Response> get({
    @required BuildContext context,
    @required String rawLink,
    @required bool showErrorDialog,
    Map<String, String> headers,
    String invoker = '',
    int timeout = 2,
  }) async {

    http.Response _response;

    await tryAndCatch(
      context: context,
      methodName: 'REST : get : $invoker',
      functions: () async {

        /// GET REQUEST
        _response = await http.get(
          Uri.parse(rawLink),
          headers: headers,
        ).timeout(
            Duration(seconds: timeout),
            onTimeout: () async {
              blog('Rest.get timeout occurred');
              return null;
            }
            );
      },

    );

    return _checkUpResponse(
      context: context,
      response: _response,
      showErrorDialog: showErrorDialog,
      invoker: invoker,
    );

  }
  // -----------------------------------------------------------------------------

  /// UPDATE

  // --------------------
  static Future<http.Response> patchMap({
    @required BuildContext context,
    @required Map<String, dynamic> input,
    @required String rawLink,
    @required bool showErrorDialog,
    Map<String, String> headers,
    Encoding encoding,
    String invoker = '',
  }) async {

    http.Response _response;

    await tryAndCatch(
      context: context,
      methodName: 'Rest : patch : $invoker',
      functions: () async {

        /// PATCH REQUEST
        _response = await http.patch(
          Uri.parse(rawLink),
          body: json.encode(input),
          headers: headers,
          encoding: encoding,
        );

      },

    );

    return _checkUpResponse(
      context: context,
      response: _response,
      showErrorDialog: showErrorDialog,
      invoker: invoker,
    );

  }
  // -----------------------------------------------------------------------------

  /// DELETE

  // --------------------
  static Future<http.Response> delete({
    @required BuildContext context,
    @required String rawLink,
    @required bool showErrorDialog,
    Object body,
    Map<String, String> headers,
    Encoding encoding,
    String invoker = '',
  }) async {

    http.Response _response;

    await tryAndCatch(
      context: context,
      methodName: 'Rest : delete : $invoker',
      functions: () async {

        /// DELETE REQUEST
        _response = await http.delete(
          Uri.parse(rawLink),
          body: body,
          headers: headers,
          encoding: encoding,
        );

      },

    );

    return _checkUpResponse(
      context: context,
      response: _response,
      showErrorDialog: showErrorDialog,
      invoker: invoker,
    );

  }
  // -----------------------------------------------------------------------------

  /// ERROR HANDLING

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<http.Response> _checkUpResponse({
    @required BuildContext context,
    @required http.Response response,
    @required bool showErrorDialog,
    @required String invoker,
  }) async {

    http.Response _output;

    /// RESPONSE IS NULL
    if (response == null){
      blog('REST : _checkUpResponse : response is null');
    }

    /// RESPONSE RECEIVED
    else {

      if (response.statusCode == 200){
        _output = response;
      }

      else if (response.statusCode >= 400){

        await  _onHttpError(
          context: context,
          showErrorDialog: showErrorDialog,
          error: response.body,
          invoker: invoker,
        );

      }

    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> _onHttpError({
    @required BuildContext context,
    @required String error,
    @required String invoker,
    bool showErrorDialog = false,
  }) async {

    blog('onHttpError : $invoker : error : $error');

    if (showErrorDialog == true){

      await Dialogs.errorDialog(
        context: context,
        bodyVerse: Verse.plain(error)
      );

    }

  }
  // -----------------------------------------------------------------------------
}
