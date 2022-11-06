import 'dart:async';
import 'package:bldrs/a_models/b_bz/sub/author_model.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/a_models/e_notes/aa_note_parties_model.dart';
import 'package:bldrs/b_views/z_components/dialogs/wait_dialog/wait_dialog.dart';
import 'package:bldrs/b_views/f_bz/a_bz_profile_screen/x3_bz_authors_page_controllers.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/authorship_protocols/a_authorship_protocols.dart';
import 'package:bldrs/c_protocols/bz_protocols/protocols/a_bz_protocols.dart';
import 'package:bldrs/c_protocols/note_protocols/protocols/a_note_protocols.dart';
import 'package:bldrs/c_protocols/bz_protocols/provider/bzz_provider.dart';
import 'package:bldrs/c_protocols/pic_protocols/protocols/pic_protocols.dart';
import 'package:bldrs/c_protocols/user_protocols/real/user_record_real_ops.dart';
import 'package:bldrs/c_protocols/user_protocols/user/user_provider.dart';
import 'package:bldrs/c_protocols/user_protocols/fire/user_fire_ops.dart';
import 'package:bldrs/c_protocols/auth_protocols/ldb/auth_ldb_ops.dart';
import 'package:bldrs/c_protocols/flyer_protocols/ldb/flyer_ldb_ops.dart';
import 'package:bldrs/c_protocols/user_protocols/ldb/user_ldb_ops.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:flutter/material.dart';

class WipeUserProtocols {
  // -----------------------------------------------------------------------------

  const WipeUserProtocols();

  // -----------------------------------------------------------------------------

  /// WIPE USER

  // --------------------
  ///
  static Future<void> wipeMyUser({
    @required BuildContext context,
    @required bool showWaitDialog,
  }) async {

    blog('WipeUserProtocols.wipeMyUserModel : START');

    /// START WAITING : DIALOG IS CLOSED INSIDE BELOW DELETION OPS
    if (showWaitDialog == true){
      unawaited(WaitDialog.showWaitDialog(
        context: context,
        loadingVerse: const Verse(
          text: 'phid_deleting_your_account',
          translate: true,
        ),
      ));
    }

    final UserModel _userModel = UsersProvider.proGetMyUserModel(
      context: context,
      listen: false,
    );

    final bool _imAuthor = UserModel.checkUserIsAuthor(_userModel);

    /// WHEN USER IS AUTHOR
    if (_imAuthor == true){

      await _deleteAuthorUserProtocol(
        context: context,
        userModel: _userModel,
      );

    }

    /// WHEN USER IS NOT AUTHOR
    else {

      await _deleteNonAuthorUserProtocol(
        context: context,
        userModel: _userModel,
      );

    }

    /// CLOSE WAITING
    if (showWaitDialog == true){
      await WaitDialog.closeWaitDialog(context);
    }

    blog('WipeUserProtocols.wipeMyUserModel : END');

  }
  // -----------------------------------------------------------------------------

  /// NON AUTHOR USER

  // --------------------
  ///
  static Future<void> _deleteNonAuthorUserProtocol({
    @required BuildContext context,
    @required UserModel userModel,
  }) async {

    blog('UserProtocol._deleteNonAuthorUserProtocol : START');

    await Future.wait(<Future>[

      /// WIPE NOTES
      NoteProtocols.wipeAllNotes(
        partyType: PartyType.user,
        id: userModel.id,
      ),

      /// WIPE USER PIC
      PicProtocols.wipePic(userModel.picPath),

      /// DELETE USER
      UserFireOps.deleteMyUser(context),

      /// DELETE SEARCHES
      UserRecordRealOps.deleteAllUserRecords(
          userID: userModel.id,
      ),

    ]);

    await _deleteMyUserLocallyProtocol(
        context: context,
        userModel: userModel
    );

    blog('UserProtocol._deleteNonAuthorUserProtocol : END');

  }
  // -----------------------------------------------------------------------------

  /// AUTHOR USER

