// import 'package:bldrs/a_models/bz/bz_model.dart';
// import 'package:bldrs/z_components/buttons/flyer_type_button.dart';
// import 'package:bldrs/z_components/tab_bars/bldrs_sliver_tab_bar.dart';
// import 'package:bldrs/c_controllers/f_bz_controllers/x0_my_bz_screen_controllers.dart';
// import 'package:flutter/material.dart';
//
//
// class MyBzScreenTabBar extends StatelessWidget {
//   /// --------------------------------------------------------------------------
//   const MyBzScreenTabBar({
//     required this.tabController,
//     required this.currentBzTab,
//     Key key
//   }) : super(key: key);
//   /// --------------------------------------------------------------------------
//   final TabController tabController;
//   final BzTab currentBzTab;
//   /// --------------------------------------------------------------------------
//   bool _isSelected({
//     required BuildContext context,
//     required BzTab bzTab
//   }){
//
//     bool _isSelected = false;
//
//     if (currentBzTab == bzTab){
//       _isSelected = true;
//     }
//
//     return _isSelected;
//   }
// // -----------------------------------------------------------------------------
// // -----------------------------------------------------------------------------
//   @override
//   Widget build(BuildContext context) {
//
//     return BldrsSliverTabBar(
//       tabController: tabController,
//       tabs: <Widget>[
//
//         /// IT HAS TO BE LIST.GENERATE ma3lesh
//         ...List.generate(BzModel.bzTabsList.length, (index){
//
//           final BzTab _bzTab = BzModel.bzTabsList[index];
//
//           final String _bzTabTranslation = BzModel.translateBzTab(
//             bzTab: _bzTab,
//             context: context,
//           );
//
//           final String _bzTabID = BzModel.getBzTabID(bzTab: _bzTab);
//
//
//           return
//             FlyerTypeButton(
//               key: ValueKey<String>('bz_tab_button_$_bzTabID'),
//               verse: _bzTabTranslation,
//               icon: BzModel.getBzTabIcon(_bzTab),
//               iconSizeFactor: 0.6,
//               isSelected: _isSelected(
//                 context: context,
//                 bzTab: _bzTab,
//               ),
//               onTap: () => onChangeMyBzScreenTabIndex(
//                 context: context,
//                 tabController: tabController,
//                 index: index,
//               ),
//             );
//
//         }),
//
//       ],
//     );
//   }
// }
