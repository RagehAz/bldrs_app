import 'dart:async';
import 'package:bldrs/a_models/bz/author_model.dart';
import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/b_views/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/c_protocols/author_protocols/a_author_protocols.dart';
import 'package:bldrs/c_protocols/bz_protocols/a_bz_protocols.dart';
import 'package:bldrs/d_providers/bzz_provider.dart';
import 'package:bldrs/d_providers/ui_provider.dart';
import 'package:bldrs/e_db/fire/ops/auth_fire_ops.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// -----------------------------------------------------------------------------

/// MY BZ SCREEN INITIALIZERS

// -------------------------------
Future<void> initializeMyBzScreen({
  @required BuildContext context,
  @required BzModel bzModel,
}) async {

  final BzModel _completedZoneBzModel = await BzProtocols.completeBzZoneModel(
    context: context,
    bzModel: bzModel,
  );

  await _setBzModel(
    context: context,
    completedZoneBzModel: _completedZoneBzModel,
  );

}
// -------------------------------
Future<void> _setBzModel({
  @required BuildContext context,
  @required BzModel completedZoneBzModel,
}) async {

  final BzzProvider _bzzProvider = Provider.of<BzzProvider>(context, listen: false);

  /// SET ACTIVE BZ
  _bzzProvider.setActiveBz(
    bzModel: completedZoneBzModel,
    notify: true,
  );

}
// -----------------------------------------------------------------------------

/// MY BZ SCREEN INITIALIZERS

// -------------------------------
/// TESTED : WORKS PERFECT
Future<void> onMyActiveBzStreamChanged({
  @required BuildContext context,
  @required Map<String, dynamic> newMap,
  @required Map<String, dynamic> oldMap,
  @required BzzProvider bzzProvider,
}) async {

  if (newMap == null){

    blog('onMyActiveBzStreamChanged : THE NEW BITCH MAP IS NULL NOW AND WE CAN DO SOME STUFF HEREEEEEEEEEEEEEEEEEE');

  }

  else {

    final BzModel _newBzFromStream = BzModel.decipherBz(
      map: newMap,
      fromJSON: false,
    );

    final bool _areIdentical = BzModel.checkBzzAreIdentical(
      bz1: bzzProvider.myActiveBz,
      bz2: _newBzFromStream,
    );

    blog('onMyActiveBzStreamChanged : streamBz == proMyActiveBz ? : $_areIdentical');

    if (_areIdentical == false){

      final bool _authorsContainMyUserID = AuthorModel.checkAuthorsContainUserID(
        authors: _newBzFromStream.authors,
        userID: AuthFireOps.superUserID(),
      );

      if (_authorsContainMyUserID == false){

        await _myBzResignationProtocol(
          context: context,
          newBzFromStream: _newBzFromStream,
        );

      }

      else {

        final BzModel _oldBzModel = BzModel.decipherBz(
          map: oldMap,
          fromJSON: false,
        );

        await BzProtocols.updateBzLocally(
          context: context,
          newBzModel: _newBzFromStream,
          oldBzModel: _oldBzModel,
        );

      }

    }

  }

}
// -------------------------------
Future<void> _myBzResignationProtocol({
  @required BuildContext context,
  @required BzModel newBzFromStream,
}) async {

  /// THIS METHOD RUNS WHEN STREAMED BZ MODEL DOES NOT INCLUDE MY USER ID
  // description
  // if bz model is updated and does not include me in its authors any more
  // that means I have been deleted from the team
  // so we need to clear the bz and all its related stuff as follows

  /// 1 - CHECK IF I'M STILL IN THE TEAM
  final bool _authorsContainMyUserID = AuthorModel.checkAuthorsContainUserID(
    authors: newBzFromStream.authors,
    userID: AuthFireOps.superUserID(),
  );

  /// 2 - WHEN I GOT REMOVED FROM THE BZ TEAM
  if (_authorsContainMyUserID == false){

    /// 3 - SHOW NOTICE DIALOG
    await CenterDialog.showCenterDialog(
      context: context,
      titleVerse:  '##This Business account is not available',
      bodyVerse:  '##Your account does not have access to this business account',
    );

    await AuthorProtocols.removeMeFromBzProtocol(
        context: context,
        streamedBzModelWithoutMyID: newBzFromStream
    );

    /// 11 - GO BACK HOME
    Nav.goBack(
      context: context,
      invoker: '_myBzResignationProtocol',
    );

    /// 12 - CLEAR MY ACTIVE BZ
    // _bzzProvider.clearMyActiveBz(
    //     notify: false
    // );
    // _bzzProvider.clearActiveBzFlyers(
    //     notify: true,
    // );

  }


}
// -----------------------------------------------------------------------------

/// MY BZ SCREEN CLOSING

// -------------------------------
void onCloseMyBzScreen({
  @required BuildContext context,
}) {
  blog('onCloseMyBzScreen : CLOSING');

  final BzzProvider _bzzProvider = Provider.of<BzzProvider>(context, listen: false);
  _bzzProvider.clearMyActiveBz(notify: true);
  // final NotesProvider _notesProvider = Provider.of<NotesProvider>(context, listen: false);
  // _notesProvider.clearPendingSentAuthorshipNotes(notify: true);
  Nav.goBack(
    context: context,
    invoker: 'onCloseMyBzScreen',
  );

}
// -----------------------------------------------------------------------------

/// BZ TABS

// -------------------------------
// int getInitialMyBzScreenTabIndex(BuildContext context){
//   final UiProvider _uiProvider = Provider.of<UiProvider>(context, listen: false);
//   final BzTab _currentTab = _uiProvider.currentBzTab;
//   final int _index = BzModel.getBzTabIndex(_currentTab);
//   return _index;
// }
// -------------------------------
void onChangeMyBzScreenTabIndexWhileAnimation({
  @required BuildContext context,
  @required TabController tabController,
}){

  if (tabController.indexIsChanging == false) {

    final int _indexFromAnimation = (tabController.animation.value).round();
    onChangeMyBzScreenTabIndex(
      context: context,
      index: _indexFromAnimation,
      tabController: tabController,
    );

  }

}
// -------------------------------
void onChangeMyBzScreenTabIndex({
  @required BuildContext context,
  @required int index,
  @required TabController tabController,
}) {

  final UiProvider _uiProvider = Provider.of<UiProvider>(context, listen: false);

  final BzTab _newBzTab = BzModel.bzTabsList[index];
  final BzTab _previousBzTab = _uiProvider.currentBzTab;

  /// ONLY WHEN THE TAB CHANGES FOR REAL IN THE EXACT MIDDLE BETWEEN BUTTONS
  if (_newBzTab != _previousBzTab){
    // blog('index is $index');
    // _uiProvider.setCurrentBzTab(_newBzTab);
    tabController.animateTo(index,
        curve: Curves.easeIn,
        duration: Ratioz.duration150ms
    );
  }

}
// -----------------------------------------------------------------------------
