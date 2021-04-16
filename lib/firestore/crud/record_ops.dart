import 'package:bldrs/firestore/auth/auth.dart';
import 'package:bldrs/firestore/firestore.dart';
import 'package:bldrs/models/records/call_model.dart';
import 'package:bldrs/models/records/follow_model.dart';
import 'package:bldrs/models/records/save_model.dart';
import 'package:bldrs/models/records/share_model.dart';
import 'package:flutter/material.dart';

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
    List<SaveModel> _userSavesModels = _userSavesMap == null ? null : SaveModel.decipherUserSavesMap(_userSavesMap);

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
    /// 1 - get User's SavesMap doc and decipher it into List<SaveModel>
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
  static Future<List<String>> readUserFollowsOps(BuildContext context) async {

    /// 1 - read db/users/userID/saves/bzz and return its map
    Map<String, dynamic> _userFollowsMap = await getFireStoreSubDocument(
      context: context,
      collectionName: FireCollection.users,
      docName: superUserID(),
      subCollectionName: FireCollection.subUserSaves,
      subDocName: FireCollection.bzz,
    );

    print('_userFollowsMap = $_userFollowsMap');

    /// 2- decipher the User's saves map into List<SaveModel>
    List<String> _userFollowedBzIDs = _userFollowsMap == null ? null : FollowModel.decipherUserFollowsMap(_userFollowsMap);

    return _userFollowsMap == null ? null : _userFollowedBzIDs;
  }

  static Future<FollowModel> readBzFollowOps(BuildContext context,String bzID, String userID) async {

    /// 1 - read db/bzz/bzID/follows/userID and return its map
    Map<String, dynamic> _userFollowMap = await getFireStoreSubDocument(
      context: context,
      collectionName: FireCollection.bzz,
      docName: bzID,
      subCollectionName: FireCollection.subBzFollows,
      subDocName: userID,
    );

    print('_userFollowMap = $_userFollowMap');

    /// 2- decipher the follo map into FollowModel
    FollowModel _follow = _userFollowMap == null ? null : FollowModel.decipherBzFollowMap(_userFollowMap);

    return _userFollowMap == null ? null : _follow;
  }
// ---------------------------------------------------------------------------
  static Future<List<String>> followBzOPs({BuildContext context,String bzID, String userID}) async {

    /// A - FollowOps in User/saves/bzz subDoc
    //-------------------------------------------
    /// 1 - get User's FollowsMap doc and decipher it into List<String> bzIDs
    List<String> _userFollowedBzzIDs = await readUserFollowsOps(context);

    /// 2 - update the list with the new save entry and get back the updated list
    List<String> _updatedFollowedBzzIDs = FollowModel.editFollows(_userFollowedBzzIDs, bzID);

    /// 3 - update sub doc with new SavesTopMap in db/flyers/flyerID/saves
    await insertFireStoreSubDocument(
      context: context,
      collectionName: FireCollection.users,
      docName: userID,
      subCollectionName: FireCollection.subUserSaves,
      subDocName: FireCollection.bzz,
      input: FollowModel.cipherUserFollows(_updatedFollowedBzzIDs),
    );

    /// B - FollowOps in bzz/follows/userID subDoc
    //-------------------------------------------
    /// 1 - get existing FollowModel
    FollowModel _existingFollowModel = await RecordCRUD.readBzFollowOps(context, bzID, userID);

    /// 2 - update the follow model
    FollowModel _updatedFollowModel = FollowModel.editFollowModel(_existingFollowModel);

    /// 3 - override bz follow sub document
    await insertFireStoreSubDocument(
      context: context,
      collectionName: FireCollection.bzz,
      docName: bzID,
      subCollectionName: FireCollection.subBzFollows,
      subDocName: userID,
      input: _updatedFollowModel.toMap(),
    );

    return _updatedFollowedBzzIDs;
  }
// ---------------------------------------------------------------------------
  static Future<CallModel> readCallModelOps({BuildContext context, String bzID, String userID}) async {

    /// 1 - read db/bzz/bzID/calls/userID and return its map
    Map<String, dynamic> _userCallMap = await getFireStoreSubDocument(
      context: context,
      collectionName: FireCollection.bzz,
      docName: bzID,
      subCollectionName: FireCollection.subBzCalls,
      subDocName: userID,
    );

    print('_userCallMap = $_userCallMap');

    /// 2- decipher the call map into FollowModel
    CallModel _callModel = _userCallMap == null ? null : CallModel.decipherCallMap(_userCallMap);

    return _userCallMap == null ? null : _callModel;
  }
// ---------------------------------------------------------------------------
  static Future<void> callBzOPs({BuildContext context,String bzID, String userID, int slideIndex}) async {

    /// A - CallOps in bzz/calls/userID subDoc
    //-------------------------------------------
    /// 1 - get the existing call model
    CallModel _existingCallModel = await RecordCRUD.readCallModelOps(
      context: context,
      bzID: bzID,
      userID: userID,
    );

    /// 2 - update the call model
    CallModel _updatedCallModel = CallModel.editCallModel(_existingCallModel, slideIndex);

    /// 3 - override bz Call sub document
    await insertFireStoreSubDocument(
      context: context,
      collectionName: FireCollection.bzz,
      docName: bzID,
      subCollectionName: FireCollection.subBzCalls,
      subDocName: userID,
      input: _updatedCallModel.toMap(),
    );

  }
// ---------------------------------------------------------------------------

}