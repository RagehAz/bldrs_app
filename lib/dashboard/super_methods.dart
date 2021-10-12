import 'package:bldrs/db/firestore/firestore.dart';
import 'package:bldrs/models/bz/bz_model.dart';
import 'package:bldrs/models/flyer/flyer_model.dart';
import 'package:bldrs/models/flyer/tiny_flyer.dart';
import 'package:bldrs/models/notification/noti_model.dart';
import 'package:bldrs/models/secondary_models/feedback_model.dart';
import 'package:bldrs/models/user/user_model.dart';
import 'package:flutter/material.dart';

class SuperBldrsMethod{
// -----------------------------------------------------------------------------
  static Future<List<UserModel>> readAllUserModels({int limit}) async {

    final List<dynamic> _maps = await Fire.readCollectionDocs(
      limit: limit ?? 100,
      collectionName: FireCollection.users,
      addDocSnapshotToEachMap: false,
      orderBy: 'userID',
    );

    final List<UserModel> _allModels = UserModel.decipherUsersMaps(
      maps: _maps,
      fromJSON: false,
    );

    return _allModels;
  }
// -----------------------------------------------------------------------------
  static Future<List<NotiModel>> readAllNotiModels({BuildContext context, String userID,}) async {

    final List<dynamic> _maps = await Fire.readSubCollectionDocs(
      context: context,
      collName: FireCollection.users,
      docName: userID,
      subCollName: FireCollection.users_user_notifications,
    );

    final List<NotiModel> _allModels = NotiModel.decipherNotiModels(
      maps: _maps,
      fromJSON: false,
    );

    return _allModels;
  }
// -----------------------------------------------------------------------------
  static Future<List<BzModel>> readAllBzzModels({BuildContext context, int limit,}) async {

    final List<dynamic> _maps = await Fire.readCollectionDocs(
      limit: limit ?? 100,
      collectionName: FireCollection.bzz,
      addDocSnapshotToEachMap: false,
      orderBy: 'bzID',
    );

    final List<BzModel> _allModels = BzModel.decipherBzzMapsFromFireStore(
      maps: _maps,
      fromJSON: false,
    );

    return _allModels;
  }
// -----------------------------------------------------------------------------
  static Future<List<FeedbackModel>> readAllFeedbacks({BuildContext context, int limit,}) async {

    final List<dynamic> _maps = await Fire.readCollectionDocs(
      limit: limit ?? 100,
      collectionName: FireCollection.feedbacks,
      addDocSnapshotToEachMap: false,
      addDocID: true,
      orderBy: 'timeStamp',
    );

    final List<FeedbackModel> _allModels = FeedbackModel.decipherFeedbacks(_maps);

    return _allModels;
  }
// -----------------------------------------------------------------------------
  static Future<List<FlyerModel>> readAllFlyers({BuildContext context, int limit,}) async {

    final List<dynamic> _maps = await Fire.readCollectionDocs(
      limit: limit ?? 100,
      collectionName: FireCollection.flyers,
      addDocSnapshotToEachMap: false,
      addDocID: false,
      orderBy: 'flyerID',
    );

    final List<FlyerModel> _allModels = FlyerModel.decipherFlyers(maps: _maps, fromJSON: false);

    return _allModels;
  }
// -----------------------------------------------------------------------------
  static Future<List<TinyFlyer>> readAllTinyFlyers({BuildContext context, int limit,}) async {

    final List<dynamic> _maps = await Fire.readCollectionDocs(
      limit: limit ?? 100,
      collectionName: FireCollection.tinyFlyers,
      addDocSnapshotToEachMap: false,
      addDocID: false,
      orderBy: 'flyerID',
    );

    final List<TinyFlyer> _allModels = TinyFlyer.decipherTinyFlyersMaps(_maps);

    return _allModels;
  }
// -----------------------------------------------------------------------------
}