import 'dart:convert';
import 'package:bldrs/a_models/secondary_models/error_helpers.dart';
import 'package:bldrs/e_db/real/real_time_db_ops.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CounterOps {

  CounterOps();
// -----------------------------------------------------------------------------
  static const String _herokuLink = 'waiting you nour';
// -----------------------------------------------------------------------------
  static Future<void> incrementFlyerCounter({
    @required BuildContext context,
    @required String flyerID,
    @required String fieldName,
  }) async {

    String _docID;

    await tryAndCatch(
        context: context,
        functions: () async {

          /// post map to realtime database
          final http.Response _response = await http.post(
            Uri.parse(_herokuLink),
            body: json.encode({
              'fieldName' : fieldName,
              'action' : 'increment',
            }),
          );

          blog('response is : $_response');

          /// --- get doc ID;
          _docID = json.decode(_response.body)['name'];

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
