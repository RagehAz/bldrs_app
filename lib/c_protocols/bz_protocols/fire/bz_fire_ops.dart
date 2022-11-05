import 'dart:io';

import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/b_bz/sub/author_model.dart';
import 'package:bldrs/a_models/x_secondary/feedback_model.dart';
import 'package:bldrs/a_models/x_secondary/record_model.dart';
import 'package:bldrs/b_views/z_components/dialogs/bottom_dialog/bottom_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/dialogz/dialogs.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/e_back_end/b_fire/foundation/fire.dart';
import 'package:bldrs/e_back_end/b_fire/foundation/paths.dart';
import 'package:bldrs/e_back_end/g_storage/storage.dart';
import 'package:bldrs/e_back_end/g_storage/storage_paths.dart';
import 'package:bldrs/c_protocols/auth_protocols/fire/auth_fire_ops.dart';
import 'package:bldrs/c_protocols/feedback_protocols/real/app_feedback_real_ops.dart';
import 'package:bldrs/f_helpers/drafters/stringers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:flutter/material.dart';

class BzFireOps {
  // -----------------------------------------------------------------------------

  const BzFireOps();

  // -----------------------------------------------------------------------------

  /// CREATE

  // --------------------
  /// TASK : RE-WRITE THIS
  static Future<BzModel> createBz({
    @required BzModel draftBz,
    @required UserModel userModel,
  }) async {

    // blog('createBz : START');
    //
    // BzModel _output;
    // bool _result;
    //
    // _result = await tryCatchAndReturnBool(
    //     methodName: 'createBz',
    //     functions: () async {
    //
    //       final String _bzID = await _createEmptyBzDocToGetBzID();
    //
    //       // final String _bzLogoURL = await _uploadBzLogoAndGetURL(
    //       //   logo: draftBz.logo,
    //       //   bzID: _bzID,
    //       //   bzCreatorID: userModel.id,
    //       // );
    //
    //       /// update authorModel with _authorPicURL
    //       final AuthorModel _createAuthor = await _uploadAuthorPicAndCreateNewCreatorAuthor(
    //         draftBz: draftBz,
    //         userModel: userModel,
    //         bzID: _bzID,
    //       );
    //
    //       await _addBzIDToUserBzzIDs(
    //         userModel: userModel,
    //         bzID: _bzID,
    //       );
    //
    //       final BzModel _finalBzModel = draftBz.copyWith(
    //         id: _bzID,
    //         createdAt: DateTime.now(),
    //         logo: _bzLogoURL,
    //         authors: <AuthorModel>[_createAuthor],
    //       );
    //
    //       await _updateBzDoc(
    //         finalBzModel: _finalBzModel,
    //       );
    //
    //       _output = _finalBzModel;
    //
    //     },
    //     onError: (String error){
    //       blog('the create bz error is : $error');
    //       _result = false;
    //     }
    // );
    //
    // blog('createBz : END');
    //
    // return _result == true ? _output : null;
  }
  // --------------------
  /// TASK : RE-CONSIDER THIS
  /*
  ///
  static Future<String> _createEmptyBzDocToGetBzID() async {

    blog('_createEmptyBzDocToGetBzID : START');

    final DocumentReference<Object> _docRef = await Fire.createDoc(
      collName: FireColl.bzz,
      addDocID: true,
      input: <String, dynamic>{},
    );

    blog('_createEmptyBzDocToGetBzID : END');

    return _docRef?.id;
  }
   */
  // --------------------
  /// DEPRECATED
  /*
  ///
  static Future<String> _uploadBzLogoAndGetURL({
    @required dynamic logo,
    @required String bzID,
    @required String bzCreatorID,
  }) async {

    blog('_uploadBzLogoAndGetURL : START');

    String _bzLogoURL;

    /// IF ITS A FILE : UPLOAD
    if (logo != null && ObjectCheck.objectIsFile(logo) == true) {

      _bzLogoURL = await Storage.createStoragePicAndGetURL(
        inputFile: logo,
        docName: bzID,
        collName: StorageColl.logos,
        ownersIDs: <String>[bzCreatorID],
      );

    }

    /// IF ITS A URL : CREATE FILE TO COPY IMAGE THEN UPLOAD
    else if (ObjectCheck.isAbsoluteURL(logo) == true){

      final File _fileFromURL = await StorageFileOps.downloadFileByURL(
        url: logo,
      );


      _bzLogoURL = await Storage.createStoragePicAndGetURL(
        inputFile: _fileFromURL,
        docName: bzID,
        collName: StorageColl.logos,
        ownersIDs: <String>[bzCreatorID],
      );

      blog('_bzLogoURL : used old logo : $_bzLogoURL');
    }

    blog('_uploadBzLogoAndGetURL : END');

    return _bzLogoURL;
  }
   */
  // --------------------
  /// DEPRECATED
  /*
  static Future<AuthorModel> _uploadAuthorPicAndCreateNewCreatorAuthor({
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
        ObjectCheck.isAbsoluteURL(draftBz.authors[0].pic) == true
    ){
      _authorPicURL = userModel.pic;
    }

    else {

      _authorPicURL = await Storage.createStoragePicAndGetURL(
        inputFile: draftBz.authors[0].pic,
        collName: StorageColl.authors,
        ownersIDs: <String>[userModel.id],
        docName: AuthorModel.generateAuthorPicID(
          authorID: userModel.id,
          bzID: bzID,
        ),
      );

    }


    final AuthorModel _creatorAuthor = AuthorModel(
      userID: userModel.id,
      name: userModel.name,
      title: userModel.title,
      pic: _authorPicURL,
      role: AuthorRole.creator,
      contacts: userModel.contacts,
      flyersIDs: const <String>[],
    );

    blog('_uploadAuthorPicAndReturnMasterAuthor : END');

    return _creatorAuthor;
  }
   */
  // --------------------
  ///
  static Future<void> _addBzIDToUserBzzIDs({
    @required UserModel userModel,
    @required String bzID,
  }) async {

    blog('_addBzIDToUserBzzIDs : START');

    final List<dynamic> _userBzzIDs = Stringer.addStringToListIfDoesNotContainIt(
      strings: userModel.myBzzIDs,
      stringToAdd: bzID,
    );

    await Fire.updateDocField(
      collName: FireColl.users,
      docName: userModel.id,
      field: 'myBzzIDs',
      input: _userBzzIDs,
    );

    blog('_addBzIDToUserBzzIDs : END');

  }
  // -----------------------------------------------------------------------------

