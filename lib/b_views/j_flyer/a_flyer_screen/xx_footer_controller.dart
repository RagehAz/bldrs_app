import 'package:basics/helpers/classes/checks/tracers.dart';
import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/b_views/j_flyer/c_flyer_reviews_screen/a_flyer_reviews_screen.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs/c_protocols/recorder_protocols/recorder_protocols.dart';
import 'package:bldrs/c_protocols/user_protocols/protocols/a_user_protocols.dart';
import 'package:bldrs/c_protocols/user_protocols/user/user_provider.dart';
import 'package:bldrs/e_back_end/f_cloud/dynamic_links.dart';
import 'package:bldrs/f_helpers/drafters/launchers.dart';
import 'package:fire/super_fire.dart';
import 'package:basics/helpers/classes/files/filers.dart';
import 'package:flutter/material.dart';
import 'package:basics/layouts/nav/nav.dart';
/// => TAMAM
// -----------------------------------------------------------------------------

/// SAVE

// --------------------
/// TESTED : WORKS PERFECT
Future<void> onSaveFlyer({
  required BuildContext context,
  required FlyerModel flyerModel,
  required ValueNotifier<bool> flyerIsSaved,
  required int slideIndex,
  required bool mounted,
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
  required BuildContext context,
  required FlyerModel flyerModel,
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
  required FlyerModel flyerModel,
  required ValueNotifier<bool> isSharing,
  // required bool mounted,
}) async {

  if (flyerModel != null) {

    final UserModel? _user = UsersProvider.proGetMyUserModel(
      context: getMainContext(),
      listen: false,
    );

    setNotifier(
      notifier: isSharing,
      mounted: true, //mounted,
      value: true,
    );

    String _shareLink = flyerModel.shareLink;
    _shareLink ??= await BldrsShareLink.generateFlyerLink(
      flyerID: flyerModel.id,
      headline: flyerModel.headline,
      flyerType: flyerModel.flyerType,
    );

    await Future.wait(<Future>[

      Launcher.shareURL(
        url: flyerModel.shareLink,
        subject: flyerModel.headline,
      ),

      if (Authing.userIsSignedUp(_user?.signInMethod) == true)
      RecorderProtocols.onShareFlyer(
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

}
// -----------------------------------------------------------------------------
