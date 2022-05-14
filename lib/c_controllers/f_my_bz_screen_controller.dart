import 'dart:async';

import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/a_models/flyer/records/publish_time_model.dart';
import 'package:bldrs/b_views/z_components/dialogs/bottom_dialog/bottom_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/top_dialog/top_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/wait_dialog/wait_dialog.dart';
import 'package:bldrs/b_views/z_components/flyer/a_flyer_structure/a_flyer_starter.dart';
import 'package:bldrs/b_views/z_components/flyer/a_flyer_structure/e_flyer_box.dart';
import 'package:bldrs/c_controllers/i_flyer_controllers/flyer_controller.dart';
import 'package:bldrs/d_providers/bzz_provider.dart';
import 'package:bldrs/d_providers/phrase_provider.dart';
import 'package:bldrs/d_providers/ui_provider.dart';
import 'package:bldrs/d_providers/user_provider.dart';
import 'package:bldrs/e_db/fire/ops/bz_ops.dart' as FireBzOps;
import 'package:bldrs/e_db/fire/ops/flyer_ops.dart' as FlyerOps;
import 'package:bldrs/e_db/ldb/api/ldb_doc.dart' as LDBDoc;
import 'package:bldrs/e_db/ldb/api/ldb_ops.dart' as LDBOps;
import 'package:bldrs/e_db/ldb/ops/bz_ldb_ops.dart';
import 'package:bldrs/e_db/ldb/ops/user_ldb_ops.dart';
import 'package:bldrs/f_helpers/drafters/timerz.dart' as Timers;
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart' as Nav;
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// -----------------------------------------------------------------------------
int getInitialMyBzScreenTabIndex(BuildContext context){
  final UiProvider _uiProvider = Provider.of<UiProvider>(context, listen: false);
  final BzTab _currentTab = _uiProvider.currentBzTab;
  final int _index = BzModel.getBzTabIndex(_currentTab);
  return _index;
}
// -----------------------------------------------------------------------------
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
// -----------------------------------------------------------------------------
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

/// BZ FLYERS PAGE

// -------------------------------
Future<void> onBzAccountOptions({
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
            onTap: () => _onEditBzAccount(
              context: context,
              bzModel: bzModel,
            ),
          ),

          BottomDialog.wideButton(
            context: context,
            height: 50,
            verse: 'Delete ${bzModel.name} Business Account',
            verseCentered: true,
            onTap: () => _onDeleteBzAccount(
              context: context,
              bzModel: bzModel,
            ),
          ),


        ];

      }
  );


}
// -------------------------------
Future<void> _onEditBzAccount({
  @required BuildContext context,
  @required BzModel bzModel,
}) async {

}
// -------------------------------
Future<void> _onDeleteBzAccount({
  @required BuildContext context,
  @required BzModel bzModel,
}) async {
    // Nav.goBack(context);

    final bool _dialogResult = await CenterDialog.showCenterDialog(
      context: context,
      title: 'Delete ${bzModel.name} Business Account ?',
      body: 'All Account flyers, records and data will be deleted and can not be retrieved',
      confirmButtonText: 'Yes, Delete',
      boolDialog: true,
    );

    if (_dialogResult == true) {

      /// TASK : NEED TO CHECK USER PERMISSIONS TO BE ABLE TO CONTINUE DELETION PROCESSES
      /// => IS OWNER IS MASTER

      unawaited(WaitDialog.showWaitDialog(
        context: context,
        loadingPhrase: 'Deleting ${bzModel.name}',
        canManuallyGoBack: false,
      ));

      /// DELETE BZ FLYERS
      final List<FlyerModel> _flyers = await fetchFlyers(
          context: context,
          flyersIDs: bzModel.flyersIDs
      );
      for (final FlyerModel flyer in _flyers){
        await _onDeleteFlyer(
          bzModel: bzModel,
          context: context,
          flyer: flyer,
        );
      }

      /// DELETE BZ ON FIREBASE
      await FireBzOps.deleteBzOps(
        context: context,
        bzModel: bzModel,
      );

      /// DELETE BZ ON LDB
      await BzLDBOps.deleteBzOps(
        context: context,
        bzModel: bzModel,
      );
      await UserLDBOps.removeBzIDFromMyBzIDs(
          bzIDToRemove: bzModel.id,
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
      final UsersProvider _usersProvider = Provider.of<UsersProvider>(context, listen: false);
      _usersProvider.removeBzIDFromMyBzzIDs(
        bzIDToRemove: bzModel.id,
        notify: true,
      );


      WaitDialog.closeWaitDialog(context);

      /// re-route back
      Nav.goBackToHomeScreen(context);

      await TopDialog.showTopDialog(
        context: context,
        verse: 'Business Account has been deleted successfully',
        color: Colorz.yellow255,
      );

    }

}
// -----------------------------------------------------------------------------

  /// BZ FLYERS PAGE

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
            onTap: () => _onEditFlyer(flyer),
          ),

          BottomDialog.wideButton(
            context: context,
            verse: 'Delete flyer',
            verseCentered: true,
            onTap: () => _onDeleteFlyer(
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
Future<void> _onEditFlyer(FlyerModel flyer) async {
  blog('should edit flyer');
}
// -----------------------------------------------------------------------------
Future<void> _onDeleteFlyer({
  @required BuildContext context,
  @required FlyerModel flyer,
  @required BzModel bzModel,
}) async {

  blog('_onDeleteFlyer : starting deleting flyer ${flyer.id}');

  final bool _result = await CenterDialog.showCenterDialog(
    context: context,
    title: 'Delete Flyer',
    body: 'This will delete this flyer and all its content and can not be retrieved any more',
    boolDialog: true,
    confirmButtonText: 'Yes Delete Flyer',
    height: 400,
    child: FlyerStarter(
      flyerModel: flyer,
      minWidthFactor: 100,
      heroTag: '',
    ),
  );

  if (_result == true){

    /// TASK : NEED TO CHECK USER PERMISSIONS TO BE ABLE TO CONTINUE DELETION PROCESSES
    /// => IS OWNER OF STORAGE PICS ?

    unawaited(WaitDialog.showWaitDialog(
      context: context,
      loadingPhrase: 'Deleting flyer',
      canManuallyGoBack: false,
    ));

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
      bzCountry: _bzzProvider.myActiveBzCountry,
      bzCity: _bzzProvider.myActiveBzCity,
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

    WaitDialog.closeWaitDialog(context);

    Nav.goBack(context);

    await TopDialog.showTopDialog(
      context: context,
      verse: 'Flyer has been deleted successfully',
      color: Colorz.yellow255,
    );

  }

}
// -----------------------------------------------------------------------------
