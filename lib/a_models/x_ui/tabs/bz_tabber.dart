import 'package:bldrs/f_helpers/theme/iconz.dart';
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
    BzTab.flyers,
    BzTab.about,
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
  static String getBzTabPhid({
    @required BzTab bzTab,
  }){
    switch(bzTab){
      case BzTab.flyers   : return 'phid_flyers'  ; break;
      case BzTab.about    : return 'phid_info'  ; break;
      case BzTab.team  : return 'phid_team'  ; break;
      case BzTab.notes    : return 'phid_notifications'  ; break;
      // case BzTab.targets  : return 'phid_targets'  ; break;
      // case BzTab.powers   : return 'phid_powers'  ; break;
      // case BzTab.network  : return 'phid_network'  ; break;
      case BzTab.settings : return 'phid_settings' ; break;
      default : return null;
    }
  }
  // --------------------
  /// TESTED: WORKS PERFECT
  static String getBzTabIcon(BzTab bzTab){
    switch(bzTab){
      case BzTab.flyers   : return Iconz.flyerGrid  ; break;
      case BzTab.about    : return Iconz.info       ; break;
      case BzTab.team  : return Iconz.bz         ; break;
      case BzTab.notes    : return Iconz.notification       ; break;
      // case BzTab.targets  : return Iconz.target     ; break;
      // case BzTab.powers   : return Iconz.power      ; break;
      // case BzTab.network  : return Iconz.follow     ; break;
      case BzTab.settings : return Iconz.gears      ; break;
      default : return null;
    }
  }
  // --------------------
  /// TESTED: WORKS PERFECT
  static String getTabTitle({
    @required int index,
    @required BuildContext context,
  }){
    final BzTab _bzTab = bzTabsList[index];
    final String _bzTabPhid = getBzTabPhid(
      bzTab: _bzTab,
    );
    return _bzTabPhid;
  }
  // -----------------------------------------------------------------------------
}
