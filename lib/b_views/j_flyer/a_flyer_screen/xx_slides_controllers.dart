import 'package:bldrs/b_views/z_components/app_bar/progress_bar_swiper_model.dart';
import 'package:bldrs/f_helpers/drafters/keyboarders.dart';
import 'package:flutter/material.dart';
// -----------------------------------------------------------------------------
void onHorizontalSlideSwipe({
  @required BuildContext context,
  @required int newIndex,
  @required ValueNotifier<ProgressBarModel> progressBarModel,
}) {

  /// A - if Keyboard is active
  if (Keyboard.keyboardIsOn(context) == true) {

    ProgressBarModel.updateProgressBarNotifierOnIndexChanged(
      context: context,
      progressBarModel: progressBarModel,
      newIndex: newIndex,
      // syncFocusScope: true,
    );

  }

  /// A - if keyboard is not active
  else {
    ProgressBarModel.updateProgressBarNotifierOnIndexChanged(
      context: context,
      progressBarModel: progressBarModel,
      newIndex: newIndex,
      syncFocusScope: false,
    );
  }

}
// -----------------------------------------------------------------------------
