import 'dart:io';
import 'package:bldrs/controllers/drafters/imagers.dart';
import 'package:bldrs/firestore/auth_ops.dart';
import 'package:bldrs/firestore/firestore.dart';
import 'package:bldrs/firestore/flyer_ops.dart';
import 'package:bldrs/firestore/user_ops.dart';
import 'package:bldrs/models/bz/bz_model.dart';
import 'package:bldrs/models/flyer/flyer_model.dart';
import 'package:bldrs/models/bz/author_model.dart';
import 'package:bldrs/models/flyer/nano_flyer.dart';
import 'package:bldrs/models/bz/tiny_bz.dart';
import 'package:bldrs/models/user/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

/// create, read, update, delete bz doc in cloud firestore
class BzOps{
// -----------------------------------------------------------------------------
  /// bz firestore collection reference
  final CollectionReference _bzCollectionRef = Fire.getCollectionRef(FireCollection.bzz);
// -----------------------------------------------------------------------------
  /// bzz firestore collection reference getter
  CollectionReference bzCollectionRef(){
    return
      _bzCollectionRef;
  }
// -----------------------------------------------------------------------------
  /// bz firestore document reference
  DocumentReference bzDocRef(String bzID){
    return
      Fire.getDocRef(
          collName: FireCollection.bzz,
          docName: bzID
      );
  }
// -----------------------------------------------------------------------------
  /// create bz operations on firestore
  Future<BzModel> createBzOps({
    BuildContext context,
    BzModel inputBz,
    UserModel userModel
  }) async {
    // Notes :-
    // inputBz has inputBz.bzLogo & inputBz.authors[0].authorPic as Files not URLs

    /// create empty firestore bz doc to get back _bzID
    DocumentReference _docRef = await Fire.createDoc(
      context: context,
      collName: FireCollection.bzz,
      input: {},
    );
    String _bzID = _docRef.id;

    /// save bzLogo to fire storage and get URL
    String _bzLogoURL;
    if (inputBz.bzLogo != null){
      _bzLogoURL = await Fire.createStoragePicAndGetURL(
          context: context,
          inputFile: inputBz.bzLogo,
          fileName: _bzID,
          picType: PicType.bzLogo
      );
    }

    /// upload authorPic
    String _authorPicURL;
    if(inputBz.bzAuthors[0].authorPic == null){
      _authorPicURL = userModel.pic;
    } else {
      _authorPicURL = await Fire.createStoragePicAndGetURL(
          context: context,
          inputFile: inputBz.bzAuthors[0].authorPic,
          fileName: AuthorModel.generateAuthorPicID(userModel.userID, _bzID),
          picType: PicType.authorPic
      );

    }

    /// update authorModel with _authorPicURL
    AuthorModel _masterAuthor = AuthorModel(
      userID: userModel.userID,
      authorName: inputBz.bzAuthors[0].authorName,
      authorTitle: inputBz.bzAuthors[0].authorTitle,
      authorPic: _authorPicURL,
      authorIsMaster: true,
      authorContacts: inputBz.bzAuthors[0].authorContacts,
    );

    /// TASK : generate bzURL
    String _bzURL = 'www.bldrs.net' ;

    /// refactor the bzModel with new pics URLs generated above
    BzModel _outputBz = BzModel(
      bzID : _bzID,
      // -------------------------
      bzType : inputBz.bzType,
      bzForm : inputBz.bzForm,
      bldrBirth : DateTime.now(),
      accountType : inputBz.accountType,
      bzURL : _bzURL,
      // -------------------------
      bzName : inputBz.bzName,
      bzLogo : _bzLogoURL,
      bzScope : inputBz.bzScope,
      bzZone : inputBz.bzZone,
      bzAbout : inputBz.bzAbout,
      bzPosition : inputBz.bzPosition,
      bzContacts : inputBz.bzContacts,
      bzAuthors : <AuthorModel>[_masterAuthor],
      bzShowsTeam : inputBz.bzShowsTeam,
      // -------------------------
      bzIsVerified : inputBz.bzIsVerified,
      bzAccountIsDeactivated : inputBz.bzAccountIsDeactivated,
      bzAccountIsBanned : inputBz.bzAccountIsBanned,
      // -------------------------
      bzTotalFollowers : inputBz.bzTotalFollowers,
      bzTotalSaves : inputBz.bzTotalSaves,
      bzTotalShares : inputBz.bzTotalShares,
      bzTotalSlides : inputBz.bzTotalSlides,
      bzTotalViews : inputBz.bzTotalViews,
      bzTotalCalls : inputBz.bzTotalCalls,
      // -------------------------
      nanoFlyers : inputBz.nanoFlyers,
      bzTotalFlyers: inputBz.bzTotalFlyers,
      authorsIDs: inputBz.authorsIDs,
    );

    /// replace empty bz document with the new refactored one _bz
    await Fire.updateDoc(
      context: context,
      collName: FireCollection.bzz,
      docName: _bzID,
      input: _outputBz.toMap(),
    );

    /// add new TinyBz in firestore
    await Fire.createNamedDoc(
      context: context,
      collName: FireCollection.tinyBzz,
      docName: _bzID,
      input: (TinyBz.getTinyBzFromBzModel(_outputBz)).toMap(),
    );

    /// add bzID in user's myBzIDs
    List<dynamic> _userBzzIDs = userModel.myBzzIDs;
    _userBzzIDs.insert(0, _bzID);
    await Fire.updateDocField(
      context: context,
      collName: FireCollection.users,
      docName: userModel.userID,
      field: 'myBzzIDs',
      input: _userBzzIDs,
    );

    return _outputBz;
  }
// -----------------------------------------------------------------------------
  static Future<BzModel> readBzOps({BuildContext context, String bzID}) async {

    dynamic _bzMap = await Fire.readDoc(
        context: context,
        collName: FireCollection.bzz,
        docName: bzID
    );
    BzModel _bz = BzModel.decipherBzMap(_bzMap);

    return _bz;
  }
// -----------------------------------------------------------------------------
  static Future<TinyBz> readTinyBzOps({BuildContext context, String bzID}) async {

    Map<String, dynamic> _tinyBzMap = await Fire.readDoc(
      context: context,
      collName: FireCollection.tinyBzz,
      docName: bzID,
    );

    TinyBz _tinyBz = TinyBz.decipherTinyBzMap(_tinyBzMap);

    return _tinyBz;
  }
// -----------------------------------------------------------------------------
  /// 1 - update bzLogo if changed
  /// 2 - update authorPic if changed
  Future<BzModel> updateBzOps({
    BuildContext context,
    BzModel modifiedBz,
    BzModel originalBz,
    File bzLogoFile,
    File authorPicFile,
  }) async {

    /// 1 - update bzLogo if changed
    String _bzLogoURL;
    if(bzLogoFile == null) {
      // do Nothing, bzLogo was not changed, will keep as
    } else {
      _bzLogoURL = await Fire.createStoragePicAndGetURL(
          context: context,
          inputFile: bzLogoFile,
          fileName: originalBz.bzID,
          picType: PicType.bzLogo
      );

    }

    /// 2 - update authorPic if changed
    AuthorModel _modifiedAuthor = AuthorModel.getAuthorFromBzByAuthorID(modifiedBz, superUserID());
    String _authorPicURL;
    if(authorPicFile == null) {
      // do Nothing, author pic was not changed, will keep as
    } else {

      String _authorID = superUserID();

      _authorPicURL = await Fire.createStoragePicAndGetURL(
          context: context,
          inputFile: authorPicFile,
          fileName: AuthorModel.generateAuthorPicID(_authorID, originalBz.bzID),
          picType: PicType.authorPic,
      );
    }

    /// update authorsList if authorPicChanged
    AuthorModel _finalAuthorModel = AuthorModel(
      userID : _modifiedAuthor.userID,
      authorName : _modifiedAuthor.authorName,
      authorPic : _authorPicURL ?? originalBz.bzAuthors[AuthorModel.getAuthorIndexByAuthorID(originalBz.bzAuthors, _modifiedAuthor.userID)].authorPic,
      authorTitle : _modifiedAuthor.authorTitle,
      authorIsMaster : _modifiedAuthor.authorIsMaster,
      authorContacts : _modifiedAuthor.authorContacts,
    );
    List<AuthorModel> _finalAuthorList = AuthorModel.replaceAuthorModelInAuthorsList(modifiedBz.bzAuthors, _finalAuthorModel);

    /// update bzModel if images changed
    BzModel _finalBz = BzModel(
      bzID: modifiedBz.bzID,
      // -------------------------
      bzType: modifiedBz.bzType,
      bzForm: modifiedBz.bzForm,
      bldrBirth: modifiedBz.bldrBirth,
      accountType: modifiedBz.accountType,
      bzURL: modifiedBz.bzURL,
      // -------------------------
      bzName: modifiedBz.bzName,
      bzLogo: _bzLogoURL ?? modifiedBz.bzLogo,
      bzScope: modifiedBz.bzScope,
      bzZone  : modifiedBz.bzZone,
      bzAbout: modifiedBz.bzAbout,
      bzPosition: modifiedBz.bzPosition,
      bzContacts: modifiedBz.bzContacts,
      bzAuthors: _finalAuthorList,
      bzShowsTeam: modifiedBz.bzShowsTeam,
      // -------------------------
      bzIsVerified: modifiedBz.bzIsVerified,
      bzAccountIsDeactivated: modifiedBz.bzAccountIsDeactivated,
      bzAccountIsBanned: modifiedBz.bzAccountIsBanned,
      // -------------------------
      bzTotalFollowers: modifiedBz.bzTotalFollowers,
      bzTotalSaves: modifiedBz.bzTotalSaves,
      bzTotalShares: modifiedBz.bzTotalShares,
      bzTotalSlides: modifiedBz.bzTotalSlides,
      bzTotalViews: modifiedBz.bzTotalViews,
      bzTotalCalls: modifiedBz.bzTotalCalls,
      // -------------------------
      nanoFlyers: modifiedBz.nanoFlyers,
      bzTotalFlyers: modifiedBz.bzTotalFlyers,
      authorsIDs: modifiedBz.authorsIDs,
    );

    /// update firestore bz document
    await Fire.updateDoc(
      context: context,
      collName: FireCollection.bzz,
      docName: modifiedBz.bzID,
      input: _finalBz.toMap(),
    );

    /// only if TinyBz changed :-
    if(
    // bzID and BzLogo URL will always stay the same after creation
    _finalBz.bzName != originalBz.bzName ||
        _finalBz.bzLogo != originalBz.bzLogo ||
        _finalBz.bzType != originalBz.bzType ||
        _finalBz.bzZone.countryID != originalBz.bzZone.countryID ||
        _finalBz.bzZone.cityID != originalBz.bzZone.cityID ||
        _finalBz.bzZone.districtID != originalBz.bzZone.districtID
    ){
    TinyBz _modifiedTinyBz = TinyBz.getTinyBzFromBzModel(_finalBz)  ;
    Map<String, dynamic> _modifiedTinyBzMap = _modifiedTinyBz.toMap();

    /// update tinyBz document
    await Fire.updateDoc(
      context: context,
      collName: FireCollection.tinyBzz,
      docName: _finalBz.bzID,
      input: _modifiedTinyBzMap,
    );

    /// update tinyBz in all flyers
    /// TASK : this may require firestore batch write
      List<String> _bzFlyersIDs = NanoFlyer.getListOfFlyerIDsFromNanoFlyers(_finalBz.nanoFlyers);
      if(_bzFlyersIDs.length > 0){
        for (var id in _bzFlyersIDs){
          await Fire.updateDocField(
            context: context,
            collName: FireCollection.flyers,
            docName: id,
            field: 'tinyBz',
            input: _modifiedTinyBzMap,
          );
        }
      }

    /// update tinyBz in all Tinyflyers
    /// TASK : this may require firestore batch write
    if(_bzFlyersIDs.length > 0){
      for (var id in _bzFlyersIDs){
        await Fire.updateDocField(
          context: context,
          collName: FireCollection.tinyFlyers,
          docName: id,
          field: 'tinyBz',
          input: _modifiedTinyBzMap,
        );
      }
    }

    }

    return _finalBz;
  }
// -----------------------------------------------------------------------------
  /// this
  /// 1 - starts deactivate flyer ops for all bz flyers
  /// 2 - deletes : firestore/tinyBzz/bzID
  /// 3 - deletes bzID from each author's userModel in : firestore/users/userID['myBzzIDs']
  /// 4 - triggers : firestore/bzz/bzID['bzAccountIsDeactivated'] to true
  Future<void> deactivateBzOps({BuildContext context, BzModel bzModel}) async {

    /// 1 - perform deactivate flyer ops for all flyers
    List<String> _flyersIDs = [];
    List<NanoFlyer> _bzNanoFlyers = bzModel.nanoFlyers;
    _bzNanoFlyers.forEach((flyer) {
      _flyersIDs.add(flyer.flyerID);
    });

    if (_flyersIDs.length > 0){
      for (var id in _flyersIDs){
        await FlyerOps().deactivateFlyerOps(
          context: context,
          bzModel: bzModel,
          flyerID: id,
        );
      }
    }


    /// 2 - delete tiny bz doc
    await Fire.deleteDoc(
      context: context,
      collName: FireCollection.tinyBzz,
      docName: bzModel.bzID,
    );

    /// 3 - delete bzID from myBzzIDs for each author
    List<AuthorModel> _authors = bzModel.bzAuthors;
    List<String> _authorsIDs = AuthorModel.getAuthorsIDsFromAuthors(_authors);
    for (var id in _authorsIDs){

      UserModel _user = await UserOps().readUserOps(context: context, userID: id);

      List<dynamic> _myBzzIDs = _user.myBzzIDs;
      int _bzIndex = _myBzzIDs.indexWhere((id) => id == bzModel.bzID);
      _myBzzIDs.removeAt(_bzIndex);

      await Fire.updateDocField(
        context: context,
        collName: FireCollection.users,
        docName: id,
        field: 'myBzzIDs',
        input: _myBzzIDs,
      );

    }

    /// 4 - trigger bz deactivation
    await Fire.updateDocField(
      context: context,
      collName: FireCollection.bzz,
      docName: bzModel.bzID,
      field: 'bzAccountIsDeactivated',
      input: true,
    );

  }
// -----------------------------------------------------------------------------
  /// 1 - reads then starts delete flyer ops to all bz flyers
  /// 2 - deletes : firestore/tinyBzz/bzID
  /// 3 - deletes bzID from each author's userModel in : firestore/users/userID['myBzzIDs']
  /// 4 - deletes all docs under : firestore/bzz/bzID/calls
  /// 5 - deletes all docs under : firestore/bzz/bzID/follows
  /// 6 - deletes : firestore/bzz/bzID/counters/counters
  /// 7 - deletes JPG : storage/bzLogos/bzID
  /// 8 - deletes all JPGs of all bz Authors in : storage/authorsPics/authorID
  /// 9 - deletes : firestore/bzz/bzID
  Future<void> superDeleteBzOps({BuildContext context, BzModel bzModel}) async {

    print('1 - start delete flyer ops for all flyers');
    List<String> _flyersIDs = BzModel.getBzFlyersIDs(bzModel);
    for (var id in _flyersIDs){

      print('a - getting flyer : $id');
      FlyerModel _flyerModel = await FlyerOps().readFlyerOps(
        context: context,
        flyerID: id,
      );

      print('b - starting delete flyer ops aho rabbena yostor ------------ - - - ');
      await FlyerOps().deleteFlyerOps(
        context: context,
        bzModel: bzModel,
        flyerModel: _flyerModel,
      );

    }

    print('2 - delete tiny bz doc');
    await Fire.deleteDoc(
      context: context,
      collName: FireCollection.tinyBzz,
      docName: bzModel.bzID,
    );

    print('3 - delete bzID : ${bzModel.bzID} in all author\'s myBzIDs lists');
    List<String> _authorsIDs = AuthorModel.getAuthorsIDsFromAuthors(bzModel.bzAuthors);
    for (var authorID in _authorsIDs){

      print('a - get user model');
      UserModel _user = await UserOps().readUserOps(
        context: context,
        userID: authorID,
      );

      print('b - update user\'s myBzzIDs');
      List<dynamic> _modifiedMyBzzIDs = UserModel.removeBzIDFromMyBzzIDs(_user.myBzzIDs, bzModel.bzID);

      print('c - update myBzzIDs field in user doc');
      await Fire.updateDocField(
        context: context,
        collName: FireCollection.users,
        docName: authorID,
        field: 'myBzzIDs',
        input: _modifiedMyBzzIDs,
      );
    }

    print('4 - delete all calls sub docs');
    await Fire.deleteAllSubDocs(
      context: context,
      collName: FireCollection.bzz,
      docName: bzModel.bzID,
      subCollName: FireCollection.subBzCalls
    );

    print('5 - wont delete calls sub collection');
    // dunno if could be done here

    print('6 - delete follows sub docs');
    await Fire.deleteAllSubDocs(
        context: context,
        collName: FireCollection.bzz,
        docName: bzModel.bzID,
        subCollName: FireCollection.subBzFollows

    );

    print('7 - delete follows sub collection');
    // dunno if could be done here

    print('8 - delete counters sub doc');
    await Fire.deleteSubDoc(
      context: context,
      collName: FireCollection.bzz,
      docName: bzModel.bzID,
      subCollName: FireCollection.subBzCounters,
      subDocName: FireCollection.subBzCounters,
    );

    print('9 - wont delete counters sub collection');
    // dunno if could be done here

    print('10 - delete bz logo');
    await Fire.deleteStoragePic(
      context: context,
      fileName: bzModel.bzID,
      picType: PicType.bzLogo,
    );

    print('11 - delete all authors pictures');
    for (var id in _authorsIDs){
      await Fire.deleteStoragePic(
        context: context,
        fileName: id,
        picType: PicType.authorPic,
      );
    }

    print('12 - delete bz doc');
    await Fire.deleteDoc(
      context: context,
      collName: FireCollection.bzz,
      docName: bzModel.bzID,
    );

    print('DELETE BZ OPS ENDED ---------------------------');

  }
// -----------------------------------------------------------------------------
  /// This returns Map<String, dynamic> for which user bzz can he delete
  /// user can delete his bz only if he is the only author
  /// 1 - read all user['myBzzIDs'] bzz
  /// 2 - filters which bz can be deleted and which can not be deleted
  /// 3 - return {'bzzToKeep' : _bzzToKeep, 'bzzToDeactivate' : _bzzToDeactivate, }
  static Future<dynamic> readAndFilterTeamlessBzzByUserModel({BuildContext context, UserModel userModel}) async {
    List<BzModel> _bzzToDeactivate = [];
    List<BzModel> _bzzToKeep = [];
    for (var id in userModel.myBzzIDs){

      BzModel _bz = await BzOps.readBzOps(
        context: context,
        bzID: id,
      );

      if (_bz.bzAuthors.length == 1){
        _bzzToDeactivate.add(_bz);
      } else{
        _bzzToKeep.add(_bz);
      }

    }

    Map<String, dynamic> _bzzMap = {
      'bzzToKeep' : _bzzToKeep,
      'bzzToDeactivate' : _bzzToDeactivate,
    };

    return _bzzMap;

}
// -----------------------------------------------------------------------------
}
