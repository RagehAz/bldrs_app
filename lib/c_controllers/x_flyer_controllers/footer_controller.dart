import 'package:bldrs/a_models/flyer/flyer_model.dart';
import 'package:bldrs/a_models/secondary_models/link_model.dart';
import 'package:bldrs/c_protocols/record_protocols.dart';
import 'package:bldrs/c_protocols/user_protocols/a_user_protocols.dart';
import 'package:bldrs/f_helpers/drafters/launchers.dart';
import 'package:flutter/material.dart';


// -----------------------------------------------------------------------------

/// SAVE

// ----------------------------------
/// TESTED : WORKS PERFECT
Future<void> onSaveFlyer({
  @required BuildContext context,
  @required FlyerModel flyerModel,
  @required ValueNotifier<bool> flyerIsSaved,
  @required int slideIndex,
}) async {

  flyerIsSaved.value = !flyerIsSaved.value;

  await UserProtocols.savingFlyerProtocol(
    context: context,
    flyerID: flyerModel.id,
    bzID: flyerModel.bzID,
    flyerIsSaved: flyerIsSaved.value,
    slideIndex: slideIndex,
  );

}
// -----------------------------------------------------------------------------

/// REVIEW

// ----------------------------------
Future<void> onReviewFlyer({
  @required BuildContext context,
  @required FlyerModel flyerModel,
}) async {

}
// -----------------------------------------------------------------------------

/// SHARE

// ----------------------------------
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

    RecordProtocols.shareFlyer(
      context: context,
      flyerID: flyerModel.id,
      bzID: flyerModel.bzID,
    ),

  ]);


}
// -----------------------------------------------------------------------------

/// REPORT

// ----------------------------------
