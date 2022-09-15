// import 'package:bldrs/a_models/chain/d_spec_model.dart';
// import 'package:bldrs/a_models/chain/c_picker_model.dart';
// import 'package:bldrs/b_views//i_chains/z_components/specs/picker_group/c_picker_tiles_builder.dart';
// import 'package:bldrs/b_views//i_chains/z_components/specs/picker_group/b_pickers_group_headline.dart';
// import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
// import 'package:bldrs/f_helpers/theme/ratioz.dart';
// import 'package:flutter/material.dart';
//
// class SpecsPickersGroup extends StatelessWidget {
//   /// --------------------------------------------------------------------------
//   const SpecsPickersGroup({
//     @required this.headlineVerse,
//     @required this.selectedSpecs,
//     @required this.groupPickers,
//     @required this.onPickerTap,
//     @required this.onDeleteSpec,
//     Key key
//   }) : super(key: key);
//   /// --------------------------------------------------------------------------
//   final Verse headlineVerse;
//   final ValueNotifier<List<SpecModel>> selectedSpecs;
//   final List<PickerModel> groupPickers;
//   final ValueChanged<PickerModel> onPickerTap;
//   final ValueChanged<List<SpecModel>> onDeleteSpec;
//   /// --------------------------------------------------------------------------
//   @override
//   Widget build(BuildContext context) {
//
//     return Padding(
//       key: const ValueKey<String>('SpecsPickersGroup'),
//       padding: const EdgeInsets.only(bottom: Ratioz.appBarMargin),
//       child: Column(
//         children: <Widget>[
//
//           /// GROUP HEADLINE
//           PickersGroupHeadline(
//             headline: headlineVerse,
//           ),
//
//           /// GROUP SPECS PICKERS
//           PickersTilesBuilder(
//             onPickerTap: onPickerTap,
//             selectedSpecs: selectedSpecs,
//             onDeleteSpec: onDeleteSpec,
//             specPickers: groupPickers,
//           ),
//
//         ],
//       ),
//     );
//
//   }
//   // -----------------------------------------------------------------------------
// }