  // --------------------
  ///
  static Future<void> _deleteAuthorUserProtocol({
    @required BuildContext context,
    @required UserModel userModel,
  }) async {

    blog('UserProtocol._deleteAuthorUserProtocol : START');

    await Future.wait(<Future>[

      /// ALL AUTHORS PICS
      _deleteAllMyAuthorPics(
        context: context,
        userModel: userModel,
      ),

      /// BZZ I CREATED
      _deleteBzzICreatedProtocol(
        context: context,
        userModel: userModel,
      ),

      /// BZZ I DID NOT CREATE
      _exitBzzIDidNotCreateProtocol(
        context: context,
        userModel: userModel,
      ),

      /// DELETE EVERYTHING AS IF I'M NOT AUTHOR
      _deleteNonAuthorUserProtocol(
        context: context,
        userModel: userModel,
      ),

    ]);


    blog('UserProtocol._deleteAuthorUserProtocol : END');

  }
  // --------------------
  ///
  static Future<void> _deleteAllMyAuthorPics({
    @required BuildContext context,
    @required UserModel userModel,
  }) async {

    blog('UserProtocol.deleteAllMyAuthorPics : START');

    final List<String> _bzzIDs = userModel.myBzzIDs;

    if (Mapper.checkCanLoopList(_bzzIDs) == true){

      await Future.wait(<Future>[

        ...List.generate(_bzzIDs.length, (index){

          return AuthorshipProtocols.deleteMyAuthorPic(
            context: context,
            bzID: _bzzIDs[index],
          );

      }),

    ]);



    }

    blog('UserProtocol.deleteAllMyAuthorPics : END');

  }
  // --------------------
  ///
  static Future<void> _deleteBzzICreatedProtocol({
    @required BuildContext context,
    @required UserModel userModel,
  }) async {

    blog('UserProtocol.deleteBzzICreatedProtocol : START');

    final List<BzModel> _myBzzModels = BzzProvider.proGetMyBzz(
      context: context,
      listen: false,
    );

    final List<BzModel> _myBzzICreated = BzModel.getBzzByCreatorID(
      bzzModels: _myBzzModels,
      creatorID: userModel.id,
    );

    if (Mapper.checkCanLoopList(_myBzzICreated) == true){

      await Future.wait(<Future>[

        ...List.generate(_myBzzICreated.length, (index){

          return BzProtocols.wipeBz(
              context: context,
              bzModel: _myBzzICreated[index],
              showWaitDialog: true,
              includeMyselfInBzDeletionNote: false,
              deleteBzLocally: true
          );

        }),

      ]);

    }

    blog('UserProtocol.deleteBzzICreatedProtocol : END');

  }
  // --------------------
  ///
  static Future<void> _exitBzzIDidNotCreateProtocol({
    @required BuildContext context,
    @required UserModel userModel,
  }) async {

    blog('UserProtocol.exitBzzIDidNotCreateProtocol : START');

    final List<BzModel> _myBzzModels = BzzProvider.proGetMyBzz(
      context: context,
      listen: false,
    );

    final List<BzModel> _myBzzIDidNotCreate = BzModel.getBzzIDidNotCreate(
      bzzModels: _myBzzModels,
      userID: userModel.id,
    );

    if (Mapper.checkCanLoopList(_myBzzIDidNotCreate) == true){

      await Future.wait(<Future>[

        ...List.generate(_myBzzIDidNotCreate.length, (index){

          final BzModel _bzModel = _myBzzIDidNotCreate[index];

          final AuthorModel _authorModel = AuthorModel.getAuthorFromBzByAuthorID(
            bz: _bzModel,
            authorID: userModel.id,
          );

          /// TASK => SHOULD REWRITE THE BZ EXIT PROTOCOL
          return onDeleteAuthorFromBz(
            context: context,
            bzModel: _bzModel,
            authorModel: _authorModel,
            showWaitingDialog: false,
            showConfirmationDialog: false,
            sendToUserAuthorExitNote: false,
          ).then((value) => NoteProtocols.unsubscribeFromAllBzTopics(
            context: context,
            bzID: _bzModel.id,
            renovateUser: true,
          ));

        }),

      ]);

    }

    blog('UserProtocol.exitBzzIDidNotCreateProtocol : END');

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> _deleteMyUserLocallyProtocol({
    @required BuildContext context,
    @required UserModel userModel,
  }) async {

    blog('UserProtocol._deleteMyUserLocallyProtocol : START');

    /// LDB : DELETE USER MODEL
    await UserLDBOps.deleteUserOps(userModel.id);
    await AuthLDBOps.deleteAuthModel(userModel.id);

    /// LDB : DELETE SAVED FLYERS
    await FlyerLDBOps.deleteFlyers(userModel.savedFlyersIDs);

    blog('UserProtocol._deleteMyUserLocallyProtocol : END');

  }
  // -----------------------------------------------------------------------------
}
