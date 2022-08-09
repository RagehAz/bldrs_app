// import 'package:bldrs/a_models/chain/spec_models/spec_model.dart';
// import 'package:bldrs/a_models/chain/spec_models/spec_picker_model.dart';
// import 'package:bldrs/b_views/z_components/layouts/navigation/scroller.dart';
// import 'package:bldrs/b_views/z_components/specs/pickers_group.dart';
// import 'package:bldrs/c_controllers/g_bz_controllers/e_flyer_maker/c_specs_picker_controllers.dart';
// import 'package:bldrs/f_helpers/drafters/scalers.dart';
// import 'package:bldrs/f_helpers/theme/ratioz.dart';
// import 'package:flutter/material.dart';
//
// class SpecsSelectorScreenView extends StatelessWidget {
// /// --------------------------------------------------------------------------
//   const SpecsSelectorScreenView({
//     @required this.scrollController,
//     @required this.refinedSpecsPickers,
//     @required this.allSelectedSpecs,
//     @required this.specsPickersByFlyerType,
//     Key key
//   }) : super(key: key);
//   /// --------------------------------------------------------------------------
//   final ScrollController scrollController;
//   final ValueNotifier<List<SpecPicker>> refinedSpecsPickers;
//   final ValueNotifier<List<SpecModel>> allSelectedSpecs;
//   final List<SpecPicker> specsPickersByFlyerType;
//   /// --------------------------------------------------------------------------
//   @override
//   Widget build(BuildContext context) {
// // -----------------------------------------------------------------------------
//     final double _screenWidth = Scale.superScreenWidth(context);
//     final double _screenHeight = Scale.superScreenHeight(context);
// // -----------------------------------------------------------------------------
//     return SizedBox(
//       key: const ValueKey<String>('SpecsSelectorScreenView'),
//       width: _screenWidth,
//       height: _screenHeight,
//       child: Scroller(
//         controller: scrollController,
//         child: ValueListenableBuilder(
//             valueListenable: refinedSpecsPickers,
//             builder: (_, List<SpecPicker> refinedPickers, Widget childB){
//
//               final List<String> _theGroupsIDs = SpecPicker.getGroupsFromSpecsPickers(
//                 specsPickers: refinedPickers,
//               );
//
//               return ListView.builder(
//                   itemCount: _theGroupsIDs.length,
//                   physics: const BouncingScrollPhysics(),
//                   padding: const EdgeInsets.only(
//                     top: Ratioz.stratosphere,
//                     bottom: Ratioz.horizon,
//                   ),
//                   itemBuilder: (BuildContext ctx, int index) {
//
//                     final String _groupID = _theGroupsIDs[index];
//
//                     final List<SpecPicker> _pickersOfThisGroup = SpecPicker.getSpecsPickersByGroupID(
//                       specsPickers: refinedPickers,
//                       groupID: _groupID,
//                     );
//
//                     return SpecsPickersGroup(
//                       title: _groupID.toUpperCase(),
//                       selectedSpecs: allSelectedSpecs,
//                       groupPickers: _pickersOfThisGroup,
//                       onPickerTap: (SpecPicker picker) => onSpecPickerTap(
//                         context: context,
//                         specPicker: picker,
//                         selectedSpecs: allSelectedSpecs,
//                         refinedPickers: refinedSpecsPickers,
//                         sourceSpecPickers: specsPickersByFlyerType,
//                       ),
//                       onDeleteSpec: (List<SpecModel> specs) => onRemoveSpecs(
//                         specs: specs,
//                         selectedSpecs: allSelectedSpecs,
//                       ),
//                     );
//
//                   }
//                   );
//
//             }
//             ),
//       ),
//     );
//
//   }
// }
