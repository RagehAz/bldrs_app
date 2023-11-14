import 'dart:async';

import 'package:basics/helpers/classes/checks/tracers.dart';
import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/b_bz/draft/draft_bz.dart';
import 'package:bldrs/a_models/i_pic/pic_model.dart';
import 'package:bldrs/b_views/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/wait_dialog/wait_dialog.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/bz_protocols/fire/bz_fire_ops.dart';
import 'package:bldrs/c_protocols/bz_protocols/ldb/bz_ldb_ops.dart';
import 'package:bldrs/c_protocols/bz_protocols/protocols/a_bz_protocols.dart';
import 'package:bldrs/c_protocols/bz_protocols/provider/bzz_provider.dart';
import 'package:bldrs/c_protocols/census_protocols/census_listeners.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs/c_protocols/note_protocols/protocols/a_note_protocols.dart';
import 'package:bldrs/c_protocols/pic_protocols/protocols/pic_protocols.dart';
import 'package:bldrs/c_protocols/user_protocols/protocols/a_user_protocols.dart';
import 'package:bldrs/c_protocols/user_protocols/user/user_provider.dart';
import 'package:bldrs/c_protocols/zone_protocols/staging_protocols/protocols/staging_leveller.dart';
import 'package:bldrs/e_back_end/g_storage/storage_path.dart';
import 'package:provider/provider.dart';

/// => TAMAM
class ComposeBzProtocols {
  // -----------------------------------------------------------------------------

  const ComposeBzProtocols();

  // -----------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  static Future<BzModel?> compose({
    required DraftBz? newDraft,
    required UserModel? userModel,
  }) async {
    BzModel? _bzModel;
    blog('ComposeBzProtocol.compose : START');

    // assert(newDraft.logoPicModel != null, 'logoPicModel is null');

    if (newDraft?.logoPicModel != null){

      /// WAIT DIALOG
      WaitDialog.showUnawaitedWaitDialog(
        verse: const Verse(
          id: 'phid_creating_new_bz_account',
          translate: true,
        ),
      );

      /// CREATE BZ ID
      final String? _bzID = await BzFireOps.createEmptyBzDocToGetBzID();
      assert(_bzID != null, 'bzID is null');

      /// OVERRIDE BZ ID
      final DraftBz? _draftWithID = DraftBz.overrideBzID(
        draft: newDraft,
        bzID: _bzID,
      );

      blog('the draft is');
      _draftWithID?.blogDraft();

      /// BAKE DRAFT TO INITIAL BZ
      _bzModel = DraftBz.toBzModel(_draftWithID);

      /// UPDATE MY USER MODEL
      await _addBzIdToMyUserModelAndRenovateAndSubscribeToAllBzTopics(
        bzID: _bzModel?.id,
      );

      /// OVERRIDE CREATION TIME
      _bzModel = _bzModel?.copyWith(
        createdAt: DateTime.now(),
      );

      /// UPLOAD
      await Future.wait(<Future>[

        /// UPDATE BZ DOC
        BzFireOps.update(_bzModel),

        /// UPLOAD BZ LOGO
        PicProtocols.composePic(_draftWithID?.logoPicModel),

        /// UPLOAD AUTHOR PIC
        _duplicateUserPicAsAuthorPic(
          userModel: userModel,
          bzID: _bzID,
        ),

        /// CENSUS
        CensusListener.onComposeBz(_bzModel),

        /// ADD NEW BZ LOCALLY
        _addMyNewCreatedBzLocally(
          bzModel: _bzModel,
        ),

      ]);

      await StagingLeveller.levelUpZone(
        zoneModel: _bzModel?.zone,
      );

      /// CLOSE WAIT DIALOG
      await WaitDialog.closeWaitDialog();

      /// SHOW SUCCESS DIALOG
      await BldrsCenterDialog.showCenterDialog(
        titleVerse: const Verse(
          id: 'phid_great_!',
          translate: true,
        ),
        bodyVerse: const Verse(
          pseudo: 'Successfully created your Business Account\n system will reboot now',
          id: 'phid_created_bz_successfully',
          translate: true,
        ),
        // color: Colorz.green255,
      );

    }

    blog('ComposeBzProtocol.compose : END');
    return _bzModel;
  }
  // -----------------------------------------------------------------------------

  /// CREATION

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> _addMyNewCreatedBzLocally({
    required BzModel? bzModel,
  }) async {

    final BzModel? _bzModelWithCompleteZoneModel = await BzProtocols.completeBzZoneModel(
        bzModel: bzModel
    );

    /// LDB INSERT
    await BzLDBOps.insertBz(_bzModelWithCompleteZoneModel);

    /// PRO INSERT IN MY BZZ
    final BzzProvider _bzzProvider = Provider.of<BzzProvider>(getMainContext(), listen: false);
    _bzzProvider.addBzToMyBzz(
      bzModel: _bzModelWithCompleteZoneModel,
      notify: true,
    );

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> _addBzIdToMyUserModelAndRenovateAndSubscribeToAllBzTopics({
    required String? bzID,
  }) async {

    final UserModel? _oldUser = UsersProvider.proGetMyUserModel(
      context: getMainContext(),
      listen: false,
    );

    UserModel? _newUser = UserModel.addBzIDToUserBzzIDs(
      oldUser: _oldUser,
      bzIDToAdd: bzID,
    );

    _newUser = UserModel.addAllBzTopicsToMyTopics(
        oldUser: _newUser,
        bzID: bzID
    );

    await Future.wait(<Future>[

      NoteProtocols.subscribeToAllBzTopics(
        bzID: bzID,
        renovateUser: false,
      ),

      UserProtocols.renovate(
        newUser: _newUser,
        oldUser: _oldUser,
        invoker: 'ComposeBzProtocols._addBzIdToMyUserModelAndRenovateAndSubscribeToAllBzTopics',
      ),

    ]);

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> _duplicateUserPicAsAuthorPic({
    required UserModel? userModel,
    required String? bzID,
  }) async {

    if (userModel != null && bzID != null){

      final PicModel? _picModel = await PicProtocols.fetchPic(userModel.picPath);

      final PicModel? _authorModel = _picModel?.copyWith(
        path: StoragePath.bzz_bzID_authorID(
          bzID: bzID,
          authorID: userModel.id,
        ),
      );

      _authorModel?.blogPic(invoker: '_duplicateUserPicAsAuthorPic');

      await PicProtocols.composePic(_authorModel);

    }

  }
  // --------------------
  /// DEPRECATED : IT WILL NEVER FAIL ISA
  /*
  ///
  static Future<void> _failureDialog(BuildContext context) async {

    /// FAILURE DIALOG
    await CenterDialog.showCenterDialog(
      context: context,
      titleVerse: const Verse(
        text: 'phid_ops_!',
        translate: true,
      ),
      bodyVerse: const Verse(
        text: 'phid_somethingIsWrong',
        translate: true,
      ),
    );

  }
   */
  // -----------------------------------------------------------------------------
}
