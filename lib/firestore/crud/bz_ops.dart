import 'dart:io';

import 'package:bldrs/controllers/drafters/file_formatters.dart';
import 'package:bldrs/controllers/drafters/imagers.dart';
import 'package:bldrs/firestore/auth/auth.dart';
import 'package:bldrs/models/bz_model.dart';
import 'package:bldrs/models/flyer_model.dart';
import 'package:bldrs/models/sub_models/author_model.dart';
import 'package:bldrs/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../firebase_storage.dart';
import '../firestore.dart';
import 'user_ops.dart';

/// create, read, update, delete bz doc in cloud firestore
class BzCRUD{
// ---------------------------------------------------------------------------
  /// bz firestore collection reference
  final CollectionReference _bzCollectionRef = getFirestoreCollectionReference(FireStoreCollection.bzz);
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
      getFirestoreDocumentReference(FireStoreCollection.bzz, bzID);
  }
// ----------------------------------------------------------------------
  /// create bz operations on firestore
  Future<BzModel> createBzOps(BuildContext context, BzModel inputBz, UserModel userModel) async {
    // Notes :-
    // inputBz has inputBz.bzLogo & inputBz.authors[0].authorPic as Files not URLs

    /// create empty firestore bz doc to get back _bzID
    DocumentReference _docRef = await createFireStoreDocument(
      context: context,
      collectionName: FireStoreCollection.bzz,
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
      collectionName: FireStoreCollection.bzz,
      documentName: _bzID,
      input: _outputBz.toMap(),
    );

    /// add new TinyBz in firestore
    await createFireStoreNamedDocument(
      context: context,
      collectionName: FireStoreCollection.tinyBzz,
      documentName: _bzID,
      input: (getTinyBzFromBzModel(_outputBz)).toMap(),
    );

    /// add bzID in user's myBzIDs
    List<dynamic> _userBzzIDs = userModel.myBzzIDs;
    _userBzzIDs.insert(0, _bzID);
    await updateFieldOnFirestore(
      context: context,
      collectionName: FireStoreCollection.users,
      documentName: userModel.userID,
      field: 'myBzzIDs',
      input: _userBzzIDs,
    );

    return _outputBz;
  }
// ----------------------------------------------------------------------
  /// update bz operations on firestore
  Future<void> updateBzOps({
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
    AuthorModel _modifiedAuthor = getAuthorFromBzByAuthorID(modifiedBz, superUserID());
    String _authorPicURL;
    if(authorPicFile == null) {
      // do Nothing, author pic was not changed, will keep as
    } else {

      String _authorID = superUserID();

      _authorPicURL = await savePicOnFirebaseStorageAndGetURL(
          context: context,
          inputFile: authorPicFile,
          fileName: _authorID,
          picType: PicType.userPic,
      );
    }

    /// update authorsList if authorPicChanged
    AuthorModel _finalAuthorModel = AuthorModel(
      userID : _modifiedAuthor.userID,
      authorName : _modifiedAuthor.authorName,
      authorPic : _authorPicURL ?? originalBz.bzAuthors[getAuthorIndexByAuthorID(originalBz.bzAuthors, _modifiedAuthor.userID)].authorPic,
      authorTitle : _modifiedAuthor.authorTitle,
      authorIsMaster : _modifiedAuthor.authorIsMaster,
      authorContacts : _modifiedAuthor.authorContacts,
    );
    List<AuthorModel> _finalAuthorList = replaceAuthorModelInAuthorsList(modifiedBz.bzAuthors, _finalAuthorModel);

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
      collectionName: FireStoreCollection.bzz,
      documentName: modifiedBz.bzID,
      input: _finalBz.toMap(),
    );

    /// only if TinyBz changed :-
    if(
    // bzID and BzLogo URL will always stay the same after creation
    _finalBz.bzName != originalBz.bzName ||
        _finalBz.bzType != originalBz.bzType
    ){
    TinyBz _modifiedTinyBz = getTinyBzFromBzModel(_finalBz)  ;
    Map<String, dynamic> _modifiedTinyBzMap = _modifiedTinyBz.toMap();

    /// update tinyBz document
    await replaceFirestoreDocument(
      context: context,
      collectionName: FireStoreCollection.tinyBzz,
      documentName: _finalBz.bzID,
      input: _modifiedTinyBzMap,
    );

    /// update tinyBz in all flyers
    /// TASK : this may require firestore batch write
      List<String> _bzFlyersIDs = getListOfFlyerIDsFromTinyFlyers(_finalBz.bzFlyers);
      if(_bzFlyersIDs.length > 0){
        for (var id in _bzFlyersIDs){
          await updateFieldOnFirestore(
            context: context,
            collectionName: FireStoreCollection.flyers,
            documentName: id,
            field: 'tinyBz',
            input: _modifiedTinyBzMap,
          );
        }
      }

    /// TASK : update tinyBz in all chats

    }

  }
// ----------------------------------------------------------------------
  Future<void> deleteBzDoc() async {}
// ----------------------------------------------------------------------
}
