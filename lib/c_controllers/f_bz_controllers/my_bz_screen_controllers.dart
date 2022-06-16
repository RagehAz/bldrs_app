import 'dart:async';

import 'package:bldrs/a_models/bz/author_model.dart';
import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/a_models/zone/zone_model.dart';
import 'package:bldrs/b_views/x_screens/f_bz_editor/f_x_bz_editor_screen.dart';
import 'package:bldrs/b_views/z_components/bz_profile/info_page/bz_banner.dart';
import 'package:bldrs/b_views/z_components/dialogs/bottom_dialog/bottom_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/top_dialog/top_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/wait_dialog/wait_dialog.dart';
import 'package:bldrs/c_controllers/f_bz_controllers/bz_flyers_page_controllers.dart';
import 'package:bldrs/c_controllers/i_flyer_controllers/flyer_controllers.dart';
import 'package:bldrs/d_providers/bzz_provider.dart';
import 'package:bldrs/d_providers/notes_provider.dart';
import 'package:bldrs/d_providers/phrase_provider.dart';
import 'package:bldrs/d_providers/ui_provider.dart';
import 'package:bldrs/d_providers/user_provider.dart';
import 'package:bldrs/d_providers/zone_provider.dart';
import 'package:bldrs/e_db/fire/ops/auth_ops.dart' as AuthFireOps;
import 'package:bldrs/e_db/fire/ops/bz_ops.dart' as BzFireOps;
import 'package:bldrs/e_db/fire/ops/user_ops.dart' as UserFireOps;
import 'package:bldrs/e_db/ldb/ops/auth_ldb_ops.dart';
import 'package:bldrs/e_db/ldb/ops/bz_ldb_ops.dart';
import 'package:bldrs/e_db/ldb/ops/user_ldb_ops.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart' as Scale;
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart' as Nav;
import 'package:bldrs/f_helpers/theme/colorz.dart';
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
Future<void> onMyBzStreamChanged({
  @required BuildContext context,
  @required Map<String, dynamic> newMap,
  @required Map<String, dynamic> oldMap,
}) async {

  final BzModel _newBzFromStream = BzModel.decipherBz(
    map: newMap,
    fromJSON: false,
  );

  final BzModel _oldBzModel = BzModel.getBzFromBzzByBzID(
    bzz: BzzProvider.proGetMyBzz(context: context, listen: false),
    bzID: _newBzFromStream.id,
  );

  await _updateMyBzModelEverywhereIfUpdated(
    context: context,
    oldBzModel: _oldBzModel,
    newBzModel: _newBzFromStream,
  );

  await _myBzResignationProtocol(
    context: context,
    newBzFromStream: _newBzFromStream,
  );

}
// -------------------------------
/// TESTED : WORKS PERFECT
Future<void> _updateMyBzModelEverywhereIfUpdated({
  @required BuildContext context,
  @required BzModel oldBzModel,
  @required BzModel newBzModel,
}) async {

  final bool _areTheSame = BzModel.checkBzzAreIdentical(
    bz1: newBzModel,
    bz2: oldBzModel,
  );

  blog('_updateMyBzModelEverywhereIfUpdated : bzz are identical : $_areTheSame');

  /// UPDATE BZ MODEL EVERYWHERE
  if (_areTheSame == false){

    /// OVERRIDE BZ ON LDB
    await BzLDBOps.insertBz(
      bzModel: newBzModel,
    );

    final BzzProvider _bzzProvider = Provider.of<BzzProvider>(context, listen: false);

    /// UPDATE MY BZZ
    _bzzProvider.updateBzInMyBzz(
      modifiedBz: newBzModel,
      notify: false,
    );

    /// UPDATE ACTIVE BZ
    _bzzProvider.setActiveBz(
      bzModel: newBzModel,
      notify: true,
    );

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

/// BZ OPTIONS

// -------------------------------
Future<void> onBzAccountOptionsTap({
  @required BuildContext context,
  @required BzModel bzModel,
}) async {

  // final UsersProvider _usersProvider = Provider.of<UsersProvider>(context, listen: false);

  await BottomDialog.showButtonsBottomDialog(
      context: context,
      draggable: true,
      buttonHeight: 50,
      numberOfWidgets: 2,
      title: '${bzModel.name} Business account options',
      builder: (_, PhraseProvider pro){

        return <Widget>[

          BottomDialog.wideButton(
            context: context,
            height: 50,
            verse: 'Edit ${bzModel.name} Business Account',
            verseCentered: true,
            onTap: () => _onEditBzButtonTap(
              context: context,
              bzModel: bzModel,
            ),
          ),

          BottomDialog.wideButton(
            context: context,
            height: 50,
            verse: 'Delete ${bzModel.name} Business Account',
            verseCentered: true,
            onTap: () => _onDeleteBzButtonTap(
              context: context,
              bzModel: bzModel,
            ),
          ),


        ];

      }
  );

}
// -----------------------------------------------------------------------------

/// BZ EDITING

// -------------------------------
Future<void> _onEditBzButtonTap({
  @required BuildContext context,
  @required BzModel bzModel,
}) async {

  final UserModel _userModel = UsersProvider.proGetMyUserModel(context);

  await Nav.goToNewScreen(
    context: context,
    screen: BzEditorScreen(
      userModel: _userModel,
      bzModel: bzModel,
    ),
  );

}
// -----------------------------------------------------------------------------

/// BZ DELETION

// -------------------------------
Future<void> _onDeleteBzButtonTap({
  @required BuildContext context,
  @required BzModel bzModel,
}) async {

  final bool _canContinue = await _preDeleteBzAccountChecks(
    context: context,
    bzModel: bzModel,
  );

  if (_canContinue == true){

    await _deleteAllBzFlyersOps(
      context: context,
      bzModel: bzModel,
    );

    await _deleteBzOps(
      context: context,
      bzModel: bzModel,
    );

    /// re-route back
    Nav.goBackToHomeScreen(context);

    await TopDialog.showTopDialog(
      context: context,
      firstLine: 'Business Account has been deleted successfully',
      color: Colorz.green255,
      textColor: Colorz.white255,
    );

  }

}
// -------------------------------
/// bz deletion dialogs
// ------------------
Future<bool> _preDeleteBzAccountChecks({
  @required BuildContext context,
  @required BzModel bzModel,
}) async {

  bool _canContinue = false;

  final bool _authorIsMaster = AuthorModel.checkUserIsMasterAuthor(
    userID: AuthFireOps.superUserID(),
    bzModel: bzModel,
  );

  /// WHEN USER IS NOT MASTER AUTHOR
  if (_authorIsMaster == false){

    await _showOnlyMasterCanDeleteBzDialog(
      context: context,
      bzModel: bzModel,
    );

  }

  /// WHEN USER IS MASTER AUTHOR
  else {

    final bool _confirmedDeleteBz = await _showConfirmDeleteBzDialog(
      context: context,
      bzModel: bzModel,
    );

    /// IF USER CHOSE TO CONTINUE DELETION
    if (_confirmedDeleteBz == true){

      /// IF BZ HAS NO FLYERS
      if (bzModel.flyersIDs.isEmpty == true) {
        _canContinue = true;
      }

      /// IF BZ HAS FLYERS
      else {

        final bool _confirmDeleteAllBzFlyers = await _showConfirmDeleteAllBzFlyersDialog(
          context: context,
          bzModel: bzModel,
        );

        /// IF USER CONFIRMED TO DELETE ALL BZ FLYERS
        if (_confirmDeleteAllBzFlyers == true){
          _canContinue = true;
        }

      }

    }


  }

  return _canContinue;
}
// ------------------
Future<bool> _showConfirmDeleteBzDialog({
  @required BuildContext context,
  @required BzModel bzModel,
}) async {

  final bool _result = await CenterDialog.showCenterDialog(
    context: context,
    title: 'Delete ${bzModel.name} Business Account ?',
    body: 'All Account flyers, records and data will be deleted and can not be retrieved',
    confirmButtonText: 'Yes, Delete',
    boolDialog: true,
    height: Scale.superScreenHeight(context) * 0.7,
    child: BzBanner(
      bzModel: bzModel,
    ),
  );

  return _result;
}
// ------------------
Future<void> _showOnlyMasterCanDeleteBzDialog({
  @required BuildContext context,
  @required BzModel bzModel,
}) async {

  final String _masterAuthorsString = AuthorModel.generateMasterAuthorsNamesString(
    context: context,
    bzModel: bzModel,
  );

  await CenterDialog.showCenterDialog(
    context: context,
    title: 'Can Not Delete This Account',
    body: 'Only $_masterAuthorsString can delete this Account',
  );

}
// ------------------
Future<bool> _showConfirmDeleteAllBzFlyersDialog({
  @required BuildContext context,
  @required BzModel bzModel,
}) async {

  final bool _result = await CenterDialog.showCenterDialog(
    context: context,
    title: '${bzModel.flyersIDs.length} flyers will be deleted',
    body: 'Once flyers are deleted, they can not be retrieved',
    boolDialog: true,
  );

  return _result;
}
// -------------------------------
  /// bz deletion ops
// ------------------
Future<void> _deleteAllBzFlyersOps({
  @required BuildContext context,
  @required BzModel bzModel,
}) async {

  unawaited(WaitDialog.showWaitDialog(
    context: context,
    loadingPhrase: 'Deleting ${bzModel.flyersIDs.length} Flyers',
    canManuallyGoBack: false,
  ));

  /// DELETE BZ FLYERS
  final List<FlyerModel> _flyers = await fetchFlyers(
      context: context,
      flyersIDs: bzModel.flyersIDs
  );

  for (final FlyerModel flyer in _flyers){

    await deleteFlyerOps(
      bzModel: bzModel,
      context: context,
      flyer: flyer,
      showWaitDialog: false,
    );


  }

  WaitDialog.closeWaitDialog(context);

}
// ------------------
Future<void> _deleteBzOps({
  @required BuildContext context,
  @required BzModel bzModel,
}) async {

  unawaited(WaitDialog.showWaitDialog(
    context: context,
    loadingPhrase: 'Deleting ${bzModel.name}',
    canManuallyGoBack: false,
  ));

  /// DELETE BZ ON FIREBASE
  await BzFireOps.deleteBzOps(
    context: context,
    bzModel: bzModel,
  );

  /// DELETE BZ ON LDB
  await BzLDBOps.deleteBzOps(
    context: context,
    bzModel: bzModel,
  );
  final UsersProvider _usersProvider = Provider.of<UsersProvider>(context, listen: false);
  final UserModel _userModel = _usersProvider.myUserModel;
  await UserLDBOps.removeBzIDFromMyBzIDs(
    bzIDToRemove: bzModel.id,
    userModel: _userModel,
  );

  /// DELETE BZ ON PROVIDER
  final BzzProvider _bzzProvider = Provider.of<BzzProvider>(context, listen: false);
  _bzzProvider.removeBzFromMyBzz(
    bzID: bzModel.id,
    notify: false,
  );
  _bzzProvider.removeBzFromSponsors(
    bzIDToRemove: bzModel.id,
    notify: false,
  );
  _bzzProvider.removeBzFromFollowedBzz(
    bzIDToRemove: bzModel.id,
    notify: false,
  );
  _bzzProvider.clearMyActiveBz(
    notify: true,
  );
  _usersProvider.removeBzIDFromMyBzzIDs(
    bzIDToRemove: bzModel.id,
    notify: true,
  );

  WaitDialog.closeWaitDialog(context);


}
