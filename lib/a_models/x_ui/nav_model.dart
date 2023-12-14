import 'package:basics/helpers/classes/maps/lister.dart';
import 'package:bldrs/a_models/x_ui/tabs/bz_tabber.dart';
import 'package:bldrs/a_models/x_ui/tabs/user_tabber.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:flutter/material.dart';

enum MainNavModel {
  signIn,
  questions,
  profile,
  savedFlyers,
  bz,
  zone,
  onBoarding,
  settings,
}
/// => TAMAM
class NavModel {
  /// --------------------------------------------------------------------------
  const NavModel({
    required this.id,
    required this.titleVerse,
    required this.icon,
    required this.screen,
    this.iconColor,
    this.iconSizeFactor,
    this.onNavigate,
    this.canShow = true,
    this.forceRedDot = false,
  });
  /// --------------------------------------------------------------------------
  final String? id;
  final Verse? titleVerse;
  final dynamic icon;
  final dynamic screen;
  final Function? onNavigate;
  final Color? iconColor;
  final double? iconSizeFactor;
  /// VISIBILITY BOOLEAN CONDITION : when to show and when not to show
  final bool? canShow;
  final bool? forceRedDot;
  // -----------------------------------------------------------------------------

  /// GETTERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static List<Widget> getScreens(List<NavModel> navModels){

    final List<Widget> _output = <Widget>[];

    for (final NavModel nav in navModels){
      _output.add(nav.screen);
    }

    return _output;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static Verse? getTitleVerseFromNavModels({
    required List<NavModel> navModels,
    required int index,
  }){

    return navModels[index].titleVerse;

  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static int getNumberOfButtons(List<NavModel> navModels){

    int _count = 0;

    for (final NavModel? model in navModels){

      if (model != null){
        _count++;
      }

    }

    return _count;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String? getMainNavIDString({
    required MainNavModel navID,
    String? bzID,
  }){
    switch (navID){
      case MainNavModel.signIn:       return 'sign_in';
      case MainNavModel.questions:    return 'questions';
      case MainNavModel.profile:      return 'profile';
      case MainNavModel.savedFlyers:  return 'savedFlyers';
      case MainNavModel.bz:           return 'bz_$bzID';
      case MainNavModel.zone:         return 'zone';
      case MainNavModel.onBoarding:   return 'onBoarding';
      case MainNavModel.settings:     return 'settings';
      default: return null;
    }
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String getUserTabNavID(UserTab userTab){
    final String? _tabID = UserTabber.getUserTabID(userTab);
    return 'user_$_tabID';
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static String getBzTabNavID({
    required BzTab bzTab,
    required String? bzID,
  }){
    final String? _tabID = BzTabber.getBzTabPhid(bzTab: bzTab);
    return 'bz_${bzID}_$_tabID';
  }
  // -----------------------------------------------------------------------------

  /// GENERATOR

  // --------------------
  /// TESTED : WORKS PERFECT
  static List<String> generateSuperBzNavIDs({
    required String? bzID,
  }){

    /// NOTE : INCLUDES MAIN NAV MODEL AS WELL AS INTERNAL NAV MODELS

    final String? _mainNavModel = getMainNavIDString(
      navID: MainNavModel.bz,
      bzID: bzID,
    );

    final List<String> _bzTabsNavModelsIDs = <String>[];

    for (final BzTab bzTab in BzTabber.bzTabsList){
      final String _bzTabNavID = getBzTabNavID(
          bzTab: bzTab,
          bzID: bzID
      );
      _bzTabsNavModelsIDs.add(_bzTabNavID);
    }


    return <String>[
      if (_mainNavModel != null)
      _mainNavModel,
      ..._bzTabsNavModelsIDs
    ];
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<String> generateMainNavModelsIDs({
    required List<String> myBzzIDs,
  }){

    final List<String> _mainNavModelsIDs = <String>[];

    for (final MainNavModel mainNavModel in mainNavModels){

      if (mainNavModel == MainNavModel.bz){
        if (Lister.checkCanLoop(myBzzIDs) == true){
          for (final String bzID in myBzzIDs){
            final String? _navID = getMainNavIDString(
              navID: MainNavModel.bz,
              bzID: bzID,
            );
            if (_navID != null){
              _mainNavModelsIDs.add(_navID);
            }
          }
        }
      }

      else {
        final String? _navID = getMainNavIDString(navID: mainNavModel);
        if (_navID != null){
          _mainNavModelsIDs.add(_navID);
        }
      }

    }

    return _mainNavModelsIDs;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<String> generateUserTabsNavModelsIDs(){

    final List<String> _userTabsNavModelsIDs = <String>[];

    for (final UserTab userTab in UserTabber.userProfileTabsList){
      final String _navID = getUserTabNavID(userTab);
      _userTabsNavModelsIDs.add(_navID);
    }

    return _userTabsNavModelsIDs;
  }
  // --------------------
  /// TESTED : WORKS PERFECT
  static List<String> generateBzTabsNavModelsIDs({
    required String? bzID,
  }){

    final List<String> _bzTabsNavModelsIDs = <String>[];

    if (bzID != null){

      for (final BzTab bzTab in BzTabber.bzTabsList){
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
  /// TESTED : WORKS PERFECT
  static List<String> generateAllBzzTabsNavModelsIDs({
    required List<String> myBzzIDs,
  }){

    final List<String> _allBzzTabsNavModelsIDs = <String>[];

    if (Lister.checkCanLoop(myBzzIDs) == true){
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
    required List<String> myBzzIDs,
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
    MainNavModel.onBoarding,
    MainNavModel.settings,
  ];
  // -----------------------------------------------------------------------------

  /// OBELISK NUMBERS

  // --------------------
  /// TESTED : WORKS PERFECT
  static int? updateObeliskNumber({
    required int? oldNumber,
    required int change,
    required bool isIncrementing,
  }){

    int? _output;

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
