import 'package:bldrs/a_models/b_bz/bz_model.dart';
import 'package:bldrs/a_models/a_user/user_model.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:flutter/material.dart';
import 'package:bldrs/f_helpers/drafters/mappers.dart';

enum MainNavModel {
  signIn,
  questions,
  profile,
  savedFlyers,
  bz,
  zone,
  settings,
}

class NavModel {
  /// --------------------------------------------------------------------------
  const NavModel({
    @required this.id,
    @required this.titleVerse,
    @required this.icon,
    @required this.screen,
    this.iconColor,
    this.iconSizeFactor,
    this.onNavigate,
    this.canShow = true,
    this.forceRedDot = false,
  });
  /// --------------------------------------------------------------------------
  final String id;
  final Verse titleVerse;
  final String icon;
  final Widget screen;
  final Function onNavigate;
  final Color iconColor;
  final double iconSizeFactor;
  /// VISIBILITY BOOLEAN CONDITION : when to show and when not to show
  final bool canShow;
  final bool forceRedDot;
  // -----------------------------------------------------------------------------

  /// GETTERS

  // --------------------
  static List<Widget> getScreens(List<NavModel> navModels){

    final List<Widget> _output = <Widget>[];

    for (final NavModel nav in navModels){
      _output.add(nav.screen);
    }

    return _output;
  }
  // --------------------
  static Verse getTitleVerseFromNavModels({
    @required List<NavModel> navModels,
    @required int index,
  }){

    return navModels[index].titleVerse;

  }
  // --------------------
  static int getNumberOfButtons(List<NavModel> navModels){

    int _count = 0;

    for (final NavModel model in navModels){

      if (model != null){
        _count++;
      }

    }

    return _count;
  }
  // --------------------
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
      case MainNavModel.settings:     return 'settings'; break;
      default: return null;
    }
  }
  // --------------------
  static String getUserTabNavID(UserTab userTab){
    final String _tabID = UserModel.getUserTabID(userTab);
    return 'user_$_tabID';
  }
  // --------------------
  static String getBzTabNavID({
    @required BzTab bzTab,
    @required String bzID,
  }){
    final String _tabID = BzModel.getBzTabPhid(bzTab: bzTab);
    return 'bz_${bzID}_$_tabID';
  }
  // -----------------------------------------------------------------------------

  /// GENERATOR

  // --------------------
  static List<String> generateSuperBzNavIDs({
    @required String bzID,
  }){

    /// NOTE : INCLUDES MAIN NAV MODEL AS WELL AS INTERNAL NAV MODELS

    final String _mainNavModel = getMainNavIDString(
      navID: MainNavModel.bz,
      bzID: bzID,
    );

    final List<String> _bzTabsNavModelsIDs = <String>[];

    for (final BzTab bzTab in BzModel.bzTabsList){
      final String _bzTabNavID = getBzTabNavID(
          bzTab: bzTab,
          bzID: bzID
      );
      _bzTabsNavModelsIDs.add(_bzTabNavID);
    }


    return <String>[_mainNavModel, ..._bzTabsNavModelsIDs];
  }
  // --------------------
  static List<String> generateMainNavModelsIDs({
    @required List<String> myBzzIDs,
  }){

    final List<String> _mainNavModelsIDs = <String>[];

    for (final MainNavModel mainNavModel in mainNavModels){

      if (mainNavModel == MainNavModel.bz){
        if (Mapper.checkCanLoopList(myBzzIDs) == true){
          for (final String bzID in myBzzIDs){
            final String _navID = getMainNavIDString(
              navID: MainNavModel.bz,
              bzID: bzID,
            );
            _mainNavModelsIDs.add(_navID);
          }
        }
      }

      else {
        final String _navID = getMainNavIDString(navID: mainNavModel);
        _mainNavModelsIDs.add(_navID);
      }

    }

    return _mainNavModelsIDs;
  }
  // --------------------
  static List<String> generateUserTabsNavModelsIDs(){

    final List<String> _userTabsNavModelsIDs = <String>[];

    for (final UserTab userTab in UserModel.userProfileTabsList){
      final String _navID = getUserTabNavID(userTab);
      _userTabsNavModelsIDs.add(_navID);
    }

    return _userTabsNavModelsIDs;
  }
  // --------------------
  static List<String> generateBzTabsNavModelsIDs({
    @required String bzID,
  }){

    final List<String> _bzTabsNavModelsIDs = <String>[];

    if (bzID != null){

      for (final BzTab bzTab in BzModel.bzTabsList){
        final String _bzNavID = getBzTabNavID(
            bzTab: bzTab,
            bzID: bzID
        );
        _bzTabsNavModelsIDs.add(_bzNavID);
      }

    }

    return _bzTabsNavModelsIDs;
  }
  // --------------------
  static List<String> generateAllBzzTabsNavModelsIDs({
    @required List<String> myBzzIDs,
  }){

    final List<String> _allBzzTabsNavModelsIDs = <String>[];

    if (Mapper.checkCanLoopList(myBzzIDs) == true){
      for (final String bzID in myBzzIDs){

        final List<String> _bzTabsNavModelsIDs = generateBzTabsNavModelsIDs(
          bzID: bzID,
        );

        _allBzzTabsNavModelsIDs.addAll(_bzTabsNavModelsIDs);

      }
    }

    return _allBzzTabsNavModelsIDs;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<String> generateAllNavModelsIDs({
    @required List<String> myBzzIDs,
  }){

    final List<String> _allNavModelsIDs = <String>[];

    /// MAIN
    final List<String> _mainNavModelsIDs = generateMainNavModelsIDs(
        myBzzIDs: myBzzIDs,
    );
    _allNavModelsIDs.addAll(_mainNavModelsIDs);

    /// USER PROFILE
    final List<String> _userTabsNavModelsIDs = generateUserTabsNavModelsIDs();
      _allNavModelsIDs.addAll(_userTabsNavModelsIDs);

    /// BZZ PROFILES
    final List<String> _allBzzTabsNavModelsIDs = generateAllBzzTabsNavModelsIDs(
      myBzzIDs: myBzzIDs,
    );
    _allNavModelsIDs.addAll(_allBzzTabsNavModelsIDs);

    return _allNavModelsIDs;
  }
  // -----------------------------------------------------------------------------
  static const List<MainNavModel> mainNavModels = <MainNavModel>[
    MainNavModel.signIn,
    MainNavModel.questions,
    MainNavModel.profile,
    MainNavModel.savedFlyers,
    MainNavModel.bz,
    MainNavModel.zone,
    MainNavModel.settings,
  ];
  // -----------------------------------------------------------------------------

  /// OBELISK NUMBERS

  // --------------------
  static int updateObeliskNumber({
    @required int oldNumber,
    @required int change,
    @required bool isIncrementing,
  }){

    int _output;

    /// WHILE INCREASING
    if (isIncrementing == true){

      /// initial null need initialization
      if (oldNumber == null){
        _output = change;
      }

      /// existing number need increase
      else {
        _output = oldNumber + change;
      }

    }

    /// WHILE DECREASING
    else {

      /// initial null keep null
      if (oldNumber == null){
        _output = null;
      }

      /// if one remaining or only zero, need to nullify it not decrease to zero
      else if (oldNumber <= 1){
        _output = null;
      }

      /// if not null nor zero nor one : decrease until 1 then null it
      else {
        _output = oldNumber - change;

        /// null it if result is zero or smaller
        if (_output <= 0){
          _output = null;
        }

      }


    }

    return  _output;
  }
  // -----------------------------------------------------------------------------
}
