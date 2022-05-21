import 'dart:io';

import 'package:bldrs/a_models/bz/author_model.dart';
import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/a_models/secondary_models/error_helpers.dart';
import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/e_db/fire/methods/firestore.dart' as Fire;
import 'package:bldrs/e_db/fire/methods/paths.dart';
import 'package:bldrs/e_db/fire/methods/storage.dart' as Storage;
import 'package:bldrs/e_db/fire/ops/auth_ops.dart' as FireAuthOps;
import 'package:bldrs/e_db/fire/ops/flyer_ops.dart' as FireFlyerOps;
import 'package:bldrs/e_db/fire/ops/user_ops.dart' as UserFireOps;
import 'package:bldrs/f_helpers/drafters/mappers.dart' as Mapper;
import 'package:bldrs/f_helpers/drafters/object_checkers.dart';
import 'package:bldrs/f_helpers/drafters/text_mod.dart' as TextMod;
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:bldrs/f_helpers/drafters/object_checkers.dart' as ObjectChecker;

/// create, read, update, delete bz doc in cloud firestore

// ------------------------------------------------
/// REFERENCES

// ------------------------------------------------
/// bzz firestore collection reference getter
CollectionReference<Object> collRef() {
  return Fire.getCollectionRef(FireColl.bzz);
}

// ------------------------------------------------
/// bz firestore document reference
DocumentReference<Object> docRef(String bzID) {
  return Fire.getDocRef(collName: FireColl.bzz, docName: bzID);
}
// -----------------------------------------------------------------------------

/// CREATE

// ------------------------------------------------
/// create bz operations on firestore
Future<BzModel> createBz({
  @required BuildContext context,
  @required BzModel inputBz,
  @required UserModel userModel,
}) async {

  /// Notes :-
  // inputBz has inputBz.bzLogo & inputBz.authors[0].authorPic as Files not URLs

  BzModel _output;

  final bool _result = await tryCatchAndReturnBool(
    context: context,
    methodName: 'createBz',
    functions: () async {

      /// create empty firestore bz doc to get back _bzID
      final DocumentReference<Object> _docRef = await Fire.createDoc(
        context: context,
        collName: FireColl.bzz,
        input: <String, dynamic>{},
      );
      final String _bzID = _docRef.id;

      /// save bzLogo to fire storage and get URL
      String _bzLogoURL;
      if (inputBz.logo != null && ObjectChecker.objectIsFile(inputBz?.logo) == true) {
        _bzLogoURL = await Storage.createStoragePicAndGetURL(
          context: context,
          inputFile: inputBz.logo,
          picName: _bzID,
          docName: StorageDoc.logos,
          ownerID: userModel.id,
        );
      }
      else if (ObjectChecker.objectIsURL(inputBz?.logo) == true){
        _bzLogoURL = inputBz?.logo;
      }

      /// upload authorPic
      String _authorPicURL;
      if (inputBz.authors[0].pic == null ||  objectIsURL(inputBz.authors[0].pic) == true) {
        _authorPicURL = userModel.pic;
      }

      else {
        _authorPicURL = await Storage.createStoragePicAndGetURL(
          context: context,
          inputFile: inputBz.authors[0].pic,
          picName:
          AuthorModel.generateAuthorPicID(authorID: userModel.id, bzID: _bzID),
          docName: StorageDoc.authors,
          ownerID: userModel.id,
        );
      }

      /// update authorModel with _authorPicURL
      final AuthorModel _masterAuthor = AuthorModel(
        userID: userModel.id,
        name: inputBz.authors[0].name,
        title: inputBz.authors[0].title,
        pic: _authorPicURL,
        isMaster: true,
        contacts: inputBz.authors[0].contacts,
      );

      /// refactor the bzModel with new pics URLs generated above
      final BzModel _outputBz = inputBz.copyWith(
        id: _bzID,
        createdAt: DateTime.now(),
        logo: _bzLogoURL,
        authors: <AuthorModel>[_masterAuthor],
      );

      /// replace empty bz document with the new refactored one _bz
      await Fire.updateDoc(
        context: context,
        collName: FireColl.bzz,
        docName: _bzID,
        input: _outputBz.toMap(toJSON: false),
      );

      /// add bzID in user's myBzIDs
      final List<dynamic> _userBzzIDs = TextMod.addStringToListIfDoesNotContainIt(
          strings: userModel.myBzzIDs,
          stringToAdd: _bzID,
      );

      await Fire.updateDocField(
        context: context,
        collName: FireColl.users,
        docName: userModel.id,
        field: 'myBzzIDs',
        input: _userBzzIDs,
      );

      _output = _outputBz;

    },
      onError: (String error){
        blog('the create bz error is : $error');
      }
  );

  return _result == true ? _output : null;
}
// -----------------------------------------------------------------------------

/// READ

// ------------------------------------------------
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
// ------------------------------------------------
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

