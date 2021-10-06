import 'package:bldrs/firestore/auth_ops.dart';
import 'package:bldrs/firestore/firestore.dart';
import 'package:bldrs/models/flyer/records/call_model.dart';
import 'package:bldrs/models/flyer/records/follow_model.dart';
import 'package:bldrs/models/flyer/records/save_model.dart';
import 'package:bldrs/models/flyer/records/share_model.dart';
import 'package:bldrs/providers/local_db/bldrs_local_dbs.dart';
import 'package:flutter/material.dart';

class RecordOps{
// -----------------------------------------------------------------------------
  static Future<List<SaveModel>> readUserSavesOps(BuildContext context) async {

    /// 1 - read db/users/userID/saves/flyers and return its map
    final Map<String, dynamic> _userSavesMap = await Fire.readSubDoc(
      context: context,
      collName: FireCollection.users,
      docName: superUserID(),
      subCollName: FireCollection.users_user_saves,
      subDocName: FireCollection.flyers,
    );

    /// 2- decipher the User's saves map into List<SaveModel>
    final List<SaveModel> _userSavesModels = _userSavesMap == null ? <SaveModel>[] : SaveModel.decipherUserSavesMap(_userSavesMap);

    return _userSavesMap == null ? <SaveModel>[] : _userSavesModels;
  }
// -----------------------------------------------------------------------------
  static Future<List<SaveModel>> readFlyerSavesOps() async {
    /// TASK : paginate in Flyer saves to get batches of tiny users after getting those savesModels
    final List<SaveModel> _flyerSaves = <SaveModel>[];
    return _flyerSaves;
  }
// -----------------------------------------------------------------------------
/// this method works if flyer is saved previously or not, if it's first time to save or not
  static Future<void> saveFlyerOps({BuildContext context, String flyerID, int slideIndex, String userID}) async {

    /// A - SavesOps in User/saves/flyers subDoc
    //-------------------------------------------
    /// 1 - get User's SavesMap doc and decipher it into List<SaveModel>
    final List<SaveModel> _userSavesModels = await readUserSavesOps(context);

    /// 2 - update the list with the new save entry and get back the updated list
    final List<SaveModel> _updatedUserSavesModel = SaveModel.editSavesModels(_userSavesModels, flyerID, slideIndex);

    final Map<String, Object> _savesMaps = await SaveModel.cipherSavesModelsToUser(_updatedUserSavesModel);

    await BLDBMethod.insert(
      bldb: BLDB.mySaves,
      inputs: [_savesMaps],
    );

    /// 3 - update sub doc with new SavesTopMap in db/flyers/flyerID/saves
    await Fire.createNamedSubDoc(
      context: context,
      collName: FireCollection.users,
      docName: userID,
      subCollName: FireCollection.users_user_saves,
      subDocName: FireCollection.flyers,
      input: _savesMaps,
    );

    /// B - SavesOps in flyers/saves/users subDoc
    //-------------------------------------------
    /// 1 - get the updated saveModel from the updated list of SaveModels
    final SaveModel _flyerSaveModel = _updatedUserSavesModel.singleWhere((save) => save.flyerID == flyerID);

    /// 2 - override flyer save sub document
    await Fire.createNamedSubDoc(
      context: context,
      collName: FireCollection.flyers,
      docName: flyerID,
      subCollName: FireCollection.flyers_flyer_saves,
      subDocName: userID,
      input: _flyerSaveModel.toFlyerSaveMap(),
    );

  }
// -----------------------------------------------------------------------------
  static Future<ShareModel> readFlyerShareOps({BuildContext context, String flyerID, String userID}) async {

    final Map<String, dynamic> _userShareMap = await Fire.readSubDoc(
      context: context,
      collName: FireCollection.flyers,
      docName: flyerID,
      subCollName: FireCollection.flyers_flyer_shares,
      subDocName: userID,
    );

    final ShareModel _shareModel = _userShareMap == null ? null : ShareModel.decipherShareMap(_userShareMap);

    return _userShareMap == null ? null : _shareModel;
  }
// -----------------------------------------------------------------------------
  static Future<void> shareFlyerOPs({BuildContext context, String flyerID, int slideIndex, String userID}) async {

    /// get existing share model if existed
    final ShareModel _existingShareModel = await readFlyerShareOps(
      context: context,
      flyerID: flyerID,
      userID: userID,
    );

    /// update shareModel if existed, otherWise create a new one
    final ShareModel _updatedShareModel = ShareModel.addToShareModel(_existingShareModel, slideIndex);

    /// add new share model into dc/flyers/flyerID/shares/userID
    await Fire.createNamedSubDoc(
      context: context,
      collName: FireCollection.flyers,
      docName: flyerID,
      subCollName: FireCollection.flyers_flyer_shares,
      subDocName: userID,
      input: _updatedShareModel.toMap(),
    );

  }
// -----------------------------------------------------------------------------
  static Future<void> viewFlyerOPs(String flyerID, String userID) async {}
// -----------------------------------------------------------------------------
  static Future<List<String>> readUserFollowsOps(BuildContext context) async {

    /// 1 - read db/users/userID/saves/bzz and return its map
    final Map<String, dynamic> _userFollowsMap = await Fire.readSubDoc(
      context: context,
      collName: FireCollection.users,
      docName: superUserID(),
      subCollName: FireCollection.users_user_saves,
      subDocName: FireCollection.bzz,
    );

    print('_userFollowsMap = $_userFollowsMap');

    /// 2- decipher the User's saves map into List<SaveModel>
    final List<String> _userFollowedBzIDs = _userFollowsMap == null ? null : FollowModel.decipherUserFollowsMap(_userFollowsMap);

    return _userFollowsMap == null ? null : _userFollowedBzIDs;
  }

