import 'dart:async';

import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/b_bz/sub/author_model.dart';
import 'package:bldrs/a_models/d_zone/a_zoning/zone_model.dart';
import 'package:bldrs/a_models/i_pic/pic_model.dart';
import 'package:bldrs/a_models/x_ui/tabs/bz_tabber.dart';
import 'package:bldrs/b_views/f_bz/a_bz_profile_screen/a_my_bz_screen.dart';
import 'package:bldrs/b_views/z_components/dialogs/top_dialog/top_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/wait_dialog/wait_dialog.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/app_state_protocols/provider/ui_provider.dart';
import 'package:bldrs/c_protocols/bz_protocols/fire/bz_fire_ops.dart';
import 'package:bldrs/c_protocols/bz_protocols/ldb/bz_ldb_ops.dart';
import 'package:bldrs/c_protocols/bz_protocols/provider/bzz_provider.dart';
import 'package:bldrs/c_protocols/pic_protocols/protocols/pic_protocols.dart';
import 'package:bldrs/c_protocols/zone_protocols/census_protocols/protocols/census_listeners.dart';
import 'package:bldrs/c_protocols/zone_protocols/modelling_protocols/protocols/a_zone_protocols.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
/// => TAMAM
class RenovateBzProtocols {
  // -----------------------------------------------------------------------------

  const RenovateBzProtocols();

  // -----------------------------------------------------------------------------

  /// BZ RENOVATION

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> renovateBz({
    @required BuildContext context,
    @required BzModel newBz,
    @required BzModel oldBz,
    @required bool showWaitDialog,
    @required bool navigateToBzInfoPageOnEnd,
    @required PicModel newLogo,
  }) async {
    blog('RenovateBzProtocol.renovateBz : START');

    final bool _areIdentical = BzModel.checkBzzAreIdentical(
      bz1: newBz,
      bz2: oldBz,
    );

    if (_areIdentical == false){

      /// WAIT DIALOG
      if (showWaitDialog == true){
        pushWaitDialog(
          context: context,
          verse: const Verse(
            text: 'phid_bz_section_selection_info',
            translate: true,
          ),
        );
      }

      /// UPLOAD
      await Future.wait(<Future>[

        /// UPDATE BZ DOC
        BzFireOps.update(newBz),

        /// UPDATE BZ LOGO
        if (newLogo != null)
          PicProtocols.renovatePic(newLogo),

        /// CENSUS
        CensusListener.onRenovateBz(
            newBz: newBz,
            oldBz: oldBz
        ),

        /// UPDATE LOCALLY
        updateBzLocally(
            context: context,
            newBz: newBz,
            oldBz: oldBz
        ),

      ]);

      /// CLOSE WAIT DIALOG
      if (showWaitDialog == true){
        await WaitDialog.closeWaitDialog(context);
      }

      /// ON END NAVIGATION
      if (navigateToBzInfoPageOnEnd == true){

        await Nav.pushHomeAndRemoveAllBelow(
          context: context,
          invoker: 'renovateBz',
        );

        unawaited(
            Nav.goToNewScreen(
              context: context,
              pageTransitionType: PageTransitionType.fade,
              screen: const MyBzScreen(
                initialTab: BzTab.about,
              ),
            )
        );

        /// SHOW SUCCESS DIALOG
        unawaited(TopDialog.showTopDialog(
          context: context,
          firstVerse: const Verse(
            text: 'phid_great_!',
            translate: true,
          ),
          secondVerse: const Verse(
            pseudo: 'Successfully updated your Business Account',
            text: 'phid_updated_bz_successfully',
            translate: true,
          ),
          color: Colorz.green255,
          textColor: Colorz.white255,
        ));

      }

      // /// ON FAILURE
      // else {
      //
      //   /// CLOSE WAIT DIALOG
      //   if (showWaitDialog == true){
      //     await WaitDialog.closeWaitDialog(context);
      //   }
      //
      //   await _failureDialog(context);
      //
      // }

    }

    blog('RenovateBzProtocol.renovateBz : END');
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<void> updateBzLocally({
    @required BuildContext context,
    @required BzModel newBz,
    @required BzModel oldBz,
  }) async {
    // blog('RenovateBzProtocol.updateBzLocally : START');

    final BuildContext context = getContext();

    /// LOCAL UPDATE PROTOCOL
    /// is to update my-active-bz-model in PRO and LDB in case of model changes

    final bool _areTheSame = BzModel.checkBzzAreIdentical(
      bz1: newBz,
      bz2: oldBz,
    );
    // blog('RenovateBzProtocol.updateBzLocally : bzz are identical : $_areTheSame');

    /// UPDATE BZ MODEL EVERYWHERE
    if (_areTheSame == false){

      /// SET UPDATED BZ MODEL LOCALLY ( USER BZZ )
      final BzModel _finalBz = await completeBzZoneModel(
        context: context,
        bzModel: newBz,
      );

      /// OVERRIDE BZ ON LDB
      await BzLDBOps.updateBzOps(
        bzModel: _finalBz,
      );

      final BzzProvider _bzzProvider = Provider.of<BzzProvider>(context, listen: false);

      /// UPDATE MY BZZ
      _bzzProvider.updateBzInMyBzz(
        modifiedBz: _finalBz,
        notify: false,
      );

      /// UPDATE ACTIVE BZ
      _bzzProvider.setActiveBz(
        bzModel: _finalBz,
        notify: true,
      );

      // blog('RenovateBzProtocol.updateBzLocally : my active bz updated in PRO & LDB');

    }

    // blog('RenovateBzProtocol.updateBzLocally : END');
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<BzModel> completeBzZoneModel({
    @required BuildContext context,
    @required BzModel bzModel,
  }) async {
    // blog('RenovateBzProtocol.completeBzZoneModel : START');

    BzModel _output = bzModel;

    if (bzModel != null){

      /// COMPLETED ZONE MODEL
      final ZoneModel _completeZoneModel = await ZoneProtocols.completeZoneModel(
        context: context,
        incompleteZoneModel: bzModel.zone,
      );

      /// COMPLETED BZ MODEL
      _output = bzModel.copyWith(
        zone: _completeZoneModel,
      );

    }

    // blog('RenovateBzProtocol.completeBzZoneModel : END');
    return _output;
  }
  // --------------------
  /*
  /// TESTED : WORKS PERFECT
  static Future<void> _failureDialog(BuildContext context) async {

    /// FAILURE DIALOG
    await CenterDialog.showCenterDialog(
      context: context,
      titleVerse: const Verse(
        pseudo: 'Ops !',
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

  /// AUTHOR RENOVATION

  // --------------------
  /// TESTED : WORKS PERFECT
  static Future<BzModel> renovateAuthor({
    @required BuildContext context,
    @required BzModel oldBz,
    @required AuthorModel newAuthor,
  }) async {

    // blog('RenovateBzProtocols.renovateAuthor : START');

    final BzModel _newBz = BzModel.replaceAuthor(
      newAuthor: newAuthor,
      oldBz: oldBz,
    );

    await Future.wait(<Future>[

      /// UPDATE AUTHOR PIC
      PicProtocols.renovatePic(newAuthor.picModel),

      /// UPDATE BZ ON FIREBASE
      renovateBz(
        context: context,
        newBz: _newBz,
        oldBz: oldBz,
        showWaitDialog: false,
        navigateToBzInfoPageOnEnd: false,
        newLogo: null,
      ),


    ]);

    // blog('RenovateBzProtocols.renovateAuthor : END');

    return _newBz;
  }
  // -----------------------------------------------------------------------------
}
