import 'package:bldrs/a_models/bz/bz_model.dart';
import 'package:bldrs/a_models/user/user_model.dart';
import 'package:flutter/material.dart';

class NavModel {
  /// --------------------------------------------------------------------------
  NavModel({
    @required this.id,
    @required this.title,
    @required this.icon,
    @required this.screen,
    this.iconColor,
    this.iconSizeFactor,
    this.onNavigate,
    this.canShow = true,
  });
  /// --------------------------------------------------------------------------
  final String id;
  final String title;
  final String icon;
  final Widget screen;
  final Function onNavigate;
  final Color iconColor;
  final double iconSizeFactor;
  /// VISIBILITY BOOLEAN CONDITION : when to show and when not to show
  final bool canShow;
// -----------------------------------------------------------------------------

  /// GETTERS

// -------------------------------------
  static List<Widget> getScreens(List<NavModel> navModels){

    final List<Widget> _output = <Widget>[];

    for (final NavModel nav in navModels){
      _output.add(nav.screen);
    }

    return _output;
  }
// -------------------------------------
  static String getTitleFromNavModels({
    @required List<NavModel> navModels,
    @required int index,
  }){

    return navModels[index].title;


  }
// -------------------------------------
  static int getNumberOfButtons(List<NavModel> navModels){

    int _count = 0;

    for (final NavModel model in navModels){

      if (model != null){
        _count++;
      }

    }

    return _count;
  }
// -------------------------------------
  static String getMainNavIDString({
    @required MainNavModel navID,
    String bzID,
  }){
    switch (navID){
      case MainNavModel.signIn:       return 'sign_in'; break;
      case MainNavModel.questions:    return 'questions'; break;
      case MainNavModel.profile:      return 'profile'; break;
      case MainNavModel.savedFlyers:  return 'savedFlyers'; break;
      case MainNavModel.bz:           return 'bz_$bzID'; break;
      case MainNavModel.zone:         return 'zone'; break;
      default: return null;
    }
  }
// -------------------------------------
  static String getUserTabNavID(UserTab userTab){
    final String _tabID = UserModel.getUserTabID(userTab);
    return 'user_$_tabID';
  }
// -------------------------------------
  static String getBzTabNavID({
    @required BzTab bzTab,
    @required String bzID,
  }){
    final String _tabID = BzModel.getBzTabID(bzTab: bzTab);
    return 'bz_${bzID}_$_tabID';
  }
// -----------------------------------------------------------------------------

/// LISTS

// -------------------------------------
//   static const List<String> allNavModelsIDs = <String>[
//     'sign'
//   ];
}

enum MainNavModel {
  signIn,
  questions,
  profile,
  savedFlyers,
  bz,
  zone,
}