  /// READ

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<BzModel> readBz({
    @required String bzID,
  }) async {

    final dynamic _bzMap = await Fire.readDoc(
      collName: FireColl.bzz,
      docName: bzID,
    );

    final BzModel _bz = BzModel.decipherBz(
      map: _bzMap,
      fromJSON: false,
    );

    return _bz;
  }
  // --------------------
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
    for (final String id in userModel.myBzzIDs) {

      final BzModel _bz = await readBz(bzID: id);

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

  // --------------------
  ///
  static Future<BzModel> updateBz({
    @required BuildContext context,
    @required BzModel newBzModel,
    @required BzModel oldBzModel,
    @required File authorPicFile,
  }) async {

    BzModel _output = oldBzModel;

    blog('updateBz : START');

    if (newBzModel != null && oldBzModel != null){

      final bool _areTheSame = BzModel.checkBzzAreIdentical(
        bz1: newBzModel,
        bz2: oldBzModel,
      );

      if (_areTheSame == false){

        // final BzModel _updatedBzModel = await _updateBzLogoIfChangedAndReturnNewBzModel(
        //   newBzModel: newBzModel,
        //   oldBzModel: oldBzModel,
        // );
        //
        // final BzModel _finalBzModel = await updateAuthorPicIfChangedAndReturnNewBzModel(
        //   context: context,
        //   bzModel: _updatedBzModel,
        // );

        await _updateBzDoc(
          finalBzModel: newBzModel,
        );

        _output = newBzModel;

      }

    }

    blog('updateBz : END');

    return _output;
  }
  // --------------------
  /*
  ///
  static Future<BzModel> _updateBzLogoIfChangedAndReturnNewBzModel({
    @required BzModel newBzModel,
    @required BzModel oldBzModel,
  }) async {

    String _bzLogoURL = newBzModel.logo;

    blog('_updateBzLogoIfChangedAndUpdatedBzModel : START');


    if (newBzModel?.logo != null){

      /// IF NEW LOGO IS URL
      if (ObjectCheck.isAbsoluteURL(newBzModel?.logo) == true) {

        /// IF URL IS CHANGED
        if (newBzModel?.logo != oldBzModel.logo){
          _bzLogoURL = newBzModel?.logo;
        }

      }

      /// IF NEW LOGO IS FILE
      else if (ObjectCheck.objectIsFile(newBzModel?.logo) == true){

        _bzLogoURL = await Storage.updateExistingPic(
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
   */
  // --------------------
  /*
  ///
  static Future<BzModel> updateAuthorPicIfChangedAndReturnNewBzModel({
    @required BuildContext context,
    @required BzModel bzModel,
  }) async {

    BzModel _finalBz = bzModel;

    blog('_updateAuthorPicIfChangedAndUpdateBzModel : START');

    final AuthorModel _authorWithImageFile = AuthorModel.getAuthorWhosePicIsFile(
      authors: bzModel.authors,
    );

    if (_authorWithImageFile != null){

      final String _picName = AuthorModel.generateAuthorPicID(
        authorID: _authorWithImageFile.userID,
        bzID: bzModel.id,
      );

      final List<String> _picOwnersIDs = AuthorModel.getAuthorPicOwnersIDs(
        bzModel: bzModel,
        authorModel: _authorWithImageFile,
      );

      final String _authorPicURL = await Storage.createStoragePicAndGetURL(
        inputFile: _authorWithImageFile.pic,
        collName: StorageColl.authors,
        docName: _picName,
        ownersIDs: _picOwnersIDs,
      );

      final AuthorModel _updatedAuthor = _authorWithImageFile.copyWith(
        pic: _authorPicURL,
      );

      final List<AuthorModel> _finalAuthorsList = AuthorModel.replaceAuthorModelInAuthorsListByID(
        authors: bzModel.authors,
        authorToReplace: _updatedAuthor,
      );

      // for (final AuthorModel author in _finalAuthorsList){
      //   blog('author ${author.userID} : pic : ${author.pic}');
      // }
      // blog('_authorPicURL : $_authorPicURL');
      // blog('_updatedAuthor pic : ${_updatedAuthor.pic}');

      _finalBz = bzModel.copyWith(
        authors: _finalAuthorsList,
      );

    }

    blog('_updateAuthorPicIfChangedAndUpdateBzModel : END');

    return _finalBz;
  }
   */
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> _updateBzDoc({
    @required BzModel finalBzModel,
  }) async {

    blog('_updateBzDoc : START');

    if (finalBzModel != null){

      await Fire.updateDoc(
        collName: FireColl.bzz,
        docName: finalBzModel.id,
        input: finalBzModel.toMap(toJSON: false),
      );

    }

    blog('_updateBzDoc : END');

  }
  // -----------------------------------------------------------------------------

  /// DELETE BZ

  // --------------------
  ///
  static Future<void> deleteBzOps({
    @required BzModel bzModel,
  }) async {

    blog('deleteBzOps : START');

    /// TASK : PIC SHOULD HAVE MULTIPLE OWNERS FROM MASTER OWNERS
    /// TASK : SHOULD NOT PROCEED IF THE LOGO IS THE USER PIC OF ANY MASTER AUTHOR
    await _deleteBzStorageLogo(
      bzModel: bzModel,
    );

    await _deleteBzDoc(
      bzModel: bzModel,
    );

    /// NOTE : SENDS BZ ACCOUNT DELETION NOTE TO ALL AUTHORS
    /// NOTE : EACH AUTHOR AUTO FIRES "AuthorProtocols.authorBzExitAfterBzDeletionProtocol" WHEN RECEIVING THE NOTE
    // await _deleteBzAuthorsPictures(
    //   context: context,
    //   bzModel: bzModel,
    // );
    // await _deleteBzIDFromAuthorBzIDs(
    //   context: context,
    //   bzModel: bzModel,
    // );

    blog('deleteBzOps : END');
  }
  // --------------------
  ///
  static Future<void> _deleteBzStorageLogo({
    @required BzModel bzModel,
  }) async {

    blog('_deleteBzStorageLogo : START');

    if (bzModel != null){

      await Storage.deleteStoragePic(
        docName: bzModel.id,
        collName: StorageColl.logos,
      );

    }

    blog('_deleteBzStorageLogo : END');

  }
  // --------------------
  ///
  static Future<void> _deleteBzDoc({
    @required BzModel bzModel,
  }) async {

    blog('_deleteBzDoc : START');

    if (bzModel != null){

      await Fire.deleteDoc(
        collName: FireColl.bzz,
        docName: bzModel.id,
      );

    }

    blog('_deleteBzDoc : END');

  }
  // -----------------------------------------------------------------------------

  /// DELETE AUTHOR

  // --------------------
  ///
  static Future<void> deleteAuthorPic({
    @required AuthorModel authorModel,
    @required String bzID,
  }) async {

    await Storage.deleteStoragePic(
      collName: StorageColl.authors,
      docName: AuthorModel.generateAuthorPicID(
        authorID: authorModel.userID,
        bzID: bzID,
      ),
    );

  }
  // -----------------------------------------------------------------------------

  /// REPORT BZ

  // --------------------
  ///
  static Future<void> reportBz({
    @required BuildContext context,
    @required BzModel bzModel,
  }) async {

    String _feedback;

    await BottomDialog.showButtonsBottomDialog(
        context: context,
        draggable: true,
        numberOfWidgets: 3,
        titleVerse: const Verse(
          text: 'phid_report_bz_account',
          translate: true,
        ),
        builder: (_){

          return <Widget>[

            /// INAPPROPRIATE CONTENT
            BottomDialog.wideButton(
                context: context,
                verse: const Verse(
                  pseudo: 'This Account published Inappropriate content',
                  text: 'phid_account_published_inapp_content',
                  translate: true,
                ),
                onTap: () async {
                  _feedback = 'This Account published Inappropriate content';
                  await Nav.goBack(
                    context: context,
                    invoker: 'reportBz.Inappropriate',
                  );
                }
            ),

            /// COPY RIGHTS
            BottomDialog.wideButton(
                context: context,
                verse: const Verse(
                  pseudo: 'This Account violates copyrights',
                  text: 'phid_account_published_copyright_violation',
                  translate: true,
                ),
                onTap: () async {
                  _feedback = 'This Account violates copyrights';
                  await Nav.goBack(
                    context: context,
                    invoker: 'reportBz.copyrights',
                  );
                }
            ),

          ];

        }
    );

    if (_feedback != null){
      final FeedbackModel _model =  FeedbackModel(
        userID: AuthFireOps.superUserID(),
        timeStamp: DateTime.now(),
        feedback: _feedback,
        modelType: ModelType.bz,
        modelID: bzModel.id,
      );


      final FeedbackModel _docRef = await FeedbackRealOps.createFeedback(
        feedback: _model,
      );

      if (_docRef != null){

        await Dialogs.weWillLookIntoItNotice(context);

      }

    }



  }
  // -----------------------------------------------------------------------------
}
