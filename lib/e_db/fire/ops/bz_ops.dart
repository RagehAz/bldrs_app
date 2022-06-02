import 'dart:io';

import 'package:bldrs/a_models/bz/author_model.dart';
import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/a_models/secondary_models/error_helpers.dart';
import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/d_providers/user_provider.dart';
import 'package:bldrs/e_db/fire/foundation/firestore.dart' as Fire;
import 'package:bldrs/e_db/fire/foundation/paths.dart';
import 'package:bldrs/e_db/fire/foundation/storage.dart' as Storage;
import 'package:bldrs/e_db/fire/ops/auth_ops.dart' as AuthFireOps;
import 'package:bldrs/e_db/fire/ops/flyer_ops.dart' as FlyerFireOps;
import 'package:bldrs/e_db/fire/ops/user_ops.dart' as UserFireOps;
import 'package:bldrs/f_helpers/drafters/mappers.dart' as Mapper;
import 'package:bldrs/f_helpers/drafters/object_checkers.dart' as ObjectChecker;
import 'package:bldrs/f_helpers/drafters/text_mod.dart' as TextMod;
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// --------------------------

/// CREATE

// --------------------------
Future<BzModel> createBz({
  @required BuildContext context,
  @required BzModel draftBz,
  @required UserModel userModel,
}) async {

  blog('createBz : START');

  BzModel _output;
  bool _result;

  _result = await tryCatchAndReturnBool(
      context: context,
      methodName: 'createBz',
      functions: () async {

        final String _bzID = await _createEmptyBzDocToGetBzID(
          context: context,
        );

        final String _bzLogoURL = await _uploadBzLogoAndGetURL(
          context: context,
          logo: draftBz.logo,
          bzID: _bzID,
          ownerID: userModel.id,
        );

        /// update authorModel with _authorPicURL
        final AuthorModel _masterAuthor = await _uploadAuthorPicAndReturnMasterAuthor(
          context: context,
          draftBz: draftBz,
          userModel: userModel,
          bzID: _bzID,
        );

        await _addBzIDToUserBzzIDs(
          context: context,
          userModel: userModel,
          bzID: _bzID,
        );

        final BzModel _finalBzModel = draftBz.copyWith(
          id: _bzID,
          createdAt: DateTime.now(),
          logo: _bzLogoURL,
          authors: <AuthorModel>[_masterAuthor],
        );

        await _updateBzDoc(
          context: context,
          finalBzModel: _finalBzModel,
        );

        _output = _finalBzModel;

      },
      onError: (String error){
        blog('the create bz error is : $error');
        _result = false;
      }
  );

  blog('createBz : END');

  return _result == true ? _output : null;
}
// --------------------------
Future<String> _createEmptyBzDocToGetBzID({
  @required BuildContext context,
}) async {

  blog('_createEmptyBzDocToGetBzID : START');

  final DocumentReference<Object> _docRef = await Fire.createDoc(
    context: context,
    collName: FireColl.bzz,
    addDocID: true,
    input: <String, dynamic>{},
  );

  blog('_createEmptyBzDocToGetBzID : END');

  return _docRef?.id;
}
// --------------------------
Future<String> _uploadBzLogoAndGetURL({
  @required BuildContext context,
  @required dynamic logo,
  @required String bzID,
  @required String ownerID,
}) async {

  blog('_uploadBzLogoAndGetURL : START');

  String _bzLogoURL;

  if (logo != null && ObjectChecker.objectIsFile(logo) == true) {

    _bzLogoURL = await Storage.createStoragePicAndGetURL(
      context: context,
      inputFile: logo,
      picName: bzID,
      docName: StorageDoc.logos,
      ownerID: ownerID,
    );

  }

  else if (ObjectChecker.objectIsURL(logo) == true){
    _bzLogoURL = logo;
    blog('_bzLogoURL : used old logo : $_bzLogoURL');
  }

  blog('_uploadBzLogoAndGetURL : END');

  return _bzLogoURL;
}
// --------------------------
Future<AuthorModel> _uploadAuthorPicAndReturnMasterAuthor({
  @required BuildContext context,
  @required BzModel draftBz,
  @required UserModel userModel,
  @required String bzID,
}) async {

  blog('_uploadAuthorPicAndReturnMasterAuthor : START');

  /// upload authorPic
  String _authorPicURL;

  if (
  draftBz.authors[0].pic == null
  ||
  ObjectChecker.objectIsURL(draftBz.authors[0].pic) == true
  ) {
    _authorPicURL = userModel.pic;
  }

  else {

    _authorPicURL = await Storage.createStoragePicAndGetURL(
      context: context,
      inputFile: draftBz.authors[0].pic,
      docName: StorageDoc.authors,
      ownerID: userModel.id,
      picName: AuthorModel.generateAuthorPicID(
          authorID: userModel.id,
          bzID: bzID,
      ),
    );

  }


  final AuthorModel _masterAuthor = AuthorModel(
    userID: userModel.id,
    name: userModel.name,
    title: userModel.title,
    pic: _authorPicURL,
    isMaster: true,
    contacts: userModel.contacts,
  );

  blog('_uploadAuthorPicAndReturnMasterAuthor : END');

  return _masterAuthor;
}
// --------------------------
Future<void> _addBzIDToUserBzzIDs({
  @required BuildContext context,
  @required UserModel userModel,
  @required String bzID,
}) async {

  blog('_addBzIDToUserBzzIDs : START');

  final List<dynamic> _userBzzIDs = TextMod.addStringToListIfDoesNotContainIt(
    strings: userModel.myBzzIDs,
    stringToAdd: bzID,
  );

  await Fire.updateDocField(
    context: context,
    collName: FireColl.users,
    docName: userModel.id,
    field: 'myBzzIDs',
    input: _userBzzIDs,
  );

  blog('_addBzIDToUserBzzIDs : END');

}
// -----------------------------------------------------------------------------

