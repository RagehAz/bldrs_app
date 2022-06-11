import 'package:flutter/material.dart';
/// --------------------------------------------------------------------------
class NavModel {

  NavModel({
    @required this.title,
    @required this.icon,
    @required this.screen,
  });
  /// --------------------------------------------------------------------------
  final String title;
  final String icon;
  final Widget screen;

/// --------------------------------------------------------------------------
}

class Obelisk {

  Obelisk({
    @required this.areTabs,
    @required this.navModels,
  });

  final bool areTabs;
  final List<NavModel> navModels;


}
