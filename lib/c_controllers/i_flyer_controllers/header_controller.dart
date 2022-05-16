import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/secondary_models/contact_model.dart';
import 'package:bldrs/f_helpers/drafters/launchers.dart' as Launcher;
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';
// -----------------------------------------------------------------------------
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
Future<void> onTriggerHeader({
  @required BuildContext context,
  @required AnimationController headerAnimationController,
  @required ScrollController verticalController,
  @required ValueNotifier<bool> headerIsExpanded,
  @required ValueNotifier<double> progressBarOpacity,
  @required ValueNotifier<double> headerPageOpacity,
}) async {

  /// PROGRESS BAR OPACITY
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
// -------------------------------------------------------
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
// -------------------------------------------------------
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
// // -------------------------------------------------------
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
/// ON FOLLOW
Future<void> onFollowTap({
  @required BuildContext context,
  @required BzModel bzModel,
  @required ValueNotifier<bool> followIsOn,
}) async {


  /// TASK : start follow bz ops
  // final List<String> _updatedBzFollows = await RecordOps.followBzOPs(
  //   context: context,
  //   bzID: _superFlyer.bz.bzID,
  //   userID: superUserID(),
  // );
  //
  // /// add or remove tinyBz from local followed bzz
  // _prof.updatedFollowsInLocalList(_updatedBzFollows);

  /// trigger current follow value
  followIsOn.value = !followIsOn.value;

}
// -----------------------------------------------------------------------------
/// ON CALL
Future<void> onCallTap({
  @required BuildContext context,
  @required BzModel bzModel,
}) async {

  final String _contact = ContactModel.getAContactValueFromContacts(
      contacts: bzModel.contacts,
      contactType: ContactType.phone,
  );

  /// alert user there is no contact to call
  if (_contact == null) {
    blog('no contact here');
  }

  /// or launch call and start call bz ops
  else {

    /// launch call
    await Launcher.launchCall('tel: $_contact');

    /// TASK : start call bz ops
    // await RecordOps.callBzOPs(
    //   context: context,
    //   bzID: _bzID,
    //   userID: _userID,
    //   slideIndex: _superFlyer.currentSlideIndex,
    // );

  }
}
// -----------------------------------------------------------------------------
