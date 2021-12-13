// import 'package:bldrs/controllers/theme/colorz.dart';
// import 'package:bldrs/controllers/theme/iconz.dart';
// import 'package:bldrs/controllers/theme/ratioz.dart';
// import 'package:bldrs/models/flyer/sub/flyer_type_class.dart';
// import 'package:bldrs/models/keywords/keyword_model.dart';
// import 'package:bldrs/models/keywords/section_class.dart';
// import 'package:bldrs/models/keywords/sequence_model.dart';
// import 'package:bldrs/views/widgets/general/appbar/sections_button.dart';
// import 'package:bldrs/views/widgets/specific/keywords/keyword_button.dart';
// import 'package:bldrs/views/widgets/general/layouts/main_layout.dart';
// import 'package:bldrs/views/widgets/general/layouts/walls/sequences_wall.dart';
// import 'package:flutter/material.dart';
//
// class SequenceScreen extends StatelessWidget {
//   // final Sequence sequence;
//   final FlyerType flyersType;
//   final Section section;
//
//
//   SequenceScreen({
//     // @required this.sequence,
//     @required this.flyersType,
//     @required this.section,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//
//
//     return MainLayout(
//       appBarType: AppBarType.Scrollable,
//
//       pyramids: Iconz.DvBlankSVG,
//       appBarRowWidgets: <Widget>[
//
//         SectionsButton(
//           color: Colorz.blue80,
//           onTap: (){},
//         ),
//
//         KeywordBarButton(
//           keyword: Keyword.getKeywordByKeywordID(sequence.titleID),
//           xIsOn: false,
//           // color: ,
//           onTap: (){
//             print('bashboush');
//           },
//         ),
//
//         const SizedBox(
//           width: Ratioz.appBarPadding * 0.5,
//         ),
//
//       ],
//       sky: Sky.Night,
//       // layoutWidget:
//       // // _isLoading == true ?
//       // // Center(child: Loading(loading: _isLoading,))
//       // //     :
//       // SequencesWall(
//       //   sequence: sequence,
//       //   flyersType: flyersType,
//       // ),
//     );
//   }
// }
