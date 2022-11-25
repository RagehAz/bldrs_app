import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:bldrs/f_helpers/drafters/error_helpers.dart';
import 'package:bldrs/b_views/z_components/bubbles/a_structure/bubble_header.dart';
import 'package:bldrs/b_views/z_components/dialogs/dialogz/dialogs.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
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
      invoker: 'REST : postMap : $invoker',
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
    int timeoutSeconds = 10,
  }) async {

    http.Response _response;

    try {

      // blog('rest.get : _imageUri : $rawLink');

      /// GET REQUEST
      _response = await http.get(
        Uri.parse(rawLink),
        headers: headers,
      ).timeout(
          Duration(seconds: timeoutSeconds),
          onTimeout: () async {
            blog('Rest.get timeout occurred');
            return null;
          }
      );

      // blog('rest.get : _response : ${_response?.body}');

    }
    on TimeoutException catch (error) {
      blog('Rest.get.TimeoutException : $invoker : error.message : ${error.message}');
    }
    on Exception catch (error) {
      blog('Rest.get.Exception : $invoker : error.message : $error');
    }

    // if (_response != null){
      // final response = await request.close().timeout(const Duration(seconds: 10));
    // }

    return _checkUpResponse(
      context: context,
      response: _response,
      showErrorDialog: showErrorDialog,
      invoker: invoker,
    );

  }
  // --------------------
  ///
  static Future<Uint8List> readBytes({
    // @required BuildContext context,
    @required String rawLink,
    String invoker = '',
    int timeoutSeconds = 2,
    Map<String, String> headers,
  }) async {

    Uint8List _uInts;

    await tryAndCatch(
      // context: context,
      invoker: 'REST : get : $invoker',
      functions: () async {

        /// GET REQUEST
        _uInts = await http.readBytes(
          Uri.parse(rawLink),
          headers: headers,
        ).timeout(
            Duration(seconds: timeoutSeconds),
            onTimeout: () async {
              blog('Rest.get timeout occurred');
              return null;
            }
        );


      },


    );

    return _uInts;

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
      invoker: 'Rest : patch : $invoker',
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
      invoker: 'Rest : delete : $invoker',
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
