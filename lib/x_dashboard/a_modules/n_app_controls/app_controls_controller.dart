import 'package:bldrs/b_views/z_components/dialogs/top_dialog/top_dialog.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/x_dashboard/a_modules/n_app_controls/app_controls_fire_ops.dart';
import 'package:bldrs/x_dashboard/a_modules/n_app_controls/app_controls_model.dart';
import 'package:flutter/material.dart';
// -----------------------------------------------------------------------------
Future<void> switchOnlyShowVerifiedFlyersInHomeWall({
  @required BuildContext context,
  @required ValueNotifier<AppControlsModel> appControlsModel,
  @required bool value,
}) async {

  blog('switch switchWallFlyersAuditState');
  appControlsModel.value = appControlsModel.value.copyWith(
    showOnlyVerifiedFlyersInHomeWall: value,
  );

  await AppControlsFireOps.updateAppControls(
    context: context,
    newAppControlsModel: appControlsModel.value,
  );

  TopDialog.showUnawaitedTopDialog(
    context: context,
    firstLine: 'showOnlyVerifiedFlyersInHomeWall updated to : $value',
    color: Colorz.green255,
  );

}
// -----------------------------------------------------------------------------
