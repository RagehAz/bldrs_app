import 'dart:async';
import 'dart:convert';

import 'package:bldrs/a_models/secondary_models/error_helpers.dart';
import 'package:bldrs/a_models/secondary_models/map_model.dart';
import 'package:bldrs/e_db/real/real_http.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:bldrs/f_helpers/drafters/mappers.dart' as Mapper;

class Real {

  Real();
// -----------------------------------------------------------------------------

  /// REF

// ----------------------------------------
  static DatabaseReference  _getRef(){
    return FirebaseDatabase.instance.ref();
  }
// ----------------------------------------
  /*
  static DatabaseReference  _getRefFromURL({
  @required String url,
}){
    return FirebaseDatabase.instance.refFromURL(url);
  }
   */
// ----------------------------------------
  static String _getPath({
    @required String collName,
    String docName,
    String key,
  }){

    String _path = collName;

    if (docName != null){

      _path = '$_path/$docName';

      if (key != null){
        _path = '$_path/$key';
      }

    }

    return _path;
  }
// ----------------------------------------
  static DatabaseReference _getRefByPath({
    @required String collName,
    String docName,
    String key,
  }){
    final String path = _getPath(
      collName: collName,
      docName: docName,
      key: key,
    );
    return FirebaseDatabase.instance.ref(path);
  }
// ----------------------------------------
  /*
  static FirebaseDatabase _getSecondaryFirebaseAppDB(String appName){
    final FirebaseApp _secondaryApp = Firebase.app(appName);
    final FirebaseDatabase _database = FirebaseDatabase.instanceFor(app: _secondaryApp);
    return _database;
  }
   */
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
  /// TESTED : WORKS PERFECT
  static Future<Map<String, dynamic>> createDoc({
    @required BuildContext context,
    @required String collName,
    @required Map<String, dynamic> map,
    @required bool addDocIDToOutput,
  }) async {

    Map<String, dynamic> _output;
    String _docID;

    await tryAndCatch(
      context: context,
      methodName: 'createDoc',
      functions: () async {

        /// GET PATH
        final _ref = _getRefByPath(
          collName: collName,
        );

        /// ADD EVENT LISTENER
          final StreamSubscription _sub = _ref.onChildAdded.listen((event){

            _docID = event.previousChildKey;

            _output = _redSnapshot(
              snapshot: event.snapshot,
              onNull: () => blog('Real.createNamedDoc : failed to create doc '),
            );

            if (addDocIDToOutput == true){
              _output = Mapper.insertPairInMap(
                map: _output,
                key: 'id',
                value: _docID,
              );
            }

          });

        /// CREATE
        await _ref.push().set(map);

        /// CANCEL EVENT LISTENER
        await _sub.cancel();

      },
    );

    if (_output != null){
      blog('Real.createDoc : map added to [REAL/$collName/$_docID] : map : $map');
    }

    return _output;
  }
// ----------------------------------------
  /// TESTED : WORKS PERFECT
  static Future<void> createNamedDoc({
    @required BuildContext context,
    @required String collName,
    @required String docName,
    @required Map<String, dynamic> map,
    bool pushNodeOneStepDeepWithUniqueID = false,
    bool isUpdating = false,
  }) async {

    DatabaseReference _ref = _getRefByPath(
      collName: collName,
      docName: docName,
    );

    if (pushNodeOneStepDeepWithUniqueID == true){
      _ref = _ref.push();
    }

    await tryAndCatch(
        context: context,
        methodName: 'createNamedDoc',

        functions: () async {

          await _ref.set(map);


          blog('Real.createNamedDoc : added to [REAL/$collName/$docName] : push is $pushNodeOneStepDeepWithUniqueID : map : $map');

        },

    );



  }
// -----------------------------------------------------------------------------

  /// READ

// ----------------------------------------
  /// TESTED : WORKS PERFECT
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

        final DataSnapshot snapshot = await ref.child(_path).get();

        _output = _redSnapshot(
          snapshot: snapshot,
          onNull: () => blog('Real.readDoc : No data available.'),

        );

      },
    );

    if (_output != null){
      blog('Real.readDoc : found map in (REAL/$collName/$docName) of ${_output.keys.length} keys');
    }

    return _output;
  }
// ----------------------------------------
  /// TESTED : WORKS PERFECT
  static Map<String, dynamic> _redSnapshot({
    @required DataSnapshot snapshot,
    Function onExists,
    Function onNull,
  }){

    Map<String, dynamic> _output;

    if (snapshot.exists) {
      _output = Map<String, dynamic>.from(snapshot.value);
      if (onExists != null){
        onExists();
      }
    }

    else {
      if (onNull != null){
        onNull();
      }
    }

    return _output;
  }
// ----------------------------------------
  /// TESTED : WORKS PERFECT
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
          _map = _redSnapshot(snapshot: event.snapshot);
        },
    );

    if (_map != null){
      blog('Real.readDocOnce : map added to [REAL/$collName/$docName] : map : $_map');
    }

    return _map;
  }
// ----------------------------------------
  static StreamSubscription streamDoc({
    @required String collName,
    @required String docName,
    @required ValueChanged<Map<String, dynamic>> onChanged,
  }){

    final DatabaseReference _ref = _getRefByPath(
        collName: collName,
        docName: docName,
    );

    final StreamSubscription _sub = _ref.onValue.listen((DatabaseEvent event) {
      final Map<String, dynamic> _data = event.snapshot.value;
      onChanged(_data);
    });

    return _sub;
  }
// -----------------------------------------------------------------------------

  /// UPDATE

// ----------------------------------------
  /// TESTED : WORKS PERFECT
  static Future<void> updateDoc({
    @required BuildContext context,
    @required String collName,
    @required String docName,
    @required Map<String, dynamic> map,
  }) async {

    if (map != null){

      await createNamedDoc(
        context: context,
        collName: collName,
        docName: docName,
        map: map,
        isUpdating: true,
      );

    }

  }
// ----------------------------------------
  /// TESTED : WORKS PERFECT
  static Future<void> updateDocField({
    @required BuildContext context,
    @required String collName,
    @required String docName,
    @required String fieldName,
    @required dynamic value,
  }) async {

    final DatabaseReference _ref = _getRefByPath(
      collName: collName,
      docName: docName,
      key: fieldName,
    );

    /// this is stupid shit
    // if (pushNodeOneStepWithNewUniqueID == true){
    //   _ref = _ref.push();
    // }

    await tryAndCatch(
        context: context,
        functions: () async {


          await _ref.set(value).then((_) {
            // Data saved successfully!
            blog('Real.updateField : updated (Real/$collName/$docName/$fieldName) : $value');

          })
              .catchError((error) {
            // The write failed...
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
  /// TESTED : WORKS PERFECT
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
// ----------------------------------------
  /// TESTED : WORKS PERFECT
  static Future<void> deleteField({
    @required BuildContext context,
    @required String collName,
    @required String docName,
    @required String fieldName,
  }) async {

    await updateDocField(
        context: context,
        collName: collName,
        docName: docName,
        fieldName: fieldName,
        value: null,
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
  static const String _realIncrementationLink = 'https://www.bldrs.net/counters?operation=';
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
