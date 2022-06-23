import 'dart:async';

import 'package:bldrs/a_models/bz/author_model.dart';
import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/a_models/zone/zone_model.dart';
import 'package:bldrs/b_views/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/c_protocols/bz_protocols.dart';
import 'package:bldrs/d_providers/bzz_provider.dart';
import 'package:bldrs/d_providers/notes_provider.dart';
import 'package:bldrs/d_providers/ui_provider.dart';
import 'package:bldrs/d_providers/user_provider.dart';
import 'package:bldrs/d_providers/zone_provider.dart';
import 'package:bldrs/e_db/fire/ops/auth_ops.dart' as AuthFireOps;
import 'package:bldrs/e_db/fire/ops/user_ops.dart';
import 'package:bldrs/e_db/ldb/ops/auth_ldb_ops.dart';
import 'package:bldrs/e_db/ldb/ops/bz_ldb_ops.dart';
import 'package:bldrs/e_db/ldb/ops/user_ldb_ops.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart' as Nav;
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

  final BzModel _completedZoneBzModel = await completeBzZoneModel(
    context: context,
    bzModel: bzModel,
  );

  await _setBzModelAndFetchSetBzFlyers(
    context: context,
    completedZoneBzModel: _completedZoneBzModel,
  );

}
// -------------------------------
Future<BzModel> completeBzZoneModel({
  @required BuildContext context,
  @required BzModel bzModel,
}) async {

  BzModel _output = bzModel;

  if (bzModel != null){

    /// COMPLETED ZONE MODEL
    final ZoneModel _completeZoneModel = await ZoneProvider.proFetchCompleteZoneModel(
      context: context,
      incompleteZoneModel: bzModel.zone,
    );

    /// COMPLETED BZ MODEL
    _output = bzModel.copyWith(
      zone: _completeZoneModel,
    );

  }

  return _output;
}
// -------------------------------
Future<void> _setBzModelAndFetchSetBzFlyers({
  @required BuildContext context,
  @required BzModel completedZoneBzModel,
}) async {

  final BzzProvider _bzzProvider = Provider.of<BzzProvider>(context, listen: false);

  /// SET ACTIVE BZ
  _bzzProvider.setActiveBz(
    bzModel: completedZoneBzModel,
    notify: false,
  );

  /// SET ACTIVE BZ FLYERS
  await _bzzProvider.fetchSetActiveBzFlyers(
    context: context,
    bzID: completedZoneBzModel.id,
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

      await BzProtocol.myActiveBzLocalUpdateProtocol(
        context: context,
        newBzModel: _newBzFromStream,
        oldBzModel: _oldBzModel,
      );

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
      title: 'This Business account is not available',
      body: 'Your account does not have access to this business account',
    );

    /// 4 - REMOVE BZ FROM MY BZ IN BZZ PROVIDER
    final BzzProvider _bzzProvider = Provider.of<BzzProvider>(context, listen: false);
    _bzzProvider.removeBzFromMyBzz(
        bzID: newBzFromStream.id,
        notify: false,
    );
    await BzLDBOps.deleteBzOps(
        context: context,
        bzModel: newBzFromStream,
    );

    /// 5 - REMOVE BZ ID FROM MY BZZ IDS / UPDATE MY USER MODEL AND AUTH MODEL IN PROVIDER
    final UsersProvider _usersProvider = Provider.of<UsersProvider>(context, listen: false);
    final UserModel _oldUserModel = _usersProvider.myUserModel;
    _usersProvider.removeBzIDFromMyBzzIDs(
        bzIDToRemove: newBzFromStream.id,
        notify: true,
    );
    final UserModel _myUpdatedUserModel = _usersProvider.myUserModel;

    /// 7 - UPDATE MY USER IN LDB
    await UserLDBOps.updateUserModel(_myUpdatedUserModel);
    await AuthLDBOps.updateAuthModel(_usersProvider.myAuthModel);

    /// 8 - UPDATE MY USER MODEL IN FIREBASE
    await UserFireOps.updateUser(
        context: context,
        oldUserModel: _oldUserModel,
        newUserModel: _myUpdatedUserModel,
    );

    /// 10 - REMOVE ALL NOTES FROM ALL-MY-BZZ-NOTES AND OBELISK NOTES NUMBERS
    final NotesProvider _notesProvider = Provider.of<NotesProvider>(context, listen: false);
    _notesProvider.removeAllNotesOfThisBzFromAllBzzUnseenReceivedNotes(
      bzID: newBzFromStream.id,
      notify: false,
    );
    _notesProvider.removeAllObeliskNoteNumbersRelatedToBzID(
        bzID: newBzFromStream.id,
        notify: true
    );

    /// 11 - GO BACK HOME
    Nav.goBack(context);

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
  _bzzProvider.clearActiveBzFlyers(notify: false);
  _bzzProvider.clearMyActiveBz(notify: true);
  // final NotesProvider _notesProvider = Provider.of<NotesProvider>(context, listen: false);
  // _notesProvider.clearPendingSentAuthorshipNotes(notify: true);
  Nav.goBack(context);
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
