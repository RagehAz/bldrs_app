import 'dart:async';

import 'package:basics/helpers/classes/checks/tracers.dart';
import 'package:basics/helpers/classes/maps/lister.dart';
import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/b_bz/sub/author_model.dart';
import 'package:bldrs/a_models/e_notes/aa_note_parties_model.dart';
import 'package:bldrs/z_components/dialogs/wait_dialog/wait_dialog.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/auth_protocols/account_ldb_ops.dart';
import 'package:bldrs/c_protocols/authorship_protocols/f_new_authorship_exit.dart';
import 'package:bldrs/c_protocols/bz_protocols/protocols/a_bz_protocols.dart';
import 'package:bldrs/c_protocols/bz_protocols/provider/bzz_provider.dart';
import 'package:bldrs/c_protocols/census_protocols/census_listeners.dart';
import 'package:bldrs/c_protocols/flyer_protocols/ldb/flyer_ldb_ops.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs/c_protocols/note_protocols/protocols/a_note_protocols.dart';
import 'package:bldrs/c_protocols/pic_protocols/protocols/pic_protocols.dart';
import 'package:bldrs/c_protocols/user_protocols/fire/user_fire_ops.dart';
import 'package:bldrs/c_protocols/user_protocols/ldb/user_ldb_ops.dart';
import 'package:bldrs/c_protocols/user_protocols/user/user_provider.dart';
import 'package:flutter/material.dart';
/// => TAMAM
class WipeUserProtocols {
  // -----------------------------------------------------------------------------

  const WipeUserProtocols();

  // -----------------------------------------------------------------------------

  /// WIPE USER

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> wipeMyUser({
    required BuildContext context,
    required bool showWaitDialog,
  }) async {

    blog('WipeUserProtocols.wipeMyUserModel : START');

    /// START WAITING : DIALOG IS CLOSED INSIDE BELOW DELETION OPS
    if (showWaitDialog == true){
      WaitDialog.showUnawaitedWaitDialog(
        verse: const Verse(
          id: 'phid_deleting_your_account',
          translate: true,
        ),
      );
    }

    final UserModel? _userModel = UsersProvider.proGetMyUserModel(
      context: context,
      listen: false,
    );

    final bool _imAuthor = UserModel.checkUserIsAuthor(_userModel);

    /// WHEN USER IS AUTHOR
    if (_imAuthor == true){

      await _deleteAuthorUserProtocol(
        userModel: _userModel,
      );

    }

    /// WHEN USER IS NOT AUTHOR
    else {

      await _deleteNonAuthorUserProtocol(
        userModel: _userModel,
      );

    }

    blog('WipeUserProtocols.wipeMyUserModel : should close wait dialog');

    /// CLOSE WAITING
    if (showWaitDialog == true){
      await WaitDialog.closeWaitDialog();
    }

    blog('WipeUserProtocols.wipeMyUserModel : END');

  }
  // -----------------------------------------------------------------------------

