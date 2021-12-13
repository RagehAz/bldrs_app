import 'package:bldrs/f_helpers/drafters/sliders.dart' as Sliders;
import 'package:flutter/material.dart';

class FlyerNavigator {
  /// --------------------------------------------------------------------------
  FlyerNavigator({
    /// animation controller
    @required this.horizontalController,
    @required this.verticalController,
    @required this.infoScrollController,

    /// animation functions
    @required this.onHorizontalSlideSwipe,
    @required this.onVerticalPageSwipe,
    @required this.onVerticalPageBack,
    @required this.onHeaderTap,
    @required this.onSlideRightTap,
    @required this.onSlideLeftTap,
    @required this.onSwipeFlyer,
    @required this.onTinyFlyerTap,
    @required this.onSaveInfoScrollOffset,
    @required this.getInfoScrollOffset,

    /// animation parameters
    @required this.progressBarOpacity,
    @required this.swipeDirection,
    @required this.bzPageIsOn,
    @required this.listenToSwipe,
  });

  /// --------------------------------------------------------------------------
  /// animation controller
  final PageController horizontalController; // FlyerNavigation
  final PageController verticalController; // FlyerNavigation
  final ScrollController infoScrollController; // FlyerNavigation
  /// animation functions
  final Function onHorizontalSlideSwipe; // FlyerNavigation
  final Function onVerticalPageSwipe; // FlyerNavigation
  final Function onVerticalPageBack; // FlyerNavigation
  final Function onHeaderTap; // FlyerNavigation
  final Function onSlideRightTap; // FlyerNavigation
  final Function onSlideLeftTap; // FlyerNavigation
  final Function onSwipeFlyer; // FlyerNavigation
  final Function onTinyFlyerTap; // FlyerNavigation
  /// animation parameters
  double progressBarOpacity; // FlyerNavigation
  Sliders.SwipeDirection swipeDirection; // FlyerNavigation
  bool bzPageIsOn; // FlyerNavigation
  bool listenToSwipe; // FlyerNavigation

  final Function onSaveInfoScrollOffset;
  final Function getInfoScrollOffset;

  /// --------------------------------------------------------------------------
}