  static Future<FollowModel> readBzFollowOps(BuildContext context,String bzID, String userID) async {

    /// 1 - read db/bzz/bzID/follows/userID and return its map
    final Map<String, dynamic> _userFollowMap = await Fire.readSubDoc(
      context: context,
      collName: FireCollection.bzz,
      docName: bzID,
      subCollName: FireCollection.bzz_bz_follows,
      subDocName: userID,
    );

    print('_userFollowMap = $_userFollowMap');

    /// 2- decipher the follo map into FollowModel
    final FollowModel _follow = _userFollowMap == null ? null : FollowModel.decipherBzFollowMap(_userFollowMap);

    return _userFollowMap == null ? null : _follow;
  }
// -----------------------------------------------------------------------------
  static Future<List<String>> followBzOPs({BuildContext context,String bzID, String userID}) async {

    /// A - FollowOps in User/saves/bzz subDoc
    //-------------------------------------------
    /// 1 - get User's FollowsMap doc and decipher it into List<String> bzIDs
    final List<String> _userFollowedBzzIDs = await readUserFollowsOps(context);

    /// 2 - update the list with the new save entry and get back the updated list
    final List<String> _updatedFollowedBzzIDs = FollowModel.editFollows(_userFollowedBzzIDs, bzID);

    /// 3 - update sub doc with new SavesTopMap in db/flyers/flyerID/saves
    await Fire.createNamedSubDoc(
      context: context,
      collName: FireCollection.users,
      docName: userID,
      subCollName: FireCollection.users_user_saves,
      subDocName: FireCollection.bzz,
      input: FollowModel.cipherUserFollows(_updatedFollowedBzzIDs),
    );

    /// B - FollowOps in bzz/follows/userID subDoc
    //-------------------------------------------
    /// 1 - get existing FollowModel
    final FollowModel _existingFollowModel = await RecordOps.readBzFollowOps(context, bzID, userID);

    /// 2 - update the follow model
    final FollowModel _updatedFollowModel = FollowModel.editFollowModel(_existingFollowModel);

    /// 3 - override bz follow sub document
    await Fire.createNamedSubDoc(
      context: context,
      collName: FireCollection.bzz,
      docName: bzID,
      subCollName: FireCollection.bzz_bz_follows,
      subDocName: userID,
      input: _updatedFollowModel.toMap(),
    );

    return _updatedFollowedBzzIDs;
  }
// -----------------------------------------------------------------------------
  static Future<CallModel> readCallModelOps({BuildContext context, String bzID, String userID}) async {

    /// 1 - read db/bzz/bzID/calls/userID and return its map
    final Map<String, dynamic> _userCallMap = await Fire.readSubDoc(
      context: context,
      collName: FireCollection.bzz,
      docName: bzID,
      subCollName: FireCollection.bzz_bz_calls,
      subDocName: userID,
    );

    print('_userCallMap = $_userCallMap');

    /// 2- decipher the call map into FollowModel
    final CallModel _callModel = _userCallMap == null ? null : CallModel.decipherCallMap(_userCallMap);

    return _userCallMap == null ? null : _callModel;
  }
// -----------------------------------------------------------------------------
  static Future<void> callBzOPs({BuildContext context,String bzID, String userID, int slideIndex}) async {

    /// A - CallOps in bzz/calls/userID subDoc
    //-------------------------------------------
    /// 1 - get the existing call model
    final CallModel _existingCallModel = await RecordOps.readCallModelOps(
      context: context,
      bzID: bzID,
      userID: userID,
    );

    /// 2 - update the call model
    final CallModel _updatedCallModel = CallModel.editCallModel(_existingCallModel, slideIndex);

    /// 3 - override bz Call sub document
    await Fire.createNamedSubDoc(
      context: context,
      collName: FireCollection.bzz,
      docName: bzID,
      subCollName: FireCollection.bzz_bz_calls,
      subDocName: userID,
      input: _updatedCallModel.toMap(),
    );

  }
// -----------------------------------------------------------------------------

}