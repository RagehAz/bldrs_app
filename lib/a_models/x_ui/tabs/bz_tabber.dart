import 'package:basics/bldrs_theme/classes/iconz.dart';
import 'package:flutter/material.dart';

enum BzTab{
  flyers,
  about,
  team,
  notes,
  // targets,
  // powers,
  // network,
  settings,
}
/// => TAMAM
class BzTabber {
  // -----------------------------------------------------------------------------

  const BzTabber();

  // -----------------------------------------------------------------------------

  /// BZ TABS

  // --------------------
  /// TESTED: WORKS PERFECT
  static int getBzTabIndex(BzTab bzTab){
    final int _index = bzTabsList.indexWhere((tab) => tab == bzTab);
    return _index;
  }
  // --------------------
  /// TESTED: WORKS PERFECT
  static const List<BzTab> bzTabsList = <BzTab>[
    BzTab.about,
    BzTab.flyers,
    BzTab.team,
    BzTab.notes,
    // BzTab.targets,
    // BzTab.powers,
    // BzTab.network,
    BzTab.settings,
  ];
  // --------------------
  /*
//   /// CAUTION : THESE TITLES CAN NOT BE TRANSLATED DUE TO THEIR USE IN WIDGET KEYS
//   static const List<String> bzPagesTabsTitlesInEnglishOnly = <String>[
//     'Flyers',
//     'About',
//     'Authors',
//     'Notifications',
//     'Targets',
//     'Powers',
//     'Network',
//     'settings',
//   ];
   */
  // --------------------
  /// TESTED: WORKS PERFECT
  static String? getBzTabPhid({
    required BzTab? bzTab,
  }){
    switch(bzTab){
      case BzTab.flyers   : return 'phid_flyers';
      case BzTab.about    : return 'phid_info';
      case BzTab.team  : return 'phid_team';
      case BzTab.notes    : return 'phid_notifications';
      // case BzTab.targets  : return 'phid_targets'  ; break;
      // case BzTab.powers   : return 'phid_powers'  ; break;
      // case BzTab.network  : return 'phid_network'  ; break;
      case BzTab.settings : return 'phid_settings';
      default : return null;
    }
  }
  // --------------------
  /// TESTED: WORKS PERFECT
  static String getBzTabIcon(BzTab bzTab){
    switch(bzTab){
      case BzTab.flyers   : return Iconz.flyerGrid;
      case BzTab.about    : return Iconz.info;
      case BzTab.team  : return Iconz.bz;
      case BzTab.notes    : return Iconz.notification;
      // case BzTab.targets  : return Iconz.target     ;
      // case BzTab.powers   : return Iconz.power      ;
      // case BzTab.network  : return Iconz.follow     ;
      case BzTab.settings : return Iconz.gears;
    }
  }
  // --------------------
  /// TESTED: WORKS PERFECT
  static String? getTabTitle({
    required int index,
    required BuildContext context,
  }){
    final BzTab _bzTab = bzTabsList[index];
    final String? _bzTabPhid = getBzTabPhid(
      bzTab: _bzTab,
    );
    return _bzTabPhid;
  }
  // -----------------------------------------------------------------------------
}
