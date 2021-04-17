import 'dart:io';
import 'package:bldrs/controllers/drafters/imagers.dart';
import 'package:bldrs/firestore/auth/auth.dart';
import 'package:bldrs/firestore/crud/flyer_ops.dart';
import 'package:bldrs/firestore/crud/user_ops.dart';
import 'package:bldrs/models/bz_model.dart';
import 'package:bldrs/models/sub_models/author_model.dart';
import 'package:bldrs/models/tiny_models/nano_flyer.dart';
import 'package:bldrs/models/tiny_models/tiny_bz.dart';
import 'package:bldrs/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../firebase_storage.dart';
import '../firestore.dart';

/// create, read, update, delete bz doc in cloud firestore
class BzCRUD{
// ---------------------------------------------------------------------------
  /// bz firestore collection reference
  final CollectionReference _bzCollectionRef = getFireCollectionReference(FireCollection.bzz);
// ---------------------------------------------------------------------------
  /// bzz firestore collection reference getter
  CollectionReference bzCollectionRef(){
    return
      _bzCollectionRef;
  }
// ---------------------------------------------------------------------------
  /// bz firestore document reference
  DocumentReference bzDocRef(String bzID){
    return
      getFirestoreDocumentReference(FireCollection.bzz, bzID);
  }
// ----------------------------------------------------------------------
  /// create bz operations on firestore
  Future<BzModel> createBzOps({
    BuildContext context,
    BzModel inputBz,
    UserModel userModel
  }) async {
    // Notes :-
    // inputBz has inputBz.bzLogo & inputBz.authors[0].authorPic as Files not URLs

    /// create empty firestore bz doc to get back _bzID
    DocumentReference _docRef = await createFireStoreDocument(
      context: context,
      collectionName: FireCollection.bzz,
      input: {},
    );
    String _bzID = _docRef.id;

    /// save bzLogo to fire storage and get URL
    String _bzLogoURL;
    if (inputBz.bzLogo != null){
      _bzLogoURL = await savePicOnFirebaseStorageAndGetURL(
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
      _authorPicURL = await savePicOnFirebaseStorageAndGetURL(
          context: context,
          inputFile: inputBz.bzAuthors[0].authorPic,
          fileName: userModel.userID,
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
      bzCountry : inputBz.bzCountry,
      bzProvince : inputBz.bzProvince,
      bzArea : inputBz.bzArea,
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
      bzFlyers : inputBz.bzFlyers,
    );

    /// replace empty bz document with the new refactored one _bz
    await replaceFirestoreDocument(
      context: context,
      collectionName: FireCollection.bzz,
      docName: _bzID,
      input: _outputBz.toMap(),
    );

    /// add new TinyBz in firestore
    await createFireStoreNamedDocument(
      context: context,
      collectionName: FireCollection.tinyBzz,
      docName: _bzID,
      input: (TinyBz.getTinyBzFromBzModel(_outputBz)).toMap(),
    );

    /// add bzID in user's myBzIDs
    List<dynamic> _userBzzIDs = userModel.myBzzIDs;
    _userBzzIDs.insert(0, _bzID);
    await updateFieldOnFirestore(
      context: context,
      collectionName: FireCollection.users,
      documentName: userModel.userID,
      field: 'myBzzIDs',
      input: _userBzzIDs,
    );

    return _outputBz;
  }
// ----------------------------------------------------------------------
  static Future<BzModel> readBzOps({BuildContext context, String bzID}) async {

    dynamic _bzMap = await getFireStoreDocumentMap(
        context: context,
        collectionName: FireCollection.bzz,
        documentName: bzID
    );
    BzModel _bz = BzModel.decipherBzMap(bzID, _bzMap);

    return _bz;
  }
// ----------------------------------------------------------------------
  /// update bz operations on firestore
  Future<BzModel> updateBzOps({
    BuildContext context,
    BzModel modifiedBz,
    BzModel originalBz,
    File bzLogoFile,
    File authorPicFile,
  }) async {

    /// update bzLogo if changed
    String _bzLogoURL;
    if(bzLogoFile == null) {
      // do Nothing, bzLogo was not changed, will keep as
    } else {
      _bzLogoURL = await savePicOnFirebaseStorageAndGetURL(
          context: context,
          inputFile: bzLogoFile,
          fileName: originalBz.bzID,
          picType: PicType.bzLogo
      );

    }

    /// update authorPic if changed
    AuthorModel _modifiedAuthor = AuthorModel.getAuthorFromBzByAuthorID(modifiedBz, superUserID());
    String _authorPicURL;
    if(authorPicFile == null) {
      // do Nothing, author pic was not changed, will keep as
    } else {

      String _authorID = superUserID();

      _authorPicURL = await savePicOnFirebaseStorageAndGetURL(
          context: context,
          inputFile: authorPicFile,
          fileName: _authorID,
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
      bzCountry: modifiedBz.bzCountry,
      bzProvince: modifiedBz.bzProvince,
      bzArea: modifiedBz.bzArea,
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
      bzFlyers: modifiedBz.bzFlyers,
    );

    /// update firestore bz document
    await replaceFirestoreDocument(
      context: context,
      collectionName: FireCollection.bzz,
      docName: modifiedBz.bzID,
      input: _finalBz.toMap(),
    );

    /// only if TinyBz changed :-
    if(
    // bzID and BzLogo URL will always stay the same after creation
    _finalBz.bzName != originalBz.bzName ||
        _finalBz.bzLogo != originalBz.bzLogo ||
        _finalBz.bzType != originalBz.bzType
    ){
    TinyBz _modifiedTinyBz = TinyBz.getTinyBzFromBzModel(_finalBz)  ;
    Map<String, dynamic> _modifiedTinyBzMap = _modifiedTinyBz.toMap();

    /// update tinyBz document
    await replaceFirestoreDocument(
      context: context,
      collectionName: FireCollection.tinyBzz,
      docName: _finalBz.bzID,
      input: _modifiedTinyBzMap,
    );

    /// update tinyBz in all flyers
    /// TASK : this may require firestore batch write
      List<String> _bzFlyersIDs = NanoFlyer.getListOfFlyerIDsFromNanoFlyers(_finalBz.bzFlyers);
      if(_bzFlyersIDs.length > 0){
        for (var id in _bzFlyersIDs){
          await updateFieldOnFirestore(
            context: context,
            collectionName: FireCollection.flyers,
            documentName: id,
            field: 'tinyBz',
            input: _modifiedTinyBzMap,
          );
        }
      }

    /// update tinyBz in all Tinyflyers
    /// TASK : this may require firestore batch write
    if(_bzFlyersIDs.length > 0){
      for (var id in _bzFlyersIDs){
        await updateFieldOnFirestore(
          context: context,
          collectionName: FireCollection.tinyFlyers,
          documentName: id,
          field: 'tinyBz',
          input: _modifiedTinyBzMap,
        );
      }
    }

    }

    return _finalBz;
  }
// ----------------------------------------------------------------------
  Future<void> deactivateBzOps({BuildContext context, BzModel bzModel}) async {

    /// 1 - perform deactivate flyer ops for all flyers
    List<String> _flyersIDs = new List();
    List<NanoFlyer> _bzNanoFlyers = bzModel.bzFlyers;
    _bzNanoFlyers.forEach((flyer) {
      _flyersIDs.add(flyer.flyerID);
    });

    if (_flyersIDs.length > 0){
      for (var id in _flyersIDs){
        await FlyerCRUD().deactivateFlyerOps(
          context: context,
          bzModel: bzModel,
          flyerID: id,
        );
      }
    }


    /// 2 - delete tiny bz doc
    await deleteDocumentOnFirestore(
      context: context,
      collectionName: FireCollection.tinyBzz,
      documentName: bzModel.bzID,
    );

    /// 3 - delete bzID from myBzzIDs for each author
    List<AuthorModel> _authors = bzModel.bzAuthors;
    List<String> _authorsIDs = AuthorModel.getAuthorsIDsFromAuthors(_authors);
    for (var id in _authorsIDs){

      UserModel _user = await UserCRUD().readUserOps(context: context, userID: id);

      List<dynamic> _myBzzIDs = _user.myBzzIDs;
      int _bzIndex = _myBzzIDs.indexWhere((id) => id == bzModel.bzID);
      _myBzzIDs.removeAt(_bzIndex);

      await updateFieldOnFirestore(
        context: context,
        collectionName: FireCollection.users,
        documentName: id,
        field: 'myBzzIDs',
        input: _myBzzIDs,
      );

    }


    /// 4 - trigger bz deactivation
    await updateFieldOnFirestore(
      context: context,
      collectionName: FireCollection.bzz,
      documentName: bzModel.bzID,
      field: 'bzAccountIsDeactivated',
      input: true,
    );

  }
// ----------------------------------------------------------------------
  Future<TinyBz> readTinyBzOps({BuildContext context, String bzID}) async {

    Map<String, dynamic> _tinyBzMap = await getFireStoreDocumentMap(
      context: context,
      collectionName: FireCollection.tinyBzz,
      documentName: bzID,
    );

    TinyBz _tinyBz = TinyBz.decipherTinyBzMap(_tinyBzMap);

    return _tinyBz;
  }
// ----------------------------------------------------------------------
}
