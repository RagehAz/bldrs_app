import 'dart:convert';

import 'package:bldrs/a_models/secondary_models/error_helpers.dart';
import 'package:bldrs/e_db/real/real_http.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Real {

  Real();
// -----------------------------------------------------------------------------

  /// REF

// ----------------------------------------
  static DatabaseReference  _getRef(){
    return FirebaseDatabase.instance.ref();
  }
// ----------------------------------------
  static DatabaseReference  _getRefFromURL({
  @required String url,
}){
    return FirebaseDatabase.instance.refFromURL(url);
  }
// ----------------------------------------
  static String _getPath({
    @required String collName,
    @required String docName,
  }){
    return '$collName/$docName';
  }
// ----------------------------------------
  static DatabaseReference _getRefByPath({
    @required String collName,
    @required String docName,
  }){
    final String path = _getPath(
      collName: collName,
      docName: docName,
    );
    return FirebaseDatabase.instance.ref(path);
  }
// ----------------------------------------
  static FirebaseDatabase _getSecondaryFirebaseAppDB(String appName){
    final FirebaseApp _secondaryApp = Firebase.app(appName);
    final FirebaseDatabase _database = FirebaseDatabase.instanceFor(app: _secondaryApp);
    return _database;
  }
// -----------------------------------------------------------------------------

  /// CREATE

// ----------------------------------------
  /*
  static Future<String> createDoc({
    @required String docName,
    @required Map<String, dynamic> map,
  }) async {

    final DatabaseReference _ref = _getRef();

    await _ref.

  }
   */
// ----------------------------------------
  static Future<void> createNamedDoc({
    @required BuildContext context,
    @required String collName,
    @required String docName,
    @required Map<String, dynamic> map,
    bool push,
  }) async {

    DatabaseReference _ref = _getRefByPath(
      collName: collName,
      docName: docName,
    );

    if (push == true){
      _ref = _ref.push();
    }

    await tryAndCatch(
        context: context,
        functions: () async {

          await _ref.set(map);

        }
    );



  }
// -----------------------------------------------------------------------------

  /// READ

// ----------------------------------------
  static Future<Map<String, dynamic>> readDoc({
    @required BuildContext context,
    @required String collName,
    @required String docName,
  }) async {

    Map<String, dynamic> _output;

    final DatabaseReference ref = _getRef();

    final String _path = _getPath(
      collName: collName,
      docName: docName,
    );

    await tryAndCatch(
      context: context,
      functions: () async {

        final snapshot = await ref.child(_path).get();

        if (snapshot.exists) {
          _output = snapshot.value;
        }

        else {
          blog('No data available.');
        }

      },
    );

    return _output;
  }
// ----------------------------------------
  static Future<Map<String, dynamic>> readDocOnce({
    @required BuildContext context,
    @required String collName,
    @required String docName,
  }) async {

    final DatabaseReference ref = _getRefByPath(
        collName: collName,
        docName: docName,
    );

    Map<String, dynamic> _map;

    await tryAndCatch(
        context: context,
        functions: () async {

          final event = await ref.once(DatabaseEventType.value);
          _map = event.snapshot.value;
        },
    );


    return _map;
  }
// ----------------------------------------
  static void streamDoc({
    @required String collName,
    @required String docName,
    @required ValueChanged<Map<String, dynamic>> onChanged,
  }){

    final DatabaseReference _ref = _getRefByPath(
        collName: collName,
        docName: docName,
    );

    _ref.onValue.listen((DatabaseEvent event) {
      final Map<String, dynamic> _data = event.snapshot.value;
      onChanged(_data);
    });

  }
// -----------------------------------------------------------------------------

  /// UPDATE

// ----------------------------------------
  static Future<void> updateDoc({
    @required BuildContext context,
    @required String collName,
    @required String docName,
    @required Map<String, dynamic> map,
    bool push,
  }) async {

    if (map != null){

      await createNamedDoc(
        context: context,
        collName: collName,
        docName: docName,
        map: map,
        push: push,
      );

    }

  }
// ----------------------------------------
  static Future<void> updateDocField({
    @required BuildContext context,
    @required String collName,
    @required String docName,
    @required String fieldName,
    @required dynamic value,
    bool push = true,
  }) async {

    DatabaseReference _ref = _getRefByPath(
      collName: collName,
      docName: docName,
    );

    if (push == true){
      _ref = _ref.push();
    }

    await tryAndCatch(
        context: context,
        functions: () async {

          await _ref.update({
            fieldName: value, // so this can take multiple pairs instead of only one
          });

        }
    );



  }
