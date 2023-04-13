import 'package:bldrs/super_fire/super_fire.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/b_views/j_flyer/c_flyer_reviews_screen/a_flyer_reviews_screen.dart';
import 'package:bldrs/c_protocols/flyer_protocols/real/flyer_record_real_ops.dart';
import 'package:bldrs/c_protocols/user_protocols/protocols/a_user_protocols.dart';
import 'package:bldrs/e_back_end/f_cloud/dynamic_links.dart';
import 'package:bldrs/f_helpers/drafters/launchers.dart';
import 'package:filers/filers.dart';
import 'package:flutter/material.dart';
import 'package:layouts/layouts.dart';
/// => TAMAM
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
/// TESTED : WORKS PERFECT
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
/// TESTED : WORKS PERFECT
Future<void> onShareFlyer({
  @required BuildContext context,
  @required FlyerModel flyerModel,
  @required ValueNotifier<bool> isSharing,
  // @required bool mounted,
}) async {

  setNotifier(
      notifier: isSharing,
      mounted: true, //mounted,
      value: true,
  );

  final String _flyerLink = await BldrsShareLink.generateFlyerLink(
      context: context,
      flyerID: flyerModel.id,
  );

  await Future.wait(<Future>[

    Launcher.shareURL(
      context: context,
      url: _flyerLink,
      subject: flyerModel.headline,
    ),

    if (Authing.userIsSignedIn() == true)
    FlyerRecordRealOps.shareFlyer(
      flyerID: flyerModel.id,
      bzID: flyerModel.bzID,
    ),

  ]);

  setNotifier(
    notifier: isSharing,
    mounted: true, //mounted,
    value: false,
  );

}
// -----------------------------------------------------------------------------

/// REPORT

// --------------------