/// READ

// --------------------------
/// TESTED : WORKS PERFECT
Future<BzModel> readBz({
  @required BuildContext context,
  @required String bzID,
}) async {

  final dynamic _bzMap = await Fire.readDoc(
      context: context,
      collName: FireColl.bzz,
      docName: bzID,
  );

  final BzModel _bz = BzModel.decipherBz(
    map: _bzMap,
    fromJSON: false,
  );

  return _bz;
}
// --------------------------
Future<dynamic> readAndFilterTeamlessBzzByUserModel({
  @required BuildContext context,
  @required UserModel userModel,
}) async {
  // ----------
  /// This returns Map<String, dynamic> for which user bzz can he delete
  /// user can delete his bz only if he is the only author
  /// 1 - read all user['myBzzIDs'] bzz
  /// 2 - filters which bz can be deleted and which can not be deleted
  /// 3 - return {'bzzToKeep' : _bzzToKeep, 'bzzToDeactivate' : _bzzToDeactivate, }
  // ----------

  final List<BzModel> _bzzToDeactivate = <BzModel>[];
  final List<BzModel> _bzzToKeep = <BzModel>[];
  for (final String id in userModel.myBzzIDs) {
    final BzModel _bz = await readBz(
      context: context,
      bzID: id,
    );

    if (_bz.authors.length == 1) {
      _bzzToDeactivate.add(_bz);
    } else {
      _bzzToKeep.add(_bz);
    }
  }

  final Map<String, dynamic> _bzzMap = <String, dynamic>{
    'bzzToKeep': _bzzToKeep,
    'bzzToDeactivate': _bzzToDeactivate,
  };

  return _bzzMap;
}
// -----------------------------------------------------------------------------

/// UPDATE

