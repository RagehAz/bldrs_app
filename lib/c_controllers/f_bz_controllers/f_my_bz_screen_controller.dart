import 'dart:async';

import 'package:bldrs/a_models/bz/author_model.dart';
import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/a_models/flyer/records/publish_time_model.dart';
import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/a_models/zone/zone_model.dart';
import 'package:bldrs/b_views/x_screens/f_bz_editor/f_x_bz_editor_screen.dart';
import 'package:bldrs/b_views/z_components/bz_profile/info_page/bz_banner.dart';
import 'package:bldrs/b_views/z_components/dialogs/bottom_dialog/bottom_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/top_dialog/top_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/wait_dialog/wait_dialog.dart';
import 'package:bldrs/b_views/z_components/flyer/a_flyer_structure/a_flyer_starter.dart';
import 'package:bldrs/b_views/z_components/flyer/a_flyer_structure/e_flyer_box.dart';
import 'package:bldrs/c_controllers/i_flyer_controllers/flyer_controller.dart';
import 'package:bldrs/d_providers/bzz_provider.dart';
import 'package:bldrs/d_providers/flyers_provider.dart';
import 'package:bldrs/d_providers/phrase_provider.dart';
import 'package:bldrs/d_providers/ui_provider.dart';
import 'package:bldrs/d_providers/user_provider.dart';
import 'package:bldrs/d_providers/zone_provider.dart';
import 'package:bldrs/e_db/fire/ops/auth_ops.dart';
import 'package:bldrs/e_db/fire/ops/bz_ops.dart' as BzFireOps;
import 'package:bldrs/e_db/fire/ops/flyer_ops.dart' as FlyerOps;
import 'package:bldrs/e_db/ldb/api/ldb_doc.dart' as LDBDoc;
import 'package:bldrs/e_db/ldb/api/ldb_ops.dart' as LDBOps;
import 'package:bldrs/e_db/ldb/ops/bz_ldb_ops.dart';
import 'package:bldrs/e_db/ldb/ops/user_ldb_ops.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/drafters/timerz.dart' as Timers;
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart' as Nav;
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart' as Scale;

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

  await _setBzModelAndGetSetBzFlyers(
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
    final ZoneModel _completeZoneModel = await ZoneProvider.proGetCompleteZoneModel(
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
Future<void> _setBzModelAndGetSetBzFlyers({
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
  await _bzzProvider.getsetActiveBzFlyers(
    context: context,
    bzID: completedZoneBzModel.id,
    notify: true,
  );


}
// -----------------------------------------------------------------------------

/// MY BZ SCREEN CLOSING

// -------------------------------
void onCloseMyBzScreen({
  @required BuildContext context,
}) {
  final BzzProvider _bzzProvider = Provider.of<BzzProvider>(context, listen: false);
  _bzzProvider.clearActiveBzFlyers(notify: false);
  _bzzProvider.clearMyActiveBz(notify: false);
  Nav.goBack(context);
}
// -----------------------------------------------------------------------------

/// BZ TABS

// -------------------------------
int getInitialMyBzScreenTabIndex(BuildContext context){
  final UiProvider _uiProvider = Provider.of<UiProvider>(context, listen: false);
  final BzTab _currentTab = _uiProvider.currentBzTab;
  final int _index = BzModel.getBzTabIndex(_currentTab);
  return _index;
}
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
    _uiProvider.setCurrentBzTab(_newBzTab);
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

  final UsersProvider _usersProvider = Provider.of<UsersProvider>(context, listen: false);

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

  final bool _authorIsMaster = AuthorModel.userIsMasterAuthor(
    userID: superUserID(),
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
    height: superScreenHeight(context) * 0.7,
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

    await _deleteFlyerOps(
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
// -----------------------------------------------------------------------------

/// FLYER OPTIONS

// -------------------------------
Future<void> onFlyerOptionsTap({
  @required BuildContext context,
  @required FlyerModel flyer,
  @required BzModel bzModel,
}) async {

  blog('SHOULD DELETE THIS FLYER');
  blog('if flyer is only 48 hours old');

  final String _age = Timers.getSuperTimeDifferenceString(
    from: PublishTime.getPublishTimeFromTimes(
      times: flyer.times,
      state: FlyerState.published,
    )?.time,
    to: DateTime.now(),
  );

  await BottomDialog.showButtonsBottomDialog(
      context: context,
      draggable: true,
      buttonHeight: 40,
      numberOfWidgets: 2,
      title: 'published $_age',
      builder: (_, PhraseProvider pro){

        return <Widget>[

          BottomDialog.wideButton(
            context: context,
            verse: 'Edit flyer',
            verseCentered: true,
            onTap: () => _onEditFlyerButtonTap(flyer),
          ),

          BottomDialog.wideButton(
            context: context,
            verse: 'Delete flyer',
            verseCentered: true,
            onTap: () => _onDeleteFlyerButtonTap(
              context: context,
              flyer: flyer,
              bzModel: bzModel,
            ),
          ),


        ];

      }
  );

}
// -----------------------------------------------------------------------------

/// FLYER EDITING

// -------------------------------
Future<void> _onEditFlyerButtonTap(FlyerModel flyer) async {
  blog('should edit flyer');
}
// -----------------------------------------------------------------------------

/// FLYER DELETION

// -------------------------------
Future<void> _onDeleteFlyerButtonTap({
  @required BuildContext context,
  @required FlyerModel flyer,
  @required BzModel bzModel,
}) async {

  blog('_onDeleteFlyer : starting deleting flyer ${flyer.id}');

  final bool _result = await _showConfirmDeleteFlyerDialog(
    context: context,
    flyer: flyer,
  );

  /// TASK : NEED TO CHECK USER PERMISSIONS TO BE ABLE TO CONTINUE DELETION PROCESSES
  /// => IS OWNER OF STORAGE PICS ?

  if (_result == true){

    await _deleteFlyerOps(
      context: context,
      bzModel: bzModel,
      flyer: flyer,
      showWaitDialog: true
    );

    Nav.goBack(context);

    await TopDialog.showTopDialog(
      context: context,
      firstLine: 'Flyer has been deleted successfully',
      color: Colorz.green255,
      textColor: Colorz.white255,
    );

  }

}
// -------------------------------
Future<bool> _showConfirmDeleteFlyerDialog({
  @required BuildContext context,
  @required FlyerModel flyer,
}) async {

  final double _screenHeight = Scale.superScreenHeight(context);
  final double _dialogHeight = _screenHeight * 0.7;
  final double _flyerBoxHeight = _dialogHeight * 0.5;

  final bool _result = await CenterDialog.showCenterDialog(
    context: context,
    title: 'Delete Flyer',
    body: 'This will delete this flyer and all its content and can not be retrieved any more',
    boolDialog: true,
    confirmButtonText: 'Yes Delete Flyer',
    height: _dialogHeight,
    child: SizedBox(
      height: _flyerBoxHeight,
      child: AbsorbPointer(
        child: FlyerStarter(
          flyerModel: flyer,
          minWidthFactor: FlyerBox.sizeFactorByHeight(context, _flyerBoxHeight),
        ),
      ),
    ),
  );

  return _result;
}
// -------------------------------
Future<void> _deleteFlyerOps({
  @required BuildContext context,
  @required BzModel bzModel,
  @required FlyerModel flyer,
  @required bool showWaitDialog,
}) async {

  if (showWaitDialog == true){
    unawaited(WaitDialog.showWaitDialog(
      context: context,
      loadingPhrase: 'Deleting flyer',
      canManuallyGoBack: false,
    ));
  }

  /// DELETE FLYER OPS ON FIREBASE
  await FlyerOps.deleteFlyerOps(
    context: context,
    flyerModel: flyer,
    bzModel: bzModel,
    deleteFlyerIDFromBzzFlyersIDs: true,
  );

  /// REMOVE ID FROM BZ FLYERS IDS ON FIREBASE
  final List<String> _updatedFlyersIDs = BzModel.removeFlyerIDFromBzFlyersIDs(
    bzModel: bzModel,
    flyerIDToRemove: flyer.id,
  );

  final BzModel _updatedBzModel = bzModel.copyWith(
    flyersIDs: _updatedFlyersIDs,
  );

  /// DELETE FLYER ON LDB
  await LDBOps.deleteMap(
      objectID: flyer.id,
      docName: LDBDoc.flyers
  );

  /// UPDATE BZ ON LDB
  await LDBOps.updateMap(
    docName: LDBDoc.bzz,
    objectID: _updatedBzModel.id,
    input: _updatedBzModel.toMap(toJSON: true),
  );

  /// UPDATE BZ ON PROVIDER
  final BzzProvider _bzzProvider = Provider.of<BzzProvider>(context, listen: false);
  _bzzProvider.setActiveBz(
    bzModel: _updatedBzModel,
    notify: false,
  );

  /// UPDATE ACTIVE BZ FLYERS
  final List<FlyerModel> _updatedFlyers = FlyerModel.removeFlyerFromFlyersByID(
    flyers: _bzzProvider.myActiveBzFlyers,
    flyerIDToRemove: flyer.id,
  );
  _bzzProvider.setActiveBzFlyers(
    flyers: _updatedFlyers,
    notify: true,
  );

  /// REMOVE FLYER FROM FLYERS PROVIDER
  final FlyersProvider _flyersProvider = Provider.of<FlyersProvider>(context, listen: false);
  _flyersProvider.removeFlyerFromFlyersProvider(
    flyerID: flyer.id,
    notify: true,
  );

  if (showWaitDialog == true){
    WaitDialog.closeWaitDialog(context);
  }

}
// -----------------------------------------------------------------------------
