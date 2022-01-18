import 'package:bldrs/d_providers/active_flyer_provider.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/theme/ratioz.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// -----------------------------------------------------------------------------
void onTriggerHeader({
  @required BuildContext context,
  @required AnimationController headerAnimationController,
}) {

  final ActiveFlyerProvider _activeFlyerProvider = Provider.of<ActiveFlyerProvider>(context, listen: false);
  final bool _bzPageIsOn = _activeFlyerProvider.headerIsExpanded;

  blog('_onHeaderTap : bzPageIsOn was : $_bzPageIsOn');

    /// PROGRESS BAR OPACITY
    _triggerProgressBarOpacity(
      context: context,
      notify: false,
    );

    /// HEADER FADING
    _triggerHeaderPageOpacity(
      context: context,
      notify: false,
    );

    /// HEADER EXPANSION
    _triggerHeaderExpansion(
      context: context,
      notify: true,
    );

    /// HEADER ANIMATION
    _animateHeaderExpansion(
        context: context,
        headerAnimationController: headerAnimationController,
    );


  blog('_onHeaderTap : bzPageIsOn is : $_bzPageIsOn');
}
// -----------------------------------------------------------------------------
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
// -----------------------------------------------------------------------------
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
// -----------------------------------------------------------------------------
/// HEADER EXPANSION ANIMATION
void _animateHeaderExpansion({
  @required BuildContext context,
  @required AnimationController headerAnimationController,
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

      /// TASK : SHOOF KEDA EL IMPACT BTA3 DAWWAN
      // setState(() {
      //   // Rebuild without widget.children.
      // });

    });
  }


}
// -----------------------------------------------------------------------------
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
Future<void> onFollowTap() async {

}

Future<void> onCallTap() async {

}