// --------------------------
Future<BzModel> updateBz({
  @required BuildContext context,
  @required BzModel newBzModel,
  @required BzModel oldBzModel,
  @required File authorPicFile,
}) async {

  BzModel _output;

  blog('updateBz : START');

  if (newBzModel != null && oldBzModel != null){

    final BzModel _updatedBzModel = await _updateBzLogoIfChangedAndReturnNewBzModel(
      context: context,
      newBzModel: newBzModel,
      oldBzModel: oldBzModel,
    );

    final BzModel _finalBzModel = await _updateAuthorPicIfChangedAndReturnNewBzModel(
      context: context,
      oldBzModel: _updatedBzModel,
      authorID: AuthFireOps.superUserID(),
      newAuthorPic: authorPicFile,
    );

    await _updateBzDoc(
      context: context,
      finalBzModel: _finalBzModel,
    );

    _output = _finalBzModel;
  }

  blog('updateBz : END');

  return _output;
}
// --------------------------
Future<BzModel> _updateBzLogoIfChangedAndReturnNewBzModel({
  @required BuildContext context,
  @required BzModel newBzModel,
  @required BzModel oldBzModel,
}) async {

  String _bzLogoURL = oldBzModel.logo;

  blog('_updateBzLogoIfChangedAndUpdatedBzModel : START');


  if (newBzModel?.logo != null){

    /// IF NEW LOGO IS URL
    if (ObjectChecker.objectIsURL(newBzModel?.logo) == true) {

      /// IF URL IS CHANGED
      if (newBzModel?.logo != oldBzModel.logo){
        _bzLogoURL = newBzModel?.logo;
      }

    }

    /// IF NEW LOGO IS FILE
    else if (ObjectChecker.objectIsFile(newBzModel?.logo) == true){

      _bzLogoURL = await Storage.updateExistingPic(
        context: context,
        newPic: newBzModel?.logo,
        oldURL: oldBzModel.logo,
      );

    }


  }

  final BzModel _updatedBzModel = newBzModel.copyWith(
    logo: _bzLogoURL,
  );

  blog('_updateBzLogoIfChangedAndUpdatedBzModel : END');

  return _updatedBzModel;
}
// --------------------------
Future<BzModel> _updateAuthorPicIfChangedAndReturnNewBzModel({
  @required BuildContext context,
  @required BzModel oldBzModel,
  @required String authorID,
  @required File newAuthorPic,
}) async {

  BzModel _finalBz = oldBzModel;

  blog('_updateAuthorPicIfChangedAndUpdateBzModel : START');

  if (authorID != null && newAuthorPic != null){

    final AuthorModel _oldAuthor = AuthorModel.getAuthorFromBzByAuthorID(
      bz: oldBzModel,
      authorID: authorID,
    );

    if (_oldAuthor != null){

      final String _picName = AuthorModel.generateAuthorPicID(
        authorID: _oldAuthor.userID,
        bzID: oldBzModel.id,
      );

      final String _authorPicURL = await Storage.createStoragePicAndGetURL(
        context: context,
        inputFile: newAuthorPic,
        docName: StorageDoc.authors,
        picName: _picName,
        ownerID: _oldAuthor.userID,
      );

      final AuthorModel _updatedAuthor = _oldAuthor.copyWith(
        pic: _authorPicURL,
      );

      final List<AuthorModel> _finalAuthorsList = AuthorModel.replaceAuthorModelInAuthorsList(
        originalAuthors: oldBzModel.authors,
        oldAuthor: _oldAuthor,
        newAuthor: _updatedAuthor,
      );

      _finalBz = oldBzModel.copyWith(
        authors: _finalAuthorsList,
      );

    }

  }

  blog('_updateAuthorPicIfChangedAndUpdateBzModel : END');

  return _finalBz;
}
// --------------------------
Future<void> _updateBzDoc({
  @required BuildContext context,
  @required BzModel finalBzModel,
}) async {

  blog('_updateBzDoc : START');

  if (finalBzModel != null){

    await Fire.updateDoc(
      context: context,
      collName: FireColl.bzz,
      docName: finalBzModel.id,
      input: finalBzModel.toMap(toJSON: false),
    );

  }

  blog('_updateBzDoc : END');

}
// -----------------------------------------------------------------------------

/// DELETE

