import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class DashButtonModel {
  /// --------------------------------------------------------------------------
  const DashButtonModel({
    @required this.verse,
    @required this.icon,
    @required this.screen,
    this.transitionType,
  });
  /// --------------------------------------------------------------------------
  final String verse;
  final String icon;
  final Widget screen;
  final PageTransitionType transitionType;
/// --------------------------------------------------------------------------
}
