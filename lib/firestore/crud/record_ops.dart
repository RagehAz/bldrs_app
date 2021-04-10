import 'package:bldrs/controllers/drafters/timerz.dart';
import 'package:bldrs/firestore/auth/auth.dart';
import 'package:bldrs/firestore/firestore.dart';
import 'package:bldrs/models/records/save_model.dart';
import 'package:bldrs/providers/users_provider.dart';
import 'package:flutter/material.dart';

class RecordCRUD{
// ---------------------------------------------------------------------------
  static Future<void> saveFlyerOPs({BuildContext context, SaveModel saveModel, String userID}) async {

    /// get user's saved Flyers Map
    Map<String, dynamic> _savedFlyersMap = await UserProvider(userID: userID).getSavedFlyers(context);


    _savedFlyersMap.addAll({
      saveModel.flyerID : {
        'slideIndex' : saveModel.slideIndexes,
        'saveState' : SaveModel.cipherSaveState(saveModel.saveState),
        'timeStamps' : cipherListOfDateTimes(saveModel.timeStamps),
      }
    });


    /// save flyer ID in db/userID/flyers document
    await insertFireStoreSubDocument(
      context: context,
      collectionName: FireStoreCollection.users,
      docName: userID,
      subCollectionName: FireStoreCollection.subUserSaves,
      subDocName: FireStoreCollection.flyers,
      input: _savedFlyersMap,
    );

    /// save user ID in dc/flyerID/saves document

  }
// ---------------------------------------------------------------------------
  static Future<void> unSaveFlyerOPs(String flyerID, String userID) async {


    /// delete flyer ID document in db/userID/saves



    /// delete user ID document in dc/flyerID/saves

  }
// ---------------------------------------------------------------------------
  static Future<void> shareFlyerOPs(String flyerID, String userID) async {}
// ---------------------------------------------------------------------------
  static Future<void> viewFlyerOPs(String flyerID, String userID) async {}
// ---------------------------------------------------------------------------
  static Future<void> followBzOPs(String flyerID, String userID) async {}
// ---------------------------------------------------------------------------
  static Future<void> callBzOPs(String flyerID, String userID) async {}
// ---------------------------------------------------------------------------
}