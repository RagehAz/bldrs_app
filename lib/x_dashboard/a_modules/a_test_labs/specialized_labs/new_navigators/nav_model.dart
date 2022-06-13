import 'package:flutter/material.dart';

class NavModel {
  /// --------------------------------------------------------------------------
  NavModel({
    @required this.title,
    @required this.icon,
    @required this.screen,
    this.iconColor,
    this.iconSizeFactor,
    this.onNavigate,
    this.canShow = true,
  });
  /// --------------------------------------------------------------------------
  final String title;
  final String icon;
  final Widget screen;
  final Function onNavigate;
  final Color iconColor;
  final double iconSizeFactor;
  /// VISIBILITY BOOLEAN CONDITION : when to show and when not to show
  final bool canShow;
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
// -----------------------------------------------------------------------------
  static int getNumberOfButtons(List<NavModel> navModels){

    int _count = 0;

    for (final NavModel model in navModels){

      if (model != null){
        _count++;
      }

    }

    return _count;
  }
// -----------------------------------------------------------------------------
}
