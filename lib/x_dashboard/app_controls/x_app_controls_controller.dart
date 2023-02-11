import 'package:bldrs/a_models/x_utilities/xx_app_controls_model.dart';
import 'package:bldrs/c_protocols/app_state_protocols/provider/general_provider.dart';
import 'package:bldrs/e_back_end/d_ldb/ldb_doc.dart';
import 'package:ldb/ldb.dart';
import 'package:filers/filers.dart';
import 'package:bldrs/c_protocols/app_state_protocols/real/app_controls_real_ops.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// -----------------------------------------------------------------------------
Future<void> switchShowAllFlyersInHomeWall({
  @required BuildContext context,
  @required ValueNotifier<AppControlsModel> appControlsModel,
  @required bool value,
  @required bool mounted,
}) async {

  blog('switch switchShowAllFlyersInHomeWall');

  final AppControlsModel _newModel = appControlsModel.value.copyWith(
    showAllFlyersInHome: value,
  );

  await AppControlsRealOps.updateGlobalAppControls(
    newAppControlsModel: _newModel,
  );

  /// CLEAR LDB
  await LDBOps.deleteAllMapsAtOnce(
    docName: LDBDoc.appControls,
  );

  /// FETCH
  await GeneralProvider.fetchAppControls(
    context: context,
  );

  /// SET IN PROVIDER
  final GeneralProvider _generalProvider = Provider.of<GeneralProvider>(context, listen: false);
  _generalProvider.setAppControls(
      setTo: _newModel,
      notify: true,
  );

  setNotifier(
      notifier: appControlsModel,
      mounted: mounted,
      value: _newModel,
  );

  // await TopDialog.showTopDialog(
  //   context: context,
  //   firstVerse: Verse.plain('show All Flyers In Home updated to : ${_newModel.showAllFlyersInHome}'),
  //   color: Colorz.green255,
  // );

}
// -----------------------------------------------------------------------------
