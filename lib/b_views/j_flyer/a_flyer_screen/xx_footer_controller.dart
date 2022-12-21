import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/a_models/x_utilities/link_model.dart';
import 'package:bldrs/a_models/a_user/auth_model.dart';
import 'package:bldrs/b_views/j_flyer/c_flyer_reviews_screen/a_flyer_reviews_screen.dart';
import 'package:bldrs/c_protocols/user_protocols/protocols/a_user_protocols.dart';
import 'package:bldrs/c_protocols/flyer_protocols/real/flyer_record_real_ops.dart';
import 'package:bldrs/f_helpers/drafters/launchers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/router/navigators.dart';
import 'package:flutter/material.dart';

// -----------------------------------------------------------------------------

/// SAVE

// --------------------
/// TESTED : WORKS PERFECT
Future<void> onSaveFlyer({
  @required BuildContext context,
  @required FlyerModel flyerModel,
  @required ValueNotifier<bool> flyerIsSaved,
  @required int slideIndex,
  @required bool mounted,
}) async {

  setNotifier(
      notifier: flyerIsSaved,
      mounted: mounted,
      value: !flyerIsSaved.value,
  );

  await UserProtocols.savingFlyerProtocol(
    context: context,
    flyerModel: flyerModel,
    flyerIsSaved: flyerIsSaved.value,
    slideIndex: slideIndex,
  );

}
// -----------------------------------------------------------------------------

/// REVIEW

// --------------------
Future<void> onReviewButtonTap({
  @required BuildContext context,
  @required FlyerModel flyerModel,
}) async {

  await Nav.goToNewScreen(
    context: context,
    screen: FlyerReviewsScreen(
      flyerModel: flyerModel,
    ),
  );

}
// -----------------------------------------------------------------------------

/// SHARE

// --------------------
Future<void> onShareFlyer({
  @required BuildContext context,
  @required FlyerModel flyerModel,
}) async {

  /// TASK : GENERATE FLYER SHARING LINK

  await Future.wait(<Future>[

    Launcher.shareFlyer(
      context: context,
      flyerLink: LinkModel(
        url: 'www.bldrs.net/flyer',
        description: flyerModel.description,
      ),
    ),

    if (AuthModel.userIsSignedIn() == true)
    FlyerRecordRealOps.shareFlyer(
      flyerID: flyerModel.id,
      bzID: flyerModel.bzID,
    ),

  ]);


}
// -----------------------------------------------------------------------------

/// REPORT

// --------------------
