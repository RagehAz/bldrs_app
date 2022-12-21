import 'package:bldrs/b_views/z_components/dialogs/top_dialog/top_dialog.dart';

import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/c_protocols/app_state_protocols/real/app_controls_real_ops.dart';
import 'package:bldrs/x_dashboard/app_controls/xx_app_controls_model.dart';
import 'package:flutter/material.dart';
// -----------------------------------------------------------------------------
Future<void> switchOnlyShowVerifiedFlyersInHomeWall({
  @required BuildContext context,
  @required ValueNotifier<AppControlsModel> appControlsModel,
  @required bool value,
  @required bool mounted,
}) async {

  blog('switch switchWallFlyersAuditState');

  setNotifier(
      notifier: appControlsModel,
      mounted: mounted,
      value: appControlsModel.value.copyWith(
        showOnlyVerifiedFlyersInHomeWall: value,
      ),
  );

  await AppControlsRealOps.updateGlobalAppControls(
    newAppControlsModel: appControlsModel.value,
  );

  await TopDialog.showTopDialog(
    context: context,
    firstVerse: Verse.plain('showOnlyVerifiedFlyersInHomeWall updated to : $value'),
    color: Colorz.green255,
  );

}
// -----------------------------------------------------------------------------
