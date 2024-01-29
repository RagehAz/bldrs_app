///
// import 'dart:async';
//
// import 'package:bldrs/a_models/b_bz/sub/author_model.dart';
// import 'package:bldrs/a_models/b_bz/bz_model.dart';
// import 'package:bldrs/a_models/a_user/user_model.dart';
// import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
// import 'package:bldrs/g_flyer/z_components/c_groups/grid/flyers_grid.dart';
// import 'package:bldrs/z_components/dialogs/center_dialog/center_dialog.dart';
// import 'package:bldrs/z_components/dialogs/dialogz/dialogs.dart';
// import 'package:bldrs/z_components/dialogs/top_dialog/top_dialog.dart';
// import 'package:bldrs/z_components/dialogs/wait_dialog/wait_dialog.dart';
// import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
// import 'package:bldrs/c_protocols/bz_protocols/protocols/a_bz_protocols.dart';
// import 'package:bldrs/c_protocols/flyer_protocols/protocols/a_flyer_protocols.dart';
// import 'package:bldrs/c_protocols/note_protocols/note_events/z_note_events.dart';
// import 'package:bldrs/c_protocols/note_protocols/protocols/a_note_protocols.dart';
// import 'package:bldrs/c_protocols/pic_protocols/protocols/pic_protocols.dart';
// import 'package:bldrs/c_protocols/user_protocols/protocols/a_user_protocols.dart';
// import 'package:bldrs/c_protocols/bz_protocols/provider/bzz_provider.dart';
// import 'package:bldrs/c_protocols/note_protocols/provider/notes_provider.dart';
// import 'package:bldrs/c_protocols/user_protocols/user/user_provider.dart';
// import 'package:bldrs/c_protocols/auth_protocols/fire/auth_fire_ops.dart';
// import 'package:bldrs/c_protocols/bz_protocols/ldb/bz_ldb_ops.dart';
// import 'package:bldrs/e_back_end/g_storage/storage.dart';
// import 'package:bldrs/main.dart';
// 
// import 'package:basics/helpers/strings/stringer.dart';
// import 'package:basics/helpers/files/filers.dart';
// import 'package:flutter/material.dart';
//
// class OldAuthorshipExit {
//   // -----------------------------------------------------------------------------
//
//   const OldAuthorshipExit();
//
//   // -----------------------------------------------------------------------------
//   /// TESTED : WORKS PERFECT
//   static Future<void> deleteMyAuthorPic({
//     required BuildContext context,
//     required String bzID,
//   }) async {
//     blog('WipeAuthorProtocols.deleteMyAuthorPicProtocol : START');
//
//     /// WIPE AUTHOR PIC
//     await PicProtocols.wipePic(BldrStorage.generateAuthorPicPath(
//       bzID: bzID,
//       authorID: Authing.getUserID(),
//     ));
//
//     // /// GET MY USER MODEL -------------------
//     // final UserModel _myUserModel = await UserProtocols.fetch(
//     //   context: context,
//     //   userID: Authing.getUserID(),
//     // );
//     //
//     // /// GET THE BZ MODEL -------------------
//     // final BzModel _bzModel = await BzLDBOps.readBz(bzID);
//     //
//     // if (_bzModel != null){
//     //
//     //   /// GET MY AUTHOR MODEL -------------------
//     //   final AuthorModel _myAuthor = AuthorModel.getAuthorFromAuthorsByID(
//     //     authors: _bzModel.authors,
//     //     authorID: _myUserModel.id,
//     //   );
//     //
//     //   /// CHECK IF USER MODEL PIC IS AUTHOR MODEL PIC -------------------
//     //   final bool _authorPicIsHisUserPic = await AuthorModel.checkUserImageIsAuthorImage(
//     //     context: context,
//     //     authorModel: _myAuthor,
//     //     userModel: _myUserModel,
//     //   );
//     //
//     //   /// PROCEED IF NOT IDENTICAL -------------------
//     //   if (_authorPicIsHisUserPic == false){
//     //     await BzFireOps.deleteAuthorPic(
//     //       authorModel: _myAuthor,
//     //       bzID: bzID,
//     //     );
//     //   }
//     //
//     // }
//
//     blog('WipeAuthorProtocols.deleteMyAuthorPicProtocol : END');
//   }
//   // --------------------
//   /// TESTED : WORKS PERFECT
//   static Future<void> removeMeFromBz({
//     required BuildContext context,
//     required BzModel streamedBzModelWithoutMyID,
//   }) async {
//
//     blog('WipeAuthorProtocols.removeMeFromBzProtocol : START');
//
//     // description
//     // when the streamedBzModel does not include my ID
//     // should update this bz in LDB
//     // remove this bz from my bzz ids
//     // update my model everywhere
//
//     /// REMOVE ME FROM PRO MY BZZ
//     BzzProvider.proRemoveBzFromMyBzz(
//       context: context,
//       bzID: streamedBzModelWithoutMyID.id,
//       notify: true,
//     );
//     /// UPDATE BZ IN LDB
//     await BzLDBOps.updateBzOps(
//       bzModel: streamedBzModelWithoutMyID,
//     );
//
//     /// MODIFY MY USER MODEL
//     final UserModel _oldUser = UsersProvider.proGetMyUserModel(
//       context: context,
//       listen: false,
//     );
//     UserModel _newUser = UserModel.removeBzIDFromUserBzzIDs(
//         bzIDToRemove: streamedBzModelWithoutMyID.id,
//         oldUser: _oldUser
//     );
//
//     _newUser = UserModel.removeAllBzTopicsFromMyTopics(
//         oldUser: _newUser,
//         bzID: streamedBzModelWithoutMyID.id,
//     );
//
//     /// WIPE AUTHOR PIC
//     await PicProtocols.wipePic(BldrStorage.generateAuthorPicPath(
//       bzID: streamedBzModelWithoutMyID.id,
//       authorID: _newUser.id,
//     ));
//
//     await Future.wait(<Future>[
//
//       /// UNSUBSCRIBE FROM FCM TOPICS
//       NoteProtocols.unsubscribeFromAllBzTopics(
//         bzID: streamedBzModelWithoutMyID.id,
//         context: context,
//         renovateUser: false,
//       ),
//
//       /// UPDATE MY USER MODEL EVERYWHERE
//       UserProtocols.renovate(
//         context: context,
//         newUser: _newUser,
//         oldUser: _oldUser,
//         newPic: null,
//       ),
//
//     ]);
//
//     /// 10 - REMOVE ALL NOTES FROM ALL-MY-BZZ-NOTES AND OBELISK NOTES NUMBERS
//     NotesProvider.proAuthorResignationNotesRemovalOps(
//       context: context,
//       bzIDResigned: streamedBzModelWithoutMyID.id,
//     );
//
//     blog('WipeAuthorProtocols.removeMeFromBzProtocol : END');
//   }
//   // --------------------
//   /// TESTED : WORKS PERFECT
//   static Future<void> removeFlyerlessAuthor({
//     required BuildContext context,
//     required BzModel oldBz,
//     required AuthorModel author,
//   }) async {
//     blog('WipeAuthorProtocols.removeFlyerlessAuthorProtocol : START');
//
//     /// REMOVE AUTHOR MODEL FROM BZ MODEL
//     final BzModel _newBz = BzModel.removeAuthor(
//       oldBz: oldBz,
//       authorID: author.userID,
//     );
//
//     await Future.wait(<Future>[
//
//       /// WIPE AUTHOR PIC
//       PicProtocols.wipePic(author.picPath),
//
//       /// UPDATE BZ ON FIREBASE
//       BzProtocols.renovateBz(
//         context: context,
//         newBz: _newBz,
//         oldBz: oldBz,
//         showWaitDialog: false,
//         navigateToBzInfoPageOnEnd: false,
//         newLogo: null,
//       ),
//
//     ]);
//
//     blog('WipeAuthorProtocols.removeFlyerlessAuthorProtocol : END');
//
//   }
//   // --------------------
//   /// TESTED : WORKS PERFECT
//   static Future<void> removeBzTracesAfterDeletion({
//     required BuildContext context,
//     required String bzID,
//   }) async {
//
//     /// NOTES
//     /// I RECEIVED A NOTE SAYING MY BZ HAS BEEN DELETED
//     /// SO BZ HAS ALREADY BEEN DELETED BUT I WAS AN AUTHOR AND STILL HAVE TRACES OF THAT BUSINESS
//     /// IN MY MODEL IN FIRE - LDB - PRO
//
//     blog('WipeAuthorProtocols.removeBzTracesAfterDeletion : start');
//
//     final UserModel _oldUser = UsersProvider.proGetMyUserModel(
//       context: context,
//       listen: false,
//     );
//
//     final bool _bzIDisInMyBzzIDs = Stringer.checkStringsContainString(
//       strings: _oldUser.myBzzIDs,
//       string: bzID,
//     );
//
//     if (_bzIDisInMyBzzIDs == true){
//
//       await _authorBzDeletionDialog(
//         context: context,
//         bzID: bzID,
//       );
//
//       /// MODIFY USER MODEL
//       UserModel _newUser = UserModel.removeBzIDFromUserBzzIDs(
//         bzIDToRemove: bzID,
//         oldUser: _oldUser,
//       );
//
//       _newUser = UserModel.removeAllBzTopicsFromMyTopics(
//           oldUser: _newUser,
//           bzID: bzID
//       );
//
//       await Future.wait(<Future>[
//
//         /// FCM UN-SUBSCRIBE FROM ALL BZ TOPICS
//         NoteProtocols.unsubscribeFromAllBzTopics(
//           bzID: bzID,
//           context: context,
//           renovateUser: false,
//         ),
//
//         /// UPDATE USER MODEL EVERYWHERE
//         UserProtocols.renovate(
//           context: context,
//           newUser: _newUser,
//           newPic: null,
//           oldUser: _oldUser,
//         ),
//
//         /// DELETE MY AUTHOR PICTURE FROM STORAGE
//         deleteMyAuthorPic(
//           context: context,
//           bzID: bzID,
//         ),
//
//         /// DELETE BZ LOCALLY
//         BzProtocols.deleteLocally(
//           context: context,
//           bzID: bzID,
//           invoker: 'authorBzExitAfterBzDeletionProtocol',
//         )
//
//       ]);
//
//     }
//
//     blog('WipeAuthorProtocols.removeBzTracesAfterDeletion : end');
//
//   }
//   // --------------------
//   /// TESTED : WORKS PERFECT
//   static Future<void> _authorBzDeletionDialog({
//     required BuildContext context,
//     required String bzID,
//   }) async {
//
//     final BzModel _bzModel = await BzLDBOps.readBz(bzID);
//
//     if (_bzModel != null){
//
//       await Dialogs.bzBannerDialog(
//         context: context,
//         titleVerse: Verse(
//           text: _bzModel.name,
//           translate: false,
//         ),
//         bodyVerse: const Verse(
//           text: 'phid_bz_is_deleted_can_not_be_used',
//           translate: true,
//         ),
//         bzModel: _bzModel,
//         boolDialog: false,
//       );
//
//     }
//
//   }
//   // -----------------------------------------------------------------------------
//   Future<void> myBzResignationProtocol({
//     required BuildContext context,
//     required BzModel newBzFromStream,
//   }) async {
//     /// THIS METHOD RUNS WHEN STREAMED BZ MODEL DOES NOT INCLUDE MY USER ID
//     // description
//     // if bz model is updated and does not include me in its authors any more
//     // that means I have been deleted from the team
//     // so we need to clear the bz and all its related stuff as follows
//
//     /// 1 - CHECK IF I'M STILL IN THE TEAM
//     final bool _authorsContainMyUserID = AuthorModel.checkAuthorsContainUserID(
//       authors: newBzFromStream.authors,
//       userID: Authing.getUserID(),
//     );
//
//     /// 2 - WHEN I GOT REMOVED FROM THE BZ TEAM
//     if (_authorsContainMyUserID == false) {
//       /// 3 - SHOW NOTICE DIALOG
//       await CenterDialog.showCenterDialog(
//         context: context,
//         titleVerse: const Verse(
//           pseudo: 'This Business account is not available',
//           text: 'phid_bz_account_is_unavailable',
//           translate: true,
//         ),
//         bodyVerse: const Verse(
//           pseudo: 'Your account does not have access to this business account',
//           text: 'phid_no_access_to_this_account',
//           translate: true,
//         ),
//       );
//
//       await removeMeFromBz(
//           context: context, streamedBzModelWithoutMyID: newBzFromStream);
//
//       // /// 11 - GO BACK HOME
//       // await Nav.goBack(
//       //   context: context,
//       //   invoker: '_myBzResignationProtocol',
//       // );
//
//       /// 12 - CLEAR MY ACTIVE BZ
//       // _bzzProvider.clearMyActiveBz(
//       //     notify: false
//       // );
//       // _bzzProvider.clearActiveBzFlyers(
//       //     notify: true,
//       // );
//
//     }
//   }
//   // -----------------------------------------------------------------------------
//
//   /// DELETE AUTHOR WHO HAS NO FLYERS
//
//   // ----------------------------------
//   /// TESTED : WORKS PERFECT
//   Future<void> removeAuthorWhoHasNoFlyers({
//     required BuildContext context,
//     required AuthorModel authorModel,
//     required BzModel oldBz,
//     required bool showConfirmationDialog,
//     required bool showWaitDialog,
//     required bool sendToUserAuthorExitNote,
//   }) async {
//
//     /// REMOVE AUTHOR MODEL FROM BZ MODEL
//     await removeFlyerlessAuthor(
//       context: context,
//       oldBz: oldBz,
//       author: authorModel,
//     );
//
//     /// SEND AUTHOR DELETION NOTES
//     await NoteEvent.sendAuthorDeletionNotes(
//       context: context,
//       bzModel: oldBz,
//       deletedAuthor: authorModel,
//       sendToUserAuthorExitNote: sendToUserAuthorExitNote,
//     );
//
//     /// SHOW CONFIRMATION DIALOG
//     if (showConfirmationDialog == true){
//       await _showAuthorRemovalConfirmationDialog(
//         context: context,
//         bzModel: oldBz,
//         deletedAuthor: authorModel,
//       );
//     }
//
//   }
//   // --------------------
//   /// TESTED : WORKS PERFECT
//   Future<void> _showAuthorRemovalConfirmationDialog({
//     required BuildContext context,
//     required BzModel bzModel,
//     required AuthorModel deletedAuthor,
//   }) async {
//
//     unawaited(TopDialog.showTopDialog(
//       context: context,
//       firstVerse: const Verse(
//         text: 'phid_author_and_flyers_have_been_removed',
//         translate: true,
//       ),
//       color: Colorz.green255,
//       textColor: Colorz.white255,
//     ));
//
//   }
//   // -----------------------------------------------------------------------------
//
//   /// DELETE AUTHOR WHO HAS FLYERS
//
//   // --------------------
//   /// TESTED : WORKS PERFECT
//   Future<void> removeAuthorWhoHasFlyers({
//     required BuildContext context,
//     required AuthorModel authorModel,
//     required BzModel oldBz,
//     required bool showWaitDialog,
//     required bool showConfirmationDialog,
//     required bool sendToUserAuthorExitNote,
//   }) async {
//
//     bool _result;
//
//     if (showConfirmationDialog == true){
//       _result = await showDeleteAllAuthorFlyers(
//         context: context,
//         authorModel: authorModel,
//       );
//     }
//     else {
//       _result = true;
//     }
//
//     if (_result == true){
//
//       if (showWaitDialog == true){
//         pushWaitDialog(
//           context: context,
//           verse: Verse(
//             text: '${Verse.transBake('phid_removing')} ${authorModel.name}',
//             translate: false,
//           ),
//         );
//       }
//
//       /// DELETE ALL AUTHOR FLYERS EVERY WHERE THEN UPDATE BZ EVERYWHERE
//       final List<FlyerModel> _flyers = await FlyerProtocols.fetchFlyers(
//         context: context,
//         flyersIDs: authorModel.flyersIDs,
//       );
//
//
//       await FlyerProtocols.wipeFlyers(
//         context: context,
//         bzModel: oldBz,
//         showWaitDialog: false,
//         flyers: _flyers,
//         isDeletingBz: false,
//       );
//
//       /// AS WIPE FLYERS RENOVATES BZ,, WE NEED TO REFETCH
//       final BzModel _oldBz = await BzProtocols.refetch(
//           context: context,
//           bzID: oldBz.id,
//       );
//
//       /// REMOVE AUTHOR MODEL FROM BZ MODEL
//       final BzModel _newBz = BzModel.removeAuthor(
//         oldBz: _oldBz,
//         authorID: authorModel.userID,
//       );
//
//       /// UPDATE BZ ON FIREBASE
//       await BzProtocols.renovateBz(
//         context: context,
//         newBz: _newBz,
//         oldBz: _oldBz,
//         navigateToBzInfoPageOnEnd: false,
//         showWaitDialog: false,
//         newLogo: null,
//       );
//
//
//       /// SEND AUTHOR DELETION NOTES
//       await NoteEvent.sendAuthorDeletionNotes(
//         context: context,
//         bzModel: _newBz,
//         deletedAuthor: authorModel,
//         sendToUserAuthorExitNote: sendToUserAuthorExitNote,
//       );
//
//       if (showWaitDialog == true){
//         await WaitDialog.closeWaitDialog();
//       }
//
//       /// SHOW CONFIRMATION DIALOG
//       if (showConfirmationDialog == true){
//         await _showAuthorRemovalConfirmationDialog(
//           context: context,
//           bzModel: _newBz,
//           deletedAuthor: authorModel,
//         );
//       }
//
//     }
//
//   }
//   // --------------------
//   /// TESTED : WORKS PERFECT
//   Future<bool> showDeleteAllAuthorFlyers({
//     required BuildContext context,
//     required AuthorModel authorModel,
//   }) async {
//
//     final bool _result = await CenterDialog.showCenterDialog(
//       context: context,
//       titleVerse: const Verse(
//         text: 'phid_delete_all_flyers',
//         translate: true,
//       ),
//       bodyVerse: Verse(
//         text: '${authorModel.flyersIDs.length} ${Verse.transBake('flyers_will_be_permanently_deleted')}',
//         translate: false,
//       ),
//       height: 400,
//       boolDialog: true,
//       confirmButtonVerse: Verse(
//         text: '${Verse.transBake('delete_flyers_and_remove')} ${authorModel.name}',
//         translate: false,
//       ),
//       child: Container(
//         width: CenterDialog.getWidth(context),
//         height: 200,
//         color: Colorz.white10,
//         alignment: Alignment.center,
//         child: FlyersGrid(
//           scrollController: ScrollController(),
//           flyersIDs: authorModel.flyersIDs,
//           scrollDirection: Axis.horizontal,
//           gridWidth: CenterDialog.getWidth(context) - 10,
//           gridHeight: 200,
//           numberOfColumnsOrRows: 1,
//           screenName: 'showDeleteAllAuthorFlyersGrid',
//           isHeroicGrid: true,
//         ),
//       ),
//     );
//
//     return _result;
//   }
//   // -----------------------------------------------------------------------------
// }
