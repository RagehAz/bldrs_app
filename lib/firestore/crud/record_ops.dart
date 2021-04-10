import 'package:bldrs/controllers/drafters/timerz.dart';
import 'package:bldrs/firestore/auth/auth.dart';
import 'package:bldrs/firestore/firestore.dart';
import 'package:bldrs/models/records/save_model.dart';
import 'package:bldrs/providers/users_provider.dart';
import 'package:flutter/material.dart';

class RecordCRUD{
// ---------------------------------------------------------------------------
/// this method works if flyer is saved previously or not, if it's first time to save or not
  static Future<void> saveFlyerOPs({BuildContext context, String flyerID, int slideIndex, String userID}) async {

    /// get user's SavesMap doc and decipher it into List<SaveModel>
    dynamic _userSavesTopMap = await UserProvider(userID: userID).getSavedFlyers(context);
    List<SaveModel> _userSavesModels = SaveModel.decipherSavesTopMap(_userSavesTopMap);

    /// update the list with the new save entry and get back the updated list
    List<SaveModel> _updatedSavesModel = SaveModel.editSavesModels(_userSavesModels, flyerID, slideIndex);

    /// update sub doc with new SavesTopMap
    await insertFireStoreSubDocument(
      context: context,
      collectionName: FireStoreCollection.users,
      docName: userID,
      subCollectionName: FireStoreCollection.subUserSaves,
      subDocName: FireStoreCollection.flyers,
      input: await SaveModel.cipherSavesModels(_updatedSavesModel),
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