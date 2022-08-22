import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/counters/bz_counter_model.dart';
import 'package:bldrs/a_models/secondary_models/contact_model.dart';
import 'package:bldrs/b_views/z_components/dialogs/center_dialog/center_dialog.dart';
import 'package:bldrs/b_views/z_components/dialogs/dialogz/dialogz.dart';
import 'package:bldrs/c_protocols/note_protocols/a_note_protocols.dart';
import 'package:bldrs/c_protocols/user_protocols/a_user_protocols.dart';
import 'package:bldrs/d_providers/bzz_provider.dart';
import 'package:bldrs/e_db/real/ops/bz_record_real_ops.dart';
import 'package:bldrs/f_helpers/drafters/launchers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// -----------------------------------------------------------------------------

/// EXPANSION INITIALIZATION

// ----------------------------------
AnimationController initializeHeaderAnimationController({
  @required BuildContext context,
  @required TickerProvider vsync,
}){

  // final ActiveFlyerProvider _activeFlyerProvider = Provider.of<ActiveFlyerProvider>(context, listen: false);
  // final bool _headerIsExpanded = _activeFlyerProvider.headerIsExpanded;

  // _isExpanded = PageStorage.of(context)?.readState(context) ?? widget.initiallyExpanded;

  final AnimationController _headerAnimationController = AnimationController(
      reverseDuration: Ratioz.durationFading200,
      duration: Ratioz.durationFading200,
      vsync: vsync
  );

  // if (_headerIsExpanded == true) {
  //   _headerAnimationController.value = 1.0;
  // }
  // else {
  //   _headerAnimationController.value = 0;
  // }

  return _headerAnimationController;
}
// -----------------------------------------------------------------------------

/// ANIMATION TRIGGER

// ----------------------------------
Future<void> onTriggerHeader({
  @required BuildContext context,
  @required AnimationController headerAnimationController,
  @required ScrollController verticalController,
  @required ValueNotifier<bool> headerIsExpanded,
  @required ValueNotifier<double> progressBarOpacity,
  @required ValueNotifier<double> headerPageOpacity,
}) async {

  await _triggerProgressBarOpacity(
    context: context,
    progressBarOpacity: progressBarOpacity,
  );


  /// HEADER ANIMATION
  _animateHeaderExpansion(
    context: context,
    headerAnimationController: headerAnimationController,
    verticalController: verticalController,
    headerIsExpanded: headerIsExpanded,
  );

  /// HEADER EXPANSION
  _triggerHeaderExpansion(
    context: context,
    notify: false,
    headerIsExpanded: headerIsExpanded,
  );

  /// HEADER FADING
  _triggerHeaderPageOpacity(
    context: context,
    notify: false,
    headerPageOpacity: headerPageOpacity,
  );

  blog('_onHeaderTap : headerIsExpanded is : ${headerIsExpanded.value}');
}
// ----------------------------------
Future<void> readBzCounters({
  @required BuildContext context,
  @required String bzID,
  @required ValueNotifier<BzCounterModel> bzCounters,
}) async {

  final BzCounterModel _bzCounters = await BzRecordRealOps.readBzCounters(
    context: context,
    bzID: bzID,
  );

  bzCounters.value = _bzCounters;

}
// ----------------------------------
/// PROGRESS BAR OPACITY
Future<void> _triggerProgressBarOpacity({
  @required BuildContext context,
  @required ValueNotifier<double> progressBarOpacity,
}) async {
  /// progressBarOpacity is used because it has a slight delay after triggering header
  /// AND SO headerIsExpanded can not be used to hold the progress bar opacity value

  /// WHEN PROGRESS BAR IS VISIBLE
  if (progressBarOpacity.value == 1) {
    blog('triggering _progressBarOpacity to 0');
    progressBarOpacity.value = 0;
  }

  /// WHEN PROGRESS BAR IS HIDDEN
  else {
    await Future<void>.delayed(Ratioz.durationFading210, () {
      blog('triggering _progressBarOpacity to 1');
      progressBarOpacity.value = 1;
    });
  }

}
// -------------------------------------------------------
/// HEADER IS EXPANDED
void _triggerHeaderExpansion({
  @required BuildContext context,
  @required bool notify,
  @required ValueNotifier<bool> headerIsExpanded,
}) {

  headerIsExpanded.value = !headerIsExpanded.value;

  /// TASK : MAYBE WILL REMOVE THIS
  PageStorage.of(context)?.writeState(context, headerIsExpanded.value);

}
// -------------------------------------------------------
/// HEADER PAGE OPACITY
void _triggerHeaderPageOpacity({
  @required BuildContext context,
  @required bool notify,
  @required ValueNotifier<double> headerPageOpacity,
}) {

  blog('_headerPageOpacity = ${headerPageOpacity.value}');

  Future<void>.delayed(Ratioz.durationFading200, () {

    /// WHEN PAGE IS VISIBLE
    if (headerPageOpacity.value == 1) {
      headerPageOpacity.value = 0;
    }

    /// WHEN HEADER PAGE IS HIDDEN
    else {
      headerPageOpacity.value = 1;
    }

  });
}
// -----------------------------------------------------------------------------

