import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/secondary_models/contact_model.dart';
import 'package:bldrs/d_providers/active_flyer_provider.dart';
import 'package:bldrs/f_helpers/drafters/launchers.dart' as Launcher;
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// -----------------------------------------------------------------------------
AnimationController initializeHeaderAnimationController({
  @required BuildContext context,
  @required TickerProvider vsync,
}){

  final ActiveFlyerProvider _activeFlyerProvider = Provider.of<ActiveFlyerProvider>(context, listen: false);
  final bool _headerIsExpanded = _activeFlyerProvider.headerIsExpanded;

  // _isExpanded = PageStorage.of(context)?.readState(context) ?? widget.initiallyExpanded;

  final AnimationController _headerAnimationController = AnimationController(
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
void onTriggerHeader({
  @required BuildContext context,
  @required AnimationController headerAnimationController,
  @required ScrollController verticalController,
}) {

  final ActiveFlyerProvider _activeFlyerProvider = Provider.of<ActiveFlyerProvider>(context, listen: false);
  final bool _bzPageIsOn = _activeFlyerProvider.headerIsExpanded;

  blog('_onHeaderTap : bzPageIsOn was : $_bzPageIsOn');

  /// HEADER ANIMATION
  _animateHeaderExpansion(
    context: context,
    headerAnimationController: headerAnimationController,
    verticalController: verticalController,
  );

  /// PROGRESS BAR OPACITY
    _triggerProgressBarOpacity(
      context: context,
      notify: true,
    );

    /// HEADER FADING
    _triggerHeaderPageOpacity(
      context: context,
      notify: true,
    );

    /// HEADER EXPANSION
    _triggerHeaderExpansion(
      context: context,
      notify: true,
    );



  blog('_onHeaderTap : bzPageIsOn is : $_bzPageIsOn');
}
// -------------------------------------------------------
/// PROGRESS BAR OPACITY
void _triggerProgressBarOpacity({
  @required BuildContext context,
  @required bool notify,
}){

  final ActiveFlyerProvider _activeFlyerProvider = Provider.of<ActiveFlyerProvider>(context, listen: false);
  final int _progressBarOpacity = _activeFlyerProvider.progressBarOpacity;

  /// WHEN PROGRESS BAR IS VISIBLE
  if (_progressBarOpacity == 1) {
    _activeFlyerProvider.setProgressBarOpacity(setOpacityTo: 0, notify: notify);
  }

  /// WHEN PROGRESS BAR IS HIDDEN
  else {
    Future<void>.delayed(Ratioz.durationFading210, () {
      _activeFlyerProvider.setProgressBarOpacity(setOpacityTo: 1, notify: notify);
    });
  }

}
// -------------------------------------------------------
/// HEADER IS EXPANDED
void _triggerHeaderExpansion({
  @required BuildContext context,
  @required bool notify,
}) {

  final ActiveFlyerProvider _activeFlyerProvider = Provider.of<ActiveFlyerProvider>(context, listen: false);
  final bool _headerIsExpanded = _activeFlyerProvider.headerIsExpanded;

  _activeFlyerProvider.setHeaderIsExpanded(
    setHeaderIsExpandedTo: !_headerIsExpanded,
    notify: notify,
  );

  /// TASK : MAYBE WILL REMOVE THIS
  PageStorage.of(context)?.writeState(context, !_headerIsExpanded);

}
// -------------------------------------------------------
/// HEADER EXPANSION ANIMATION
void _animateHeaderExpansion({
  @required BuildContext context,
  @required AnimationController headerAnimationController,
  @required ScrollController verticalController,
}){

  final ActiveFlyerProvider _activeFlyerProvider = Provider.of<ActiveFlyerProvider>(context, listen: false);
  final bool _headerIsExpanded = _activeFlyerProvider.headerIsExpanded;

  /// WHEN HEADER IS COLLAPSED
  // TASK : MAYBE NEED TO INVERT THESE METHODS
  if (_headerIsExpanded == false) {
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
/// HEADER PAGE OPACITY
void _triggerHeaderPageOpacity({
  @required BuildContext context,
  @required bool notify,
}) {

  final ActiveFlyerProvider _activeFlyerProvider = Provider.of<ActiveFlyerProvider>(context, listen: false);
  final int _headerPageOpacity = _activeFlyerProvider.headerPageOpacity;

  blog('_headerPageOpacity = $_headerPageOpacity');

  Future<void>.delayed(Ratioz.durationFading200, () {

    /// WHEN PAGE IS VISIBLE
    if (_headerPageOpacity == 1) {
      _activeFlyerProvider.setHeaderPageOpacity(
        setOpacityTo: 0,
        notify: notify,
      );
    }

    /// WHEN HEADER PAGE IS HIDDEN
    else {
      _activeFlyerProvider.setHeaderPageOpacity(
        setOpacityTo: 1,
        notify: notify,
      );
    }

  });
}
// -----------------------------------------------------------------------------
/// ON FOLLOW
Future<void> onFollowTap({
  @required BuildContext context,
  @required BzModel bzModel,
}) async {

  final ActiveFlyerProvider _activeFlyerProvider = Provider.of<ActiveFlyerProvider>(context, listen: false);
  final bool _followIsOn = _activeFlyerProvider.followIsOn;

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
  _activeFlyerProvider.setFollowIsOn(
    setFollowIsOnTo: !_followIsOn,
    notify: true,
  );

}
// -----------------------------------------------------------------------------
/// ON CALL
Future<void> onCallTap({
  @required BuildContext context,
  @required BzModel bzModel,
}) async {

  final String _contact = ContactModel.getAContactValueFromContacts(
      bzModel.contacts,
      ContactType.phone,
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
