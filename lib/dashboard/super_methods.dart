import 'package:bldrs/firestore/firestore.dart';
import 'package:bldrs/models/notification/noti_model.dart';
import 'package:bldrs/models/user/user_model.dart';
import 'package:flutter/material.dart';

class SuperBldrsMethod{
// -----------------------------------------------------------------------------
  static Future<List<UserModel>> readAllUserModels({int limit}) async {

    List<dynamic> _maps = await Fire.readCollectionDocs(
      limit: limit ?? 100,
      collectionName: FireCollection.users,
      addDocSnapshotToEachMap: false,
      orderBy: 'userID',
    );

    List<UserModel> _allUsers = UserModel.decipherUsersMaps(_maps);

    return _allUsers;
  }
// -----------------------------------------------------------------------------
  static Future<List<NotiModel>> readAllNotiModels({BuildContext context, String userID,}) async {

    List<dynamic> _maps = await Fire.readSubCollectionDocs(
      context: context,
      collName: FireCollection.users,
      docName: userID,
      subCollName: FireCollection.subUserNotifications,
    );

    List<NotiModel> _notiModels = NotiModel.decipherNotiModels(_maps);

    return _notiModels;
  }
// -----------------------------------------------------------------------------
}