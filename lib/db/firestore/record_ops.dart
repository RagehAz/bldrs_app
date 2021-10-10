import 'package:bldrs/db/firestore/firestore.dart';
import 'package:bldrs/models/flyer/records/customer_journey.dart';
import 'package:flutter/material.dart';

/// WHAT HAPPENS AROUND FOLLOW EVENT
/// 1 - app starts
///   x - follows are already saved in local db, if empty checks firebase and updates
///   x- followedIDs are saved on firebase/users/userID/records/bzz
///   x- followsIDs are saved locally in myFollowedBzz inside bzzModels
/// 2- app reads local follows
/// 3- on new follow event :-
///   a - update bzID in local db
///   b - update firebase with the new list
///   c - insert record in firebase/records/activities/follows/{recordID}
///   d - update provider with the new list
///   e - notify listeners


abstract class RecordOps{

  static Future<void> createRecord({BuildContext context, Record record}) async {

  }

  static Future<List<String>> readUserFollows({BuildContext context, String userID, }) async {

    Map<String, dynamic> _followsMap = await Fire.readSubDoc(
      context: context,
      collName: FireCollection.users,
      docName: userID,
      subCollName: FireCollection.users_user_records,
      subDocName: FireCollection.users_user_records_bzz,
    );
  }

  static Future<List<Record>> readBzFollowers({BuildContext context, String bzID}) async {

  }

}