// ------------------------------------------------
Future<BzModel> updateBz({
  @required BuildContext context,
  @required BzModel modifiedBz,
  @required BzModel originalBz,
  @required File bzLogoFile,
  @required File authorPicFile,
}) async {
  // ----------
  /// 1 - update bzLogo if changed
  /// 2 - update authorPic if changed
  // ----------

  /// 1 - update bzLogo if changed
  String _bzLogoURL;
  if (bzLogoFile == null) {
    // do Nothing, bzLogo was not changed, will keep as
  } else {
    _bzLogoURL = await Storage.updateExistingPic(
      context: context,
      newPic: bzLogoFile,
      oldURL: originalBz.logo,
    );
  }

  /// 2 - update authorPic if changed
  final AuthorModel _oldAuthor = AuthorModel.getAuthorFromBzByAuthorID(
      modifiedBz, FireAuthOps.superUserID());
  final String _authorID = _oldAuthor.userID;

  String _authorPicURL;
  if (authorPicFile != null) {
    final String _picName = AuthorModel.generateAuthorPicID(
      authorID: _authorID,
      bzID: originalBz.id,
    );

    _authorPicURL = await Storage.createStoragePicAndGetURL(
      context: context,
      inputFile: authorPicFile,
      docName: StorageDoc.authors,
      picName: _picName,
      ownerID: _oldAuthor.userID,
    );
  }

  /// update authorsList if authorPicChanged
  final AuthorModel _newAuthor = AuthorModel(
    userID: _authorID,
    name: _oldAuthor.name,
    pic: _authorPicURL ?? _oldAuthor.pic,
    title: _oldAuthor.title,
    isMaster: _oldAuthor.isMaster,
    contacts: _oldAuthor.contacts,
  );

  final List<AuthorModel> _finalAuthorList =
      AuthorModel.replaceAuthorModelInAuthorsList(
    originalAuthors: modifiedBz.authors,
    oldAuthor: _oldAuthor,
    newAuthor: _newAuthor,
  );

  /// update bzModel if images changed
  final BzModel _finalBz = BzModel(
    id: modifiedBz.id,
    // -------------------------
    bzTypes: modifiedBz.bzTypes,
    bzForm: modifiedBz.bzForm,
    createdAt: modifiedBz.createdAt,
    accountType: modifiedBz.accountType,
    // -------------------------
    name: modifiedBz.name,
    trigram: modifiedBz.trigram,
    logo: _bzLogoURL ?? modifiedBz.logo,
    scope: modifiedBz.scope,
    zone: modifiedBz.zone,
    about: modifiedBz.about,
    position: modifiedBz.position,
    contacts: modifiedBz.contacts,
    authors: _finalAuthorList,
    showsTeam: modifiedBz.showsTeam,
    // -------------------------
    isVerified: modifiedBz.isVerified,
    bzState: modifiedBz.bzState,
    // -------------------------
    totalFollowers: modifiedBz.totalFollowers,
    totalSaves: modifiedBz.totalSaves,
    totalShares: modifiedBz.totalShares,
    totalSlides: modifiedBz.totalSlides,
    totalViews: modifiedBz.totalViews,
    totalCalls: modifiedBz.totalCalls,
    // -------------------------
    flyersIDs: modifiedBz.flyersIDs,
    totalFlyers: modifiedBz.totalFlyers,
  );

  /// update firestore bz document
  await Fire.updateDoc(
    context: context,
    collName: FireColl.bzz,
    docName: modifiedBz.id,
    input: _finalBz.toMap(toJSON: false),
  );

  return _finalBz;
}
// -----------------------------------------------------------------------------
Future<void> deactivateBz({
  @required BuildContext context,
  @required BzModel bzModel,
}) async {
  // ----------
  /// this
  /// 1 - starts deactivate flyer ops for all bz flyers
  /// 2 - deletes : firestore/tinyBzz/bzID
  /// 3 - deletes bzID from each author's userModel in : firestore/users/userID['myBzzIDs']
  /// 4 - triggers : firestore/bzz/bzID['bzAccountIsDeactivated'] to true
  // ----------

  /// 1 - perform deactivate flyer ops for all flyers
  final List<String> _flyersIDs = bzModel.flyersIDs;

  if (_flyersIDs.isNotEmpty) {
    for (final String id in _flyersIDs) {
      await FireFlyerOps.deactivateFlyerOps(
        context: context,
        bzModel: bzModel,
        flyerID: id,
      );
    }
  }

  /// 3 - delete bzID from myBzzIDs for each author
  final List<AuthorModel> _authors = bzModel.authors;
  final List<String> _authorsIDs =
      AuthorModel.getAuthorsIDsFromAuthors(_authors);
  for (final String id in _authorsIDs) {
    final UserModel _user =
        await UserFireOps.readUser(context: context, userID: id);

    final List<String> _myBzzIDs = _user.myBzzIDs;
    final int _bzIndex = _myBzzIDs.indexWhere((String id) => id == bzModel.id);
    _myBzzIDs.removeAt(_bzIndex);

    await Fire.updateDocField(
      context: context,
      collName: FireColl.users,
      docName: id,
      field: 'myBzzIDs',
      input: _myBzzIDs,
    );
  }

  /// 4 - trigger bz deactivation
  await Fire.updateDocField(
    context: context,
    collName: FireColl.bzz,
    docName: bzModel.id,
    field: 'bzAccountIsDeactivated',
    input: true,
  );
}
// -----------------------------------------------------------------------------
Future<void> deleteBzOps({
  @required BuildContext context,
  @required BzModel bzModel,
}) async {
  // ----------
  /// 1 - reads then starts delete flyer ops to all bz flyers
  /// 2 - deletes : firestore/tinyBzz/bzID
  /// 3 - deletes bzID from each author's userModel in : firestore/users/userID['myBzzIDs']
  /// 4 - deletes all docs under : firestore/bzz/bzID/calls
  /// 5 - deletes all docs under : firestore/bzz/bzID/follows
  /// 6 - deletes : firestore/bzz/bzID/counters/counters
  /// 7 - deletes JPG : storage/bzLogos/bzID
  /// 8 - deletes all JPGs of all bz Authors in : storage/authorsPics/authorID
  /// 9 - deletes : firestore/bzz/bzID
  // ----------

  blog('1 - start delete flyer ops for all flyers');
  // final List<String> _flyersIDs = bzModel.flyersIDs;
  if (Mapper.canLoopList(bzModel.flyersIDs)) {
    for (final String id in bzModel.flyersIDs) {

      blog('a - getting flyer : $id');
      final FlyerModel _flyerModel = await FireFlyerOps.readFlyerOps(
        context: context,
        flyerID: id,
      );

      blog('b - starting delete flyer ops aho rabbena yostor ------------ - - - ');
      await FireFlyerOps.deleteFlyerOps(
        context: context,
        bzModel: bzModel,
        flyerModel: _flyerModel,
        deleteFlyerIDFromBzzFlyersIDs: false,
      );
    }
  }

  blog("3 - delete bzID : ${bzModel.id} in all author's myBzIDs lists");
  final List<String> _authorsIDs = AuthorModel.getAuthorsIDsFromAuthors(bzModel.authors);
  for (final String authorID in _authorsIDs) {

    blog('a - get user model');
    final UserModel _user = await UserFireOps.readUser(
      context: context,
      userID: authorID,
    );

    blog("b - update user's myBzzIDs");
    final List<dynamic> _modifiedMyBzzIDs = UserModel.removeIDFromIDs(_user.myBzzIDs, bzModel.id);

    blog('c - update myBzzIDs field in user doc');
    await Fire.updateDocField(
      context: context,
      collName: FireColl.users,
      docName: authorID,
      field: 'myBzzIDs',
      input: _modifiedMyBzzIDs,
    );
  }

  blog('4 - delete all calls sub docs');
  await Fire.deleteSubCollection(
      context: context,
      collName: FireColl.bzz,
      docName: bzModel.id,
      subCollName: FireSubColl.bzz_bz_calls,
  );

  blog('5 - wont delete calls sub collection');
  // dunno if could be done here

  blog('6 - delete follows sub docs');
  await Fire.deleteSubCollection(
      context: context,
      collName: FireColl.bzz,
      docName: bzModel.id,
      subCollName: FireSubColl.bzz_bz_follows,
  );

  blog('7 - delete follows sub collection');
  // dunno if could be done here

  blog('8 - delete counters sub doc');
  await Fire.deleteSubDoc(
    context: context,
    collName: FireColl.bzz,
    docName: bzModel.id,
    subCollName: FireSubColl.bzz_bz_counters,
    subDocName: FireSubDoc.bzz_bz_counters_counters,
  );

  blog('9 - wont delete counters sub collection');
  // dunno if could be done here

  blog('10 - delete bz logo');
  await Storage.deleteStoragePic(
    context: context,
    picName: bzModel.id,
    docName: StorageDoc.logos,
  );

  blog('11 - delete all authors pictures');
  for (final String id in _authorsIDs) {

    final String _authorPicName = AuthorModel.generateAuthorPicID(
        authorID: id,
        bzID: bzModel.id,
    );
    blog('11a - should delete this storage pic of author id : $id : authorPicName : $_authorPicName');

    await Storage.deleteStoragePic(
      context: context,
      picName: _authorPicName,
      docName: StorageDoc.authors,
    );
  }

  blog('12 - delete bz doc');
  await Fire.deleteDoc(
    context: context,
    collName: FireColl.bzz,
    docName: bzModel.id,
  );

  blog('DELETE BZ OPS ENDED ---------------------------');
}
// -----------------------------------------------------------------------------
