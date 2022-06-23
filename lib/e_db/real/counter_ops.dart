import 'dart:convert';
import 'package:bldrs/a_models/secondary_models/error_helpers.dart';
import 'package:bldrs/e_db/real/real_time_db_ops.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CounterOps {

  CounterOps();

// -----------------------------------------------------------------------------
  static const String _countersLink = 'https://www.bldrs.net/counters';
// -----------------------------------------------------------------------------
  static Future<void> incrementFlyerCounter({
    @required BuildContext context,
    @required String flyerID,
    @required String fieldName,
    @required String collName,
  }) async {

    String _docID;

    await tryAndCatch(
        context: context,
        functions: () async {

          /// post map to realtime database
          final http.Response _response = await http.post(
            Uri.parse(_countersLink),
            body: {
              'collName' : collName,
              'field' : fieldName,
              'id' : flyerID,
            },
            // json.encode({
            //   'field' : fieldName,
            //   'id' : flyerID,
            // }),
            headers: {
              'Content-Type': 'application/x-www-form-urlencoded',
            },
            // encoding:
          );

          blog('response is : ${_response.body}');

          /// --- get doc ID;
          _docID = json.decode(_response.body)['name'];

          blog('_docID is : $_docID');

        },
        onError: (String error) async {

          await RealTimeOps.onHttpError(
              context: context,
              error: error,
          );

        }

    );

    return _docID;


  }
// -----------------------------------------------------------------------------

}
