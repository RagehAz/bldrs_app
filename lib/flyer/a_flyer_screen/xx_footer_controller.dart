import 'dart:async';

import 'package:basics/helpers/checks/tracers.dart';
import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/a_models/f_flyer/flyer_model.dart';
import 'package:bldrs/flyer/c_flyer_reviews_screen/a_flyer_reviews_screen.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:bldrs/c_protocols/records_protocols/recorder_protocols.dart';
import 'package:bldrs/c_protocols/user_protocols/protocols/a_user_protocols.dart';
import 'package:bldrs/c_protocols/user_protocols/user/user_provider.dart';
import 'package:bldrs/e_back_end/f_cloud/dynamic_links.dart';
import 'package:bldrs/f_helpers/drafters/launchers.dart';
import 'package:bldrs/f_helpers/router/d_bldrs_nav.dart';
import 'package:fire/super_fire.dart';
import 'package:flutter/material.dart';
/// => TAMAM
// -----------------------------------------------------------------------------

/// SAVE

// --------------------
/// TESTED : WORKS PERFECT
Future<void> onSaveFlyer({
  required FlyerModel? flyerModel,
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
  required FlyerModel? flyerModel,
}) async {

  await BldrsNav.goToNewScreen(
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
  required FlyerModel? flyerModel,
  required int slideIndex,
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

    String? _shareLink = flyerModel.shareLink;
    _shareLink ??= await BldrsShareLink.generateFlyerLink(
      flyerID: flyerModel.id,
      headline: flyerModel.headline,
      flyerType: flyerModel.flyerType,
    );

    blog('_shareLink : $_shareLink');

    final bool _success = await  Launcher.shareURL(
      url: _shareLink,
      subject: flyerModel.headline,
    );

    if (_success == true && Authing.userIsSignedUp(_user?.signInMethod) == true) {
      unawaited(RecorderProtocols.onShareFlyer(
        flyerID: flyerModel.id,
        bzID: flyerModel.bzID,
        slideIndex: slideIndex,
      ));
    }

    setNotifier(
      notifier: isSharing,
      mounted: true, //mounted,
      value: false,
    );

  }

}
// -----------------------------------------------------------------------------