/// EXPANSION ANIMATION

// ----------------------------------
/// HEADER EXPANSION ANIMATION
void _animateHeaderExpansion({
  @required BuildContext context,
  @required AnimationController headerAnimationController,
  @required ScrollController verticalController,
  @required ValueNotifier<bool> headerIsExpanded,
}){

  /// WHEN HEADER IS COLLAPSED
  // TASK : MAYBE NEED TO INVERT THESE METHODS
  if (headerIsExpanded.value == false) {
    headerAnimationController.forward();
  }

  /// WHEN HEADER IS EXPANDED
  else {
    headerAnimationController.reverse().then<void>((dynamic value) async {

      await verticalController.animateTo(0,
          duration: Ratioz.durationSliding410,
          curve: Curves.easeOut
      );


      /// TASK : SHOOF KEDA EL IMPACT BTA3 DAWWAN
      // setState(() {
      //   // Rebuild without widget.children.
      // });

    });
  }

}
// -----------------------------------------------------------------------------

/// TAPS - BUTTONS

// ----------------------------------
bool checkFollowIsOn({
  @required BuildContext context,
  @required BzModel bzModel,
}){

  final BzzProvider _bzzProvider = Provider.of<BzzProvider>(context, listen: false);

  final _followIsOn = _bzzProvider.checkFollow(
      context: context,
      bzID: bzModel.id
  );

  return _followIsOn;
}
// ----------------------------------
/// ON FOLLOW
Future<void> onFollowTap({
  @required BuildContext context,
  @required BzModel bzModel,
  @required ValueNotifier<bool> followIsOn,
}) async {

  followIsOn.value = !followIsOn.value;

  await UserProtocols.followingProtocol(
    context: context,
    bzID: bzModel.id,
    followIsOn: followIsOn.value,
  );

}
// -----------------------------------------------------------------------------
/// ON CALL
Future<void> onCallTap({
  @required BuildContext context,
  @required BzModel bzModel,
}) async {

  final bool _bzHasContacts = BzModel.checkBzHasContacts(
    bzModel: bzModel,
  );

  /// alert user there is no contact to call
  if (_bzHasContacts == false){

    await CenterDialog.showCenterDialog(
      context: context,
      title: '${bzModel.name} has no available contact',
      body: 'A reminder notification for the business will be sent to request updating their phone number',
    );

    await NoteProtocols.sendNoBzContactAvailableNote(
      context: context,
      bzModel: bzModel,
    );

  }

  else {

    await Dialogz.bzContactsDialog(
        context: context,
        title: 'Contact ${bzModel.name}',
        body: 'Select an Author to contact',
        bzModel: bzModel,
        onContact: (ContactModel contact) async {

          bool _success = false;

          /// PHONE CALL
          if (contact.contactType == ContactType.phone){
            await Launcher.launchCall(contact.value);
            _success = true;
          }

          /// WEB LINK - SOCIAL MEDIA
          else if (ContactModel.checkIsWebLink(contact) == true){
            _success = await Launcher.launchURL(contact.value);
          }

          /// EMAIL
          else if (contact.contactType == ContactType.email){
            /// TASK : LAUNCH EMAIL CONTACT
            blog('onCallTap : SHOULD SEND AN EMAIL TO THIS BITCH : ${contact.value}');
          }

          /// OTHER UNKNOWN
          else {
            blog('onCallTap : CAN NOT LAUNCH THIS CONTACT MAN : ${contact.contactType} : ${contact.value}');
          }

          /// CALL RECORD PROTOCOL
          if (_success == true){
            await BzRecordRealOps.callBz(
              context: context,
              bzID: bzModel.id,
              contact: contact,
            );
          }

        }
    );


  }

}
// -----------------------------------------------------------------------------
