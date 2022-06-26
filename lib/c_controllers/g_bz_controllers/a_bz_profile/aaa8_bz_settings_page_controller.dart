import 'dart:async';

import 'package:bldrs/a_models/bz/author_model.dart';
import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/a_models/user/user_model.dart';
import 'package:bldrs/b_views/x_screens/g_bz/b_bz_editor/a_bz_editor_screen.dart';
import 'package:bldrs/b_views/z_components/bz_profile/info_page/bz_banner.dart';
import 'package:bldrs/b_views/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/top_dialog/top_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/wait_dialog/wait_dialog.dart';
import 'package:bldrs/b_views/z_components/flyer/c_flyer_groups/flyers_grid.dart';
import 'package:bldrs/c_protocols/bz_protocols.dart';
import 'package:bldrs/d_providers/bzz_provider.dart';
import 'package:bldrs/d_providers/flyers_provider.dart';
import 'package:bldrs/d_providers/user_provider.dart';
import 'package:bldrs/e_db/fire/ops/auth_ops.dart' as AuthFireOps;
import 'package:bldrs/e_db/fire/ops/bz_ops.dart' as BzFireOps;
import 'package:bldrs/e_db/ldb/ops/bz_ldb_ops.dart';
import 'package:bldrs/e_db/ldb/ops/user_ldb_ops.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart' as Scale;
import 'package:bldrs/f_helpers/router/navigators.dart' as Nav;
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// -----------------------------------------------------------------------------

/// BZ EDITING

// -------------------------------
Future<void> onEditBzButtonTap({
  @required BuildContext context,
  @required BzModel bzModel,
}) async {

  await Nav.goToNewScreen(
    context: context,
    screen: BzEditorScreen(
      bzModel: bzModel,
    ),
  );

}
// -----------------------------------------------------------------------------

/// BZ DELETION

// -------------------------------
Future<void> onDeleteBzButtonTap({
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
      updateBz: false,
    );

    await _deleteBzProtocol(
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
    title: '${bzModel.flyersIDs.length} flyers will be permanently deleted',
    body: 'Once flyers are deleted, they can not be retrieved',
    boolDialog: true,
    confirmButtonText: 'Delete All Flyers And Remove ${bzModel.name}',
    child: Container(
      width: CenterDialog.getWidth(context),
      height: 400,
      color: Colorz.white10,
      alignment: Alignment.center,
      child: FlyersGrid(
        scrollController: ScrollController(),
        paginationFlyersIDs: bzModel.flyersIDs,
        scrollDirection: Axis.horizontal,
        gridWidth: CenterDialog.getWidth(context) - 10,
        gridHeight: 200,
        numberOfColumnsOrRows: 1,
      ),
    ),

  );

  return _result;
}
// -------------------------------
/// bz deletion ops
// ------------------
Future<void> _deleteAllBzFlyersOps({
  @required BuildContext context,
  @required BzModel bzModel,
  @required bool updateBz,
}) async {

  unawaited(WaitDialog.showWaitDialog(
    context: context,
    loadingPhrase: 'Deleting ${bzModel.flyersIDs.length} Flyers',
    canManuallyGoBack: false,
  ));

  /// DELETE BZ FLYERS
  final List<FlyerModel> _flyers = await FlyersProvider.proFetchFlyers(
      context: context,
      flyersIDs: bzModel.flyersIDs
  );

  await BzProtocol.deleteMultipleBzFlyersProtocol(
      context: context,
      bzModel: bzModel,
      flyers: _flyers,
      showWaitDialog: false,
      updateBzEveryWhere: updateBz
  );

  WaitDialog.closeWaitDialog(context);

}
// ------------------
Future<void> _deleteBzProtocol({
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
  // / NO NEED TO CLEAR LAST INSTANCE IN ACTIVE BZ AS WE WILL NAVIGATE BACK
  // / TO HOME SCREEN, THEN RESET MY ACTIVE BZ ON NEXT BZ SCREEN OPENING
  _bzzProvider.clearMyActiveBz(
    notify: true,
  );

  _usersProvider.removeBzIDFromMyBzzIDs(
    bzIDToRemove: bzModel.id,
    notify: true,
  );

  WaitDialog.closeWaitDialog(context);

}
