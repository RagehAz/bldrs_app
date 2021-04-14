import 'package:bldrs/controllers/drafters/timerz.dart';
import 'package:bldrs/firestore/auth/auth.dart';
import 'package:bldrs/firestore/firestore.dart';
import 'package:bldrs/models/flyer_model.dart';
import 'package:bldrs/models/records/save_model.dart';
import 'package:bldrs/models/records/share_model.dart';
import 'package:bldrs/providers/flyers_provider.dart';
import 'package:bldrs/providers/users_provider.dart';
import 'package:flutter/material.dart';
import 'flyer_ops.dart';

class RecordCRUD{
// ---------------------------------------------------------------------------
  static Future<List<SaveModel>> readUserSavesOps(BuildContext context) async {

    /// 1 - read db/users/userID/saves/flyers and return its map
    Map<String, dynamic> _userSavesMap = await getFireStoreSubDocument(
      context: context,
      collectionName: FireCollection.users,
      docName: superUserID(),
      subCollectionName: FireCollection.subUserSaves,
      subDocName: FireCollection.flyers,
    );

    /// 2- decipher the User's saves map into List<SaveModel>
    List<SaveModel> _userSavesModels = SaveModel.decipherUserSavesMap(_userSavesMap);

    return _userSavesMap == null ? null : _userSavesModels;
  }
// ---------------------------------------------------------------------------
  static Future<List<SaveModel>> readFlyerSavesOps() async {
    /// TASK : paginate in Flyer saves to get batches of tiny users after getting those savesModels
    List<SaveModel> _flyerSaves = new List();
    return _flyerSaves;
  }
// ---------------------------------------------------------------------------
/// this method works if flyer is saved previously or not, if it's first time to save or not
  static Future<void> saveFlyerOps({BuildContext context, String flyerID, int slideIndex, String userID}) async {

    /// A - SavesOps in User/saves/flyers subDoc
    //-------------------------------------------
    /// 1 - get Flyer's SavesMap doc and decipher it into List<SaveModel>
    List<SaveModel> _userSavesModels = await readUserSavesOps(context);

    /// 2 - update the list with the new save entry and get back the updated list
    List<SaveModel> _updatedUserSavesModel = SaveModel.editSavesModels(_userSavesModels, flyerID, slideIndex);

    /// 3 - update sub doc with new SavesTopMap in db/flyers/flyerID/saves
    await insertFireStoreSubDocument(
      context: context,
      collectionName: FireCollection.users,
      docName: userID,
      subCollectionName: FireCollection.subUserSaves,
      subDocName: FireCollection.flyers,
      input: await SaveModel.cipherSavesModelsToUser(_updatedUserSavesModel),
    );

    /// B - SavesOps in flyers/saves/users subDoc
    //-------------------------------------------
    /// 1 - get the updated saveModel from the updated list of SaveModels
    SaveModel _flyerSaveModel = _updatedUserSavesModel.singleWhere((save) => save.flyerID == flyerID);

    /// 2 - override flyer save sub document
    await insertFireStoreSubDocument(
      context: context,
      collectionName: FireCollection.flyers,
      docName: flyerID,
      subCollectionName: FireCollection.subFlyerSaves,
      subDocName: userID,
      input: _flyerSaveModel.toFlyerSaveMap(),
    );

  }
// ---------------------------------------------------------------------------
  static Future<ShareModel> readFlyerShareOps({BuildContext context, String flyerID, String userID}) async {

    Map<String, dynamic> _userShareMap = await getFireStoreSubDocument(
      context: context,
      collectionName: FireCollection.flyers,
      docName: flyerID,
      subCollectionName: FireCollection.subFlyerShares,
      subDocName: userID,
    );

    ShareModel _shareModel = _userShareMap == null ? null : ShareModel.decipherShareMap(_userShareMap);

    return _userShareMap == null ? null : _shareModel;
  }
// ---------------------------------------------------------------------------
  static Future<void> shareFlyerOPs({BuildContext context, String flyerID, int slideIndex, String userID}) async {

    /// get existing share model if existed
    ShareModel _existingShareModel = await readFlyerShareOps(
      context: context,
      flyerID: flyerID,
      userID: userID,
    );

    /// update shareModel if existed, otherWise create a new one
    ShareModel _updatedShareModel = ShareModel.addToShareModel(_existingShareModel, slideIndex);

    /// add new share model into dc/flyers/flyerID/shares/userID
    await insertFireStoreSubDocument(
      context: context,
      collectionName: FireCollection.flyers,
      docName: flyerID,
      subCollectionName: FireCollection.subFlyerShares,
      subDocName: userID,
      input: _updatedShareModel.toMap(),
    );

  }
// ---------------------------------------------------------------------------
  static Future<void> viewFlyerOPs(String flyerID, String userID) async {}
// ---------------------------------------------------------------------------
  static Future<void> followBzOPs(String flyerID, String userID) async {}
// ---------------------------------------------------------------------------
  static Future<void> callBzOPs(String flyerID, String userID) async {}
// ---------------------------------------------------------------------------
}