// ----------------------------------------
  /*
  static Future<void> updateMultipleDocsAtOnce({
    @required List<RealNode> nodes,

  }) async {

    // Get a key for a new Post.
    final newPostKey = FirebaseDatabase.instance.ref().child('posts').push().key;

    final Map<String, Map> updates = {};
    updates['/posts/$newPostKey'] = postData;
    updates['/user-posts/$uid/$newPostKey'] = postData;

    return FirebaseDatabase.instance.ref().update(updates);
  }
   */
// -----------------------------------------------------------------------------

  /// DELETE

// ----------------------------------------
  static Future<void> deleteDoc({
    @required BuildContext context,
    @required String collName,
    @required String docName,
  }) async {

    final DatabaseReference _ref = _getRefByPath(
      collName: collName,
      docName: docName,
    );

    await tryAndCatch(
        context: context,
        functions: () async {

          await _ref.remove();

        },
    );

  }
// -----------------------------------------------------------------------------

  /// TRANSACTION & ATOMICS & LISTENERS

// ----------------------------------------
  static Future<TransactionResult> runTransaction ({
    @required BuildContext context,
    @required String collName,
    @required String docName,
    @required Function(Map<String, dynamic> map) doStuff,
    @required bool applyLocally,
  }) async {

    final DatabaseReference _ref = _getRefByPath(
        collName: collName,
        docName: docName
    );

    final TransactionResult _result = await _ref.runTransaction((Object map){

      // Ensure a map at the ref exists.
      if (map == null) {
        return Transaction.abort();
      }

      else {

        final Map<String, dynamic> _map = Map<String, dynamic>.from(map as Map);

        doStuff(_map);

        return Transaction.success(_map);
      }

    },
    applyLocally: applyLocally,
    );

    blog('runTransaction : _result.committed : ${_result.committed} : _result.snapshot : ${_result.snapshot}');

    return _result;
  }
// ----------------------------------------
/*
  void addStar(uid, key) async {
    Map<String, Object?> updates = {};
    updates["posts/$key/stars/$uid"] = true;
    updates["posts/$key/starCount"] = ServerValue.increment(1);
    updates["user-posts/$key/stars/$uid"] = true;
    updates["user-posts/$key/starCount"] = ServerValue.increment(1);
    return FirebaseDatabase.instance.ref().update(updates);
  }
 */
// ----------------------------------------
/*
    /// Listen for child events

  final commentsRef = FirebaseDatabase.instance.ref("post-comments/$postId");
  commentsRef.onChildAdded.listen((event) {
      // A new comment has been added, so add it to the displayed list.
  });
  commentsRef.onChildChanged.listen((event) {
      // A comment has changed; use the key to determine if we are displaying this
      // comment and if so displayed the changed comment.
  });
  commentsRef.onChildRemoved.listen((event) {
      // A comment has been removed; use the key to determine if we are displaying
      // this comment and if so remove it.
  });
 */
// ----------------------------------------
/*
    /// Listen for value events

        myTopPostsQuery.onValue.listen((event) {
        for (final child in event.snapshot.children) {
          // Handle the post.
        }
      }, onError: (error) {
        // Error.
      });

 */
// -----------------------------------------------------------------------------

  /// CLOUD FUNCTIONS

// ----------------------------------------
  /// TESTED : WORKS PERFECT
  static const String _realIncrementationLink = 'https://www.bldrs.net/counters?operation=';//'https://www.bldrs.net/counters';
// -----------------------------------------------------------------------------
  static Future<void> incrementDocField({
    @required BuildContext context,
    @required String docID,
    @required String fieldName,
    @required String collName,
    @required bool increment,
  }) async {

    String _docID;

    await tryAndCatch(
        context: context,
        functions: () async {

          final String _action = increment == true ? 'increment' : 'decrement';

          /// post map to realtime database
          final http.Response _response = await http.post(
            Uri.parse('$_realIncrementationLink$_action'),
            body: {
              'collName' : collName,
              'id' : docID,
              'field' : fieldName,
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

          await RealHttp.onHttpError(
              context: context,
              error: error,
          );

        }

    );

    return _docID;


  }
// -----------------------------------------------------------------------------

}
