import 'dart:io';

import 'package:bldrs/controllers/drafters/mappers.dart';
import 'package:bldrs/db/fire/methods/firestore.dart';
import 'package:bldrs/db/fire/methods/paths.dart';
import 'package:bldrs/db/fire/methods/storage.dart';
import 'package:bldrs/db/fire/ops/auth_ops.dart';
import 'package:bldrs/db/fire/ops/flyer_ops.dart';
import 'package:bldrs/db/fire/ops/user_ops.dart';
import 'package:bldrs/models/bz/author_model.dart';
import 'package:bldrs/models/bz/bz_model.dart';
import 'package:bldrs/models/flyer/flyer_model.dart';
import 'package:bldrs/models/user/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

/// create, read, update, delete bz doc in cloud firestore
abstract class FireBzOps{

  /// REFERENCES

// ------------------------------------------------
  /// bzz firestore collection reference getter
  static CollectionReference collRef(){
    return Fire.getCollectionRef(FireColl.bzz);
  }
// ------------------------------------------------
  /// bz firestore document reference
  static DocumentReference docRef(String bzID){
    return
      Fire.getDocRef(
          collName: FireColl.bzz,
          docName: bzID
      );
  }
// -----------------------------------------------------------------------------

  /// CREATE

// ------------------------------------------------
  /// create bz operations on firestore
  static Future<BzModel> createBz({
    @required BuildContext context,
    @required BzModel inputBz,
    @required UserModel userModel
  }) async {
    // Notes :-
    // inputBz has inputBz.bzLogo & inputBz.authors[0].authorPic as Files not URLs

    /// create empty firestore bz doc to get back _bzID
    final DocumentReference _docRef = await Fire.createDoc(
      context: context,
      collName: FireColl.bzz,
      input: {},
    );
    final String _bzID = _docRef.id;

    /// save bzLogo to fire storage and get URL
    String _bzLogoURL;
    if (inputBz.logo != null){
      _bzLogoURL = await Storage.createStoragePicAndGetURL(
        context: context,
        inputFile: inputBz.logo,
        picName: _bzID,
        docName: StorageDoc.logos,
        ownerID: userModel.id,
      );
    }

    /// upload authorPic
    String _authorPicURL;
    if(inputBz.authors[0].pic == null){

      _authorPicURL = userModel.pic;

    } else {

      _authorPicURL = await Storage.createStoragePicAndGetURL(
        context: context,
        inputFile: inputBz.authors[0].pic,
        picName: AuthorModel.generateAuthorPicID(authorID: userModel.id, bzID: _bzID),
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
    final BzModel _outputBz = BzModel(
      id : _bzID,
      // -------------------------
      bzType : inputBz.bzType,
      bzForm : inputBz.bzForm,
      createdAt : DateTime.now(),
      accountType : inputBz.accountType,
      // -------------------------
      name : inputBz.name,
      trigram: inputBz.trigram,
      logo : _bzLogoURL,
      scope : inputBz.scope,
      zone : inputBz.zone,
      about : inputBz.about,
      position : inputBz.position,
      contacts : inputBz.contacts,
      authors : <AuthorModel>[_masterAuthor],
      showsTeam : inputBz.showsTeam,
      // -------------------------
      isVerified : inputBz.isVerified,
      bzState : inputBz.bzState,
      // -------------------------
      totalFollowers : inputBz.totalFollowers,
      totalSaves : inputBz.totalSaves,
      totalShares : inputBz.totalShares,
      totalSlides : inputBz.totalSlides,
      totalViews : inputBz.totalViews,
      totalCalls : inputBz.totalCalls,
      // -------------------------
      flyersIDs : inputBz.flyersIDs,
      totalFlyers: inputBz.totalFlyers,
    );

    /// replace empty bz document with the new refactored one _bz
    await Fire.updateDoc(
      context: context,
      collName: FireColl.bzz,
      docName: _bzID,
      input: _outputBz.toMap(toJSON: false),
    );

    /// add bzID in user's myBzIDs
    final List<dynamic> _userBzzIDs = userModel.myBzzIDs;
    _userBzzIDs.insert(0, _bzID);
    await Fire.updateDocField(
      context: context,
      collName: FireColl.users,
      docName: userModel.id,
      field: 'myBzzIDs',
      input: _userBzzIDs,
    );

    return _outputBz;
  }
// -----------------------------------------------------------------------------

  /// READ

// ------------------------------------------------
  static Future<BzModel> readBz({
    @required BuildContext context,
    @required String bzID,
  }) async {

    final dynamic _bzMap = await Fire.readDoc(
        context: context,
        collName: FireColl.bzz,
        docName: bzID
    );
    final BzModel _bz = BzModel.decipherBz(
      map: _bzMap,
      fromJSON: false,
    );

    return _bz;
  }
// ------------------------------------------------
  static Future<dynamic> readAndFilterTeamlessBzzByUserModel({
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
    for (var id in userModel.myBzzIDs){

      final BzModel _bz = await FireBzOps.readBz(
        context: context,
        bzID: id,
      );

      if (_bz.authors.length == 1){
        _bzzToDeactivate.add(_bz);
      } else{
        _bzzToKeep.add(_bz);
      }

    }

    final Map<String, dynamic> _bzzMap = {
      'bzzToKeep' : _bzzToKeep,
      'bzzToDeactivate' : _bzzToDeactivate,
    };

    return _bzzMap;

  }
// -----------------------------------------------------------------------------

  /// UPDATE

// ------------------------------------------------
  static Future<BzModel> updateBz({
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
    if(bzLogoFile == null) {
      // do Nothing, bzLogo was not changed, will keep as
    } else {
      _bzLogoURL = await Storage.updatePic(
          context: context,
          newPic: bzLogoFile,
          oldURL: originalBz.logo,
      );

    }

    /// 2 - update authorPic if changed
    final AuthorModel _oldAuthor = AuthorModel.getAuthorFromBzByAuthorID(modifiedBz, superUserID());
    final String _authorID = _oldAuthor.userID;

    String _authorPicURL;
    if(authorPicFile != null) {

      final String _picName = AuthorModel.generateAuthorPicID(
        authorID: _authorID,
        bzID: originalBz.id,
      );

      _authorPicURL = await Storage.createStoragePicAndGetURL(
        context: context,
        inputFile: authorPicFile,
        docName:  StorageDoc.authors,
        picName: _picName,
        ownerID: _oldAuthor.userID,
      );

    }

    /// update authorsList if authorPicChanged
    final AuthorModel _newAuthor = AuthorModel(
      userID : _authorID,
      name : _oldAuthor.name,
      pic : _authorPicURL ?? _oldAuthor.pic,
      title : _oldAuthor.title,
      isMaster : _oldAuthor.isMaster,
      contacts : _oldAuthor.contacts,
    );

    final List<AuthorModel> _finalAuthorList = AuthorModel.replaceAuthorModelInAuthorsList(
        originalAuthors: modifiedBz.authors,
        oldAuthor: _oldAuthor,
        newAuthor: _newAuthor,
    );

    /// update bzModel if images changed
    final BzModel _finalBz = BzModel(
      id: modifiedBz.id,
      // -------------------------
      bzType: modifiedBz.bzType,
      bzForm: modifiedBz.bzForm,
      createdAt: modifiedBz.createdAt,
      accountType: modifiedBz.accountType,
      // -------------------------
      name: modifiedBz.name,
      trigram: modifiedBz.trigram,
      logo: _bzLogoURL ?? modifiedBz.logo,
      scope: modifiedBz.scope,
      zone  : modifiedBz.zone,
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
  static Future<void> deactivateBz({
    @required BuildContext context,
    @required BzModel bzModel
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

    if (_flyersIDs.length > 0){
      for (var id in _flyersIDs){
        await FireFlyerOps.deactivateFlyerOps(
          context: context,
          bzModel: bzModel,
          flyerID: id,
        );
      }
    }


    /// 3 - delete bzID from myBzzIDs for each author
    final List<AuthorModel> _authors = bzModel.authors;
    final List<String> _authorsIDs = AuthorModel.getAuthorsIDsFromAuthors(_authors);
    for (String id in _authorsIDs){

      final UserModel _user = await UserFireOps.readUser(context: context, userID: id);

      final List<dynamic> _myBzzIDs = _user.myBzzIDs;
      final int _bzIndex = _myBzzIDs.indexWhere((id) => id == bzModel.id);
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
  static Future<void> deleteBz({
    @required BuildContext context,
    @required BzModel bzModel
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

    print('1 - start delete flyer ops for all flyers');
    // final List<String> _flyersIDs = bzModel.flyersIDs;
    if(Mapper.canLoopList(bzModel.flyersIDs)){

      for (var id in bzModel.flyersIDs){

        print('a - getting flyer : $id');
        final FlyerModel _flyerModel = await FireFlyerOps.readFlyerOps(
          context: context,
          flyerID: id,
        );

        print('b - starting delete flyer ops aho rabbena yostor ------------ - - - ');
        await FireFlyerOps.deleteFlyerOps(
          context: context,
          bzModel: bzModel,
          flyerModel: _flyerModel,
          deleteFlyerIDFromBzzFlyersIDs: false,
        );

      }

    }

    print('3 - delete bzID : ${bzModel.id} in all author\'s myBzIDs lists');
    final List<String> _authorsIDs = AuthorModel.getAuthorsIDsFromAuthors(bzModel.authors);
    for (var authorID in _authorsIDs){

      print('a - get user model');
      final UserModel _user = await UserFireOps.readUser(
        context: context,
        userID: authorID,
      );

      print('b - update user\'s myBzzIDs');
      final List<dynamic> _modifiedMyBzzIDs = UserModel.removeIDFromIDs(_user.myBzzIDs, bzModel.id);

      print('c - update myBzzIDs field in user doc');
      await Fire.updateDocField(
        context: context,
        collName: FireColl.users,
        docName: authorID,
        field: 'myBzzIDs',
        input: _modifiedMyBzzIDs,
      );
    }

    print('4 - delete all calls sub docs');
    await Fire.deleteAllSubDocs(
      context: context,
      collName: FireColl.bzz,
      docName: bzModel.id,
      subCollName: FireSubColl.bzz_bz_calls
    );

    print('5 - wont delete calls sub collection');
    // dunno if could be done here

    print('6 - delete follows sub docs');
    await Fire.deleteAllSubDocs(
        context: context,
        collName: FireColl.bzz,
        docName: bzModel.id,
        subCollName: FireSubColl.bzz_bz_follows

    );

    print('7 - delete follows sub collection');
    // dunno if could be done here

    print('8 - delete counters sub doc');
    await Fire.deleteSubDoc(
      context: context,
      collName: FireColl.bzz,
      docName: bzModel.id,
      subCollName: FireSubColl.bzz_bz_counters,
      subDocName: FireSubDoc.bzz_bz_counters_counters,
    );

    print('9 - wont delete counters sub collection');
    // dunno if could be done here

    print('10 - delete bz logo');
    await Storage.deleteStoragePic(
      context: context,
      picName: bzModel.id,
      docName: StorageDoc.logos,
    );

    print('11 - delete all authors pictures');
    for (var id in _authorsIDs){

      final String _authorPicName = AuthorModel.generateAuthorPicID(
          authorID: id,
          bzID: bzModel.id
      );

      await Storage.deleteStoragePic(
        context: context,
        picName: _authorPicName,
        docName: StorageDoc.authors,
      );

    }

    print('12 - delete bz doc');
    await Fire.deleteDoc(
      context: context,
      collName: FireColl.bzz,
      docName: bzModel.id,
    );

    print('DELETE BZ OPS ENDED ---------------------------');

  }
// -----------------------------------------------------------------------------
}
