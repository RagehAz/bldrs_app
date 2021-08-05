import 'package:bldrs/controllers/drafters/sliders.dart';
import 'package:flutter/material.dart';

class FlyerNavigator {
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
  SwipeDirection swipeDirection; // FlyerNavigation
  bool bzPageIsOn; // FlyerNavigation
  bool listenToSwipe; // FlyerNavigation

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

    /// animation parameters
    @required this.progressBarOpacity,
    @required this.swipeDirection,
    @required this.bzPageIsOn,
    @required this.listenToSwipe,

  });

}