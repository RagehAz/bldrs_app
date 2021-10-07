import 'package:bldrs/models/helpers/error_helpers.dart';
import 'package:bldrs/views/widgets/general/dialogs/dialogz.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

///  FIREBASE REAL TIME DATA BASE OPERATIONS
abstract class RealTimeOps{
// -----------------------------------------------------------------------------
  static Uri collectionLink(String collName){
    return Uri.parse('https://bldrsnet.firebaseio.com/${collName}.json');
  }
// -----------------------------------------------------------------------------
  static Uri docLink({String collName, String docName}){
    return Uri.parse('https://bldrsnet.firebaseio.com/${collName}/${docName}.json');
  }
// -----------------------------------------------------------------------------
  static Future<void> _onError(BuildContext context, String error) async {

    await Dialogz.authErrorDialog(
      context: context,
      result: error,
    );

  }
// -----------------------------------------------------------------------------
  /// if succeeds, returns docID
  static Future<String> insertDoc({BuildContext context, String docName, Map<String, Object> input}) async {

    String _docID;

    await tryAndCatch(
        context: context,
        functions: () async {

          /// post map to realtime database
          final http.Response _response = await http.post(
            collectionLink(docName),
            body: json.encode({
              input
            }),
          );

          /// --- get doc ID;
          _docID = json.decode(_response.body)['name'];

          },
        onError: (String error) async {

          await _onError(context, error);

        }

        );

    return _docID;
  }
// -----------------------------------------------------------------------------
  static Future<void> updateDoc({BuildContext context, String collName, String docName, Map<String, Object> input}) async {

    await tryAndCatch(
        context: context,
        functions: () async {

          /// post map to realtime database
          final http.Response _response = await http.patch(
            docLink(collName: collName, docName: docName),
            body: json.encode({
              input
            }),
          );

          /// --- get things
          // dynamic things = json.decode(_response.body)['name'];

        },
        onError: (String error) async {

          await _onError(context, error);

        }

    );

  }
// -----------------------------------------------------------------------------
  static Future<void> deleteDoc({BuildContext context, String collName, String docName,}) async {

    final http.Response _response = await http.delete(docLink(collName: collName, docName: docName),);

    if(_response.statusCode >= 400){

      // can assign 'failed' value to a variable and return it from here
      // to be able to handle failed scenarios to see wether to keep or delete
      // the doc locally on providers or ldbs

      await _onError(context, _response.body,);

      // throw HttpException('Could not delete Business');
    }

  }
// -----------------------------------------------------------------------------
  static Future<Map<String, Object>> readDoc({BuildContext context, String collName, String docName,}) async {

    Map<String, Object> _map;

    await tryAndCatch(
        context: context,
        functions: () async {

          /// READ data
          final http.Response response = await http.get(docLink(collName: collName, docName: docName));

          _map = json.decode(response.body);

        },

      onError: (error) async {

          await _onError(context, error);

      }
    );

    return _map;
  }
// -----------------------------------------------------------------------------
}