  /// AUTHOR USER

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> _deleteAuthorUserProtocol({
    required UserModel? userModel,
  }) async {

    blog('UserProtocol._deleteAuthorUserProtocol : START');

    await Future.wait(<Future>[

      /// BZZ I CREATED
      _deleteBzzICreatedProtocol(
        userModel: userModel,
      ),

      /// BZZ I DID NOT CREATE
      _exitBzzIDidNotCreateProtocol(
        userModel: userModel,
      ),

    ]);

    /// DELETE EVERYTHING AS IF I'M NOT AUTHOR
    // should be last to allow security rules do the previous ops
    await _deleteNonAuthorUserProtocol(
      userModel: userModel,
    );

    blog('UserProtocol._deleteAuthorUserProtocol : END');

  }
  // --------------------
  /// DEPRECATED
  /*
  static Future<void> _deleteAllMyAuthorPics({
    required BuildContext context,
    required UserModel userModel,
  }) async {

    blog('UserProtocol.deleteAllMyAuthorPics : START');

    final List<String> _bzzIDs = userModel.myBzzIDs;

    if (Lister.checkCanLoop(_bzzIDs) == true){

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
   */
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> _deleteBzzICreatedProtocol({
    required UserModel? userModel,
  }) async {

    blog('UserProtocol.deleteBzzICreatedProtocol : START');

    final List<BzModel> _myBzzModels = BzzProvider.proGetMyBzz(
      context: getMainContext(),
      listen: false,
    );

    final List<BzModel> _myBzzICreated = BzModel.getBzzByCreatorID(
      bzzModels: _myBzzModels,
      creatorID: userModel?.id,
    );

    if (Lister.checkCanLoop(_myBzzICreated) == true){

      await Future.wait(<Future>[

        ...List.generate(_myBzzICreated.length, (index){

          return BzProtocols.wipeBz(
              context: getMainContext(),
              bzModel: _myBzzICreated[index],
              showWaitDialog: true,
              // includeMyselfInBzDeletionNote: true,
              // deleteBzLocally: true
          );

        }),

      ]);

    }

    blog('UserProtocol.deleteBzzICreatedProtocol : END');

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> _exitBzzIDidNotCreateProtocol({
    required UserModel? userModel,
  }) async {

    blog('UserProtocol.exitBzzIDidNotCreateProtocol : START');

    final List<BzModel> _myBzzModels = BzzProvider.proGetMyBzz(
      context: getMainContext(),
      listen: false,
    );

    final List<BzModel> _myBzzIDidNotCreate = BzModel.getBzzIDidNotCreate(
      bzzModels: _myBzzModels,
      userID: userModel?.id,
    );

    if (Lister.checkCanLoop(_myBzzIDidNotCreate) == true){

      await Future.wait(<Future>[

        ...List.generate(_myBzzIDidNotCreate.length, (index){

          final BzModel _oldBz = _myBzzIDidNotCreate[index];

          final AuthorModel? _authorModel = AuthorModel.getAuthorFromBzByAuthorID(
            bz: _oldBz,
            authorID: userModel?.id,
          );

          return NewAuthorshipExit.onRemoveMyselfWhileDeletingMyUserAccount(
            bzModel: _oldBz,
            authorModel: _authorModel,
          );

        }),

      ]);

    }

    blog('UserProtocol.exitBzzIDidNotCreateProtocol : END');

  }
  // -----------------------------------------------------------------------------

  /// NON AUTHOR USER

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> _deleteNonAuthorUserProtocol({
    required UserModel? userModel,
  }) async {

    blog('UserProtocol._deleteNonAuthorUserProtocol : START');

    await Future.wait(<Future>[

      /// WIPE NOTES
      NoteProtocols.wipeAllNotes(
        partyType: PartyType.user,
        id: userModel?.id,
      ),

      /// WIPE USER PIC
      PicProtocols.wipePic(userModel?.picPath),

      // TASK : SHOULD WIPE USER SEARCHES
      // UserRecordRealOps.deleteAllUserRecords(
      //   userID: userModel.id,
      // ),

      /// UPDATE USER CENSUS
      CensusListener.onWipeUser(userModel),

    ]);

    blog('UserProtocol._deleteNonAuthorUserProtocol : MIDDLE');

    await Future.wait(<Future>[

      /// DELETE USER : SHOULD BE LAST TO ALLOW SECURITY RULES DO THE PREVIOUS OPS
      UserFireOps.deleteMyUser(),

      _deleteMyUserLocallyProtocol(
          userModel: userModel
      ),

    ]);


    blog('UserProtocol._deleteNonAuthorUserProtocol : ENDDDDD');

  }
  // -----------------------------------------------------------------------------

  /// LOCAL DELETE

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> _deleteMyUserLocallyProtocol({
    required UserModel? userModel,
  }) async {

    blog('UserProtocol._deleteMyUserLocallyProtocol : START');

    await Future.wait(<Future>[

      /// LDB : DELETE USER MODEL
      UserLDBOps.deleteUserOps(userModel?.id),

      /// LDB : DELETE SAVED FLYERS
      FlyerLDBOps.deleteFlyers(userModel?.savedFlyers?.all),

      /// DELETE ACCOUNT MODEL
      AccountLDBOps.deleteAccount(id: userModel?.id),

      /// WILL KEEP USER SEARCHES TO

    ]);

    blog('UserProtocol._deleteMyUserLocallyProtocol : END');

  }
  // -----------------------------------------------------------------------------
}