// --------------------------
Future<void> deleteBzOps({
  @required BuildContext context,
  @required BzModel bzModel,
}) async {

  blog('deleteBzOps : START');

  await _deleteBzFlyers(
    context: context,
    bzModel: bzModel,
  );

  await _deleteBzRecords(
    context: context,
    bzModel: bzModel,
  );

  await _deleteBzStorageLogo(
    context: context,
    bzModel: bzModel,
  );

  await _deleteBzAuthorsPictures(
    context: context,
    bzModel: bzModel,
  );

  await _deleteBzDoc(
    context: context,
    bzModel: bzModel,
  );

  /// SHOULD BE LAST DUE TO FIREBASE PERMISSIONS
  await _deleteBzIDFromAuthorBzIDs(
    context: context,
    bzModel: bzModel,
  );

  blog('deleteBzOps : END');
}
// --------------------------
Future<void> _deleteBzFlyers({
  @required BuildContext context,
  @required BzModel bzModel,
}) async {

  blog('_deleteBzFlyers : START');
  
  if (bzModel != null){
    
    if (Mapper.canLoopList(bzModel.flyersIDs) == true){

      for (final String id in bzModel.flyersIDs) {
        
        final FlyerModel _flyerModel = await FlyerFireOps.readFlyerOps(
          context: context,
          flyerID: id,
        );
        
        await FlyerFireOps.deleteFlyerOps(
          context: context,
          bzModel: bzModel,
          flyerModel: _flyerModel,
          deleteFlyerIDFromBzzFlyersIDs: false,
        );
      }
      
    }
    
    else {
      blog('_deleteBzFlyers : bzModel ${bzModel.id} has no flyers to delete');
    }
    
  }
  
  blog('_deleteBzFlyers : END');

}
// --------------------------
Future<void> _deleteBzIDFromAuthorBzIDs({
  @required BuildContext context,
  @required BzModel bzModel,
}) async {

  blog('_deleteBzIDFromBzAuthorsBzIDs : START');

  if (bzModel != null){

    final List<String> _authorsIDs = AuthorModel.getAuthorsIDsFromAuthors(
      authors: bzModel.authors,
    );
    
    if (Mapper.canLoopList(_authorsIDs) == true){

      for (final String authorID in _authorsIDs) {

        /// TASK :  SHOULD NOT FETCH STUFF IN BZ OPS API
        final UserModel _authorUserModel = await UsersProvider.proFetchUserModel(
            context: context,
            userID: authorID
        );

        await UserFireOps.removeBzIDFromUserBzzIDs(
            context: context,
            bzID: bzModel.id,
            oldUserModel: _authorUserModel,
        );

      }
      
    }


  }
  
  blog('_deleteBzIDFromBzAuthorsBzIDs : END');

}
// --------------------------
Future<void> _deleteBzRecords({
  @required BuildContext context,
  @required BzModel bzModel,
}) async {

  blog('_deleteBzRecords : START');

  if (bzModel != null){

    /// DELETE CALLS
    ///
    /// DELETE FOLLOWS
    ///
    /// DELETE COUNTERS
    ///

  }

  blog('_deleteBzRecords : END');

}
// --------------------------
Future<void> _deleteBzStorageLogo({
  @required BuildContext context,
  @required BzModel bzModel,
}) async {

  blog('_deleteBzStorageLogo : START');

  if (bzModel != null){

    await Storage.deleteStoragePic(
      context: context,
      picName: bzModel.id,
      docName: StorageDoc.logos,
    );

  }

  blog('_deleteBzStorageLogo : END');

}
// --------------------------
Future<void> _deleteBzAuthorsPictures({
  @required BuildContext context,
  @required BzModel bzModel,
}) async {

  blog('_deleteBzAuthorsPictures : START');

  if (bzModel != null && Mapper.canLoopList(bzModel.authors) == true){

    final List<String> _authorsIDs = AuthorModel.getAuthorsIDsFromAuthors(
        authors: bzModel.authors,
    );

    for (final String id in _authorsIDs) {

      final String _authorPicName = AuthorModel.generateAuthorPicID(
        authorID: id,
        bzID: bzModel.id,
      );

      await Storage.deleteStoragePic(
        context: context,
        picName: _authorPicName,
        docName: StorageDoc.authors,
      );

    }

  }

  blog('_deleteBzAuthorsPictures : END');

}
// --------------------------
Future<void> _deleteBzDoc({
  @required BuildContext context,
  @required BzModel bzModel,
}) async {

  blog('_deleteBzDoc : START');

  if (bzModel != null){

    await Fire.deleteDoc(
      context: context,
      collName: FireColl.bzz,
      docName: bzModel.id,
    );

  }

  blog('_deleteBzDoc : END');

}
// -----------------------------------------------------------------------------
