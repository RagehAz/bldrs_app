// import 'package:basics/bldrs_theme/classes/iconz.dart';
// import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
// import 'package:flutter/material.dart';
//
// enum BzTab{
//   flyers,
//   about,
//   team,
//   notes,
//   // targets,
//   // powers,
//   // network,
//   settings,
// }
// /// => TAMAM
// class BzTabber {
//   // -----------------------------------------------------------------------------
//
//   const BzTabber();
//
//   // -----------------------------------------------------------------------------
//
//   /// BZ TABS
//
//   // --------------------
//   /// TESTED: WORKS PERFECT
//   static int getBzTabIndex(BzTab bzTab){
//     final int _index = bzTabsList.indexWhere((tab) => tab == bzTab);
//     return _index;
//   }
//   // --------------------
//   /// TESTED: WORKS PERFECT
//   static const List<BzTab> bzTabsList = <BzTab>[
//     BzTab.about,
//     BzTab.flyers,
//     BzTab.team,
//     BzTab.notes,
//     // BzTab.targets,
//     // BzTab.powers,
//     // BzTab.network,
//     BzTab.settings,
//   ];
//   // --------------------
//   /// TAMAM : WORKS PERFECT
//   static String? getBzTabID(BzTab? bzTab){
//     switch(bzTab){
//       case BzTab.about        : return  'about'     ;
//       case BzTab.flyers       : return  'flyers'    ;
//       case BzTab.team         : return  'team'      ;
//       case BzTab.notes        : return  'notes'     ;
//       case BzTab.settings     : return  'settings'  ;
//       default: return null;
//     }
//   }
//   // --------------------
//   /// TESTED: WORKS PERFECT
//   static String? getBzTabPhid({
//     required BzTab? bzTab,
//   }){
//     switch(bzTab){
//       case BzTab.about    : return 'phid_info';
//       case BzTab.flyers   : return 'phid_flyers';
//       case BzTab.team  : return 'phid_team';
//       case BzTab.notes    : return 'phid_notifications';
//       // case BzTab.targets  : return 'phid_targets'  ; break;
//       // case BzTab.powers   : return 'phid_powers'  ; break;
//       // case BzTab.network  : return 'phid_network'  ; break;
//       case BzTab.settings : return 'phid_settings';
//       default : return null;
//     }
//   }
//   // --------------------
//   /// TAMAM : WORKS PERFECT
//   static Verse translateBzTab(BzTab bzTab){
//     final String? _tabPhraseID = getBzTabPhid(bzTab: bzTab)!;
//     return Verse(
//       id: _tabPhraseID,
//       translate: true,
//     );
//   }
//   // --------------------
//   /// TESTED: WORKS PERFECT
//   static String getBzTabIcon(BzTab bzTab){
//     switch(bzTab){
//       case BzTab.flyers   : return Iconz.flyerGrid;
//       case BzTab.about    : return Iconz.info;
//       case BzTab.team  : return Iconz.bz;
//       case BzTab.notes    : return Iconz.notification;
//       // case BzTab.targets  : return Iconz.target     ;
//       // case BzTab.powers   : return Iconz.power      ;
//       // case BzTab.network  : return Iconz.follow     ;
//       case BzTab.settings : return Iconz.gears;
//     }
//   }
//   // --------------------
//   /// TESTED: WORKS PERFECT
//   static String? getTabTitle({
//     required int index,
//     required BuildContext context,
//   }){
//     final BzTab _bzTab = bzTabsList[index];
//     final String? _bzTabPhid = getBzTabPhid(
//       bzTab: _bzTab,
//     );
//     return _bzTabPhid;
//   }
//   // -----------------------------------------------------------------------------
// }
