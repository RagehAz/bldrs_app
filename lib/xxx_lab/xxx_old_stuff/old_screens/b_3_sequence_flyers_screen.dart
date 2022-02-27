// import 'package:bldrs/controllers/theme/colorz.dart';
// import 'package:bldrs/controllers/theme/iconz.dart';
// import 'package:bldrs/a_models/keywords/keyword_model.dart';
// import 'package:bldrs/a_models/keywords/section_class.dart';
// import 'package:bldrs/a_models/keywords/sequence_model.dart';
// import 'package:bldrs/d_providers/general_provider.dart';
// import 'package:bldrs/b_views/widgets/general/appbar/sections_button.dart';
// import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
// import 'package:bldrs/b_views/widgets/general/layouts/main_layout.dart';
// import 'package:bldrs/b_views/widgets/specific/keywords/keyword_button.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// class SequenceFlyersScreen extends StatelessWidget {
//   final Keyword firstKeyword;
//   final Keyword secondKeyword;
//   final Sequence sequence;
//
//   const SequenceFlyersScreen({
//     @required this.firstKeyword,
//     @required this.secondKeyword,
//     @required this.sequence,
// });
//
//   @override
//   Widget build(BuildContext context) {
//
//     final GeneralProvider _generalProvider = Provider.of<GeneralProvider>(context, listen: true);
//     final Section _currentSection = _generalProvider.currentSection;
//
//     return MainLayout(
//       appBarType: AppBarType.Scrollable,
//       appBarRowWidgets: <Widget>[
//
//         SectionsButton(
//           color: Colorz.blue80,
//           onTap: (){},
//         ),
//
//         KeywordBarButton(
//           keyword: firstKeyword,
//           xIsOn: false,
//           // color: ,
//           onTap: (){
//             print('bashboush');
//             },
//         ),
//
//         // SizedBox(
//         //   width: Ratioz.appBarPadding * 0.5,
//         // ),
//
//         KeywordBarButton(
//           keyword: secondKeyword,
//           xIsOn: false,
//           // color: ,
//           onTap: (){
//             print('bashboush');
//           },
//         ),
//
//       ],
//       pyramids: Iconz.PyramidzYellow,
//       layoutWidget: Center(
//         child: DreamBox(
//           height: 100,
//           icon: Iconz.DvRageh,
//           verse: '$_currentSection,\n${firstKeyword?.keywordID},\n${secondKeyword?.keywordID}',
//           verseMaxLines: 4,
//         ),
//       ),
//     );
//   }
// }
