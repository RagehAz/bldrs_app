// import 'package:bldrs/a_models/flyer/sub/flyer_typer.dart';
// import 'package:bldrs/b_views/z_components/buttons/flyer_type_button.dart';
// import 'package:bldrs/b_views/z_components/tab_bars/bldrs_sliver_tab_bar.dart';
// import 'package:bldrs/c_controllers/e_saves_controller.dart';
// import 'package:bldrs/f_helpers/drafters/iconizers.dart' as Iconizer;
// import 'package:bldrs/f_helpers/drafters/text_generators.dart' as TextGen;
// import 'package:flutter/material.dart';
//
// class SavedFlyersTabBar extends StatelessWidget {
//   /// --------------------------------------------------------------------------
//   const SavedFlyersTabBar({
//     @required this.tabController,
//     @required this.currentFlyerTypeTab,
//     Key key
//   }) : super(key: key);
//   /// --------------------------------------------------------------------------
//   final FlyerType currentFlyerTypeTab;
//   final TabController tabController;
//   /// --------------------------------------------------------------------------
//   bool _isSelected(FlyerType flyerType){
//
//     bool _isSelected = false;
//
//     if (currentFlyerTypeTab == flyerType){
//       _isSelected = true;
//     }
//
//     return _isSelected;
//   }
// // -----------------------------------------------------------------------------
//
//   @override
//   Widget build(BuildContext context) {
//
//     return BldrsSliverTabBar(
//       tabController: tabController,
//       tabs: <Widget>[
//
//         /// IT HAS TO BE LIST.GENERATE ma3lesh
//         ...List.generate(sectionsList.length, (index){
//
//           final FlyerType _flyerType = sectionsList[index];
//           final String _flyerTypeString = cipherFlyerType(_flyerType);
//
//           return
//             FlyerTypeButton(
//               key: ValueKey<String>('saved_flyer_tab_button_$_flyerTypeString'),
//               verse: TextGen.flyerTypePluralStringer(context, _flyerType),
//               icon: Iconizer.flyerTypeIconOff(_flyerType),
//               isSelected: _isSelected(_flyerType),
//               onTap: () => onChangeSavedFlyersTabIndex(
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
