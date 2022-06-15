// import 'package:bldrs/a_models/flyer/flyer_model.dart';
// import 'package:bldrs/a_models/flyer/sub/flyer_typer.dart';
// import 'package:bldrs/b_views/widgets/specific/flyer/stacks/saved_flyers_grid.dart';
// import 'package:bldrs/c_controllers/saves_screen_controller.dart';
// import 'package:flutter/material.dart';
//
// class SavedFlyersScreenViewPagesInTabView extends StatelessWidget {
//   /// --------------------------------------------------------------------------
//   const SavedFlyersScreenViewPagesInTabView({
//     @required this.tabController,
//     @required this.savedFlyers,
//     @required this.selectionMode,
//     @required this.selectedFlyers,
//     Key key
//   }) : super(key: key);
//   /// --------------------------------------------------------------------------
//   final TabController tabController;
//   final List<FlyerModel> savedFlyers;
//   final bool selectionMode;
//   final List<FlyerModel> selectedFlyers;
//   /// --------------------------------------------------------------------------
//   @override
//   Widget build(BuildContext context) {
//     return TabBarView(
//       physics: const BouncingScrollPhysics(),
//       controller: tabController,
//       children: <Widget>[
//
//         /// IT HAS TO BE LIST.GENERATE (ma3lesh agebha ymeen shmal mesh gayya)
//         ...List.generate(sectionsList.length, (index){
//
//           final FlyerType _flyerType = sectionsList[index];
//           final String _flyerTypeString = cipherFlyerType(_flyerType);
//
//           final List<FlyerModel> _flyersOfThisType = FlyerModel.filterFlyersByFlyerType(
//             flyers: savedFlyers,
//             flyerType: _flyerType,
//           );
//
//           return
//             SavedFlyersGrid(
//               key: ValueKey<String>('Saved_flyers_page_$_flyerTypeString'),
//               selectionMode: selectionMode,
//               onSelectFlyer: (FlyerModel flyer) => onSelectFlyerFromSavedFlyers(
//                 context: context,
//                 flyer: flyer,
//               ),
//               selectedFlyers: selectedFlyers,
//               flyers: _flyersOfThisType,
//             );
//
//         }),
//
//       ],
//     );
//   }
// }
