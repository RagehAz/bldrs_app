import 'package:flutter/material.dart';
/// --------------------------------------------------------------------------
class NavModel {

  NavModel({
    @required this.title,
    @required this.icon,
    @required this.screen,
    this.iconColor,
    this.iconSizeFactor,
    this.onNavigate,
  });
  /// --------------------------------------------------------------------------
  final String title;
  final String icon;
  final Widget screen;
  final Function onNavigate;
  final Color iconColor;
  final double iconSizeFactor;
/// --------------------------------------------------------------------------
  static List<Widget> getScreens(List<NavModel> navModels){

    final List<Widget> _output = <Widget>[];

    for (final NavModel nav in navModels){
      _output.add(nav.screen);
    }

    return _output;
  }
// -----------------------------------------------------------------------------
  static String getTitleFromNavModels({
    @required List<NavModel> navModels,
    @required int index,
  }){

    return navModels[index].title;


  }

}

class ObeliskModel {
  /// --------------------------------------------------------------------------
  ObeliskModel({
    @required this.areTabs,
    @required this.navModels,
  });
  /// --------------------------------------------------------------------------
  final bool areTabs;
  final List<NavModel> navModels;
/// --------------------------------------------------------------------------
}
