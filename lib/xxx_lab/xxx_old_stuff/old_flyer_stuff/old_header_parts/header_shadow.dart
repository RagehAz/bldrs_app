// import 'package:bldrs/b_views/z_components/flyer/a_flyer_structure/e_flyer_box.dart';
// import 'package:bldrs/f_helpers/drafters/shadowers.dart' as Shadowz;
// import 'package:bldrs/f_helpers/theme/colorz.dart';
// import 'package:flutter/material.dart';
//
// class HeaderShadow extends StatelessWidget {
//   /// --------------------------------------------------------------------------
//   const HeaderShadow({
//     @required this.flyerBoxWidth,
//     @required this.bzPageIsOn,
//     Key key,
//   }) : super(key: key);
//
//   /// --------------------------------------------------------------------------
//   final double flyerBoxWidth;
//   final bool bzPageIsOn;
//
//   /// --------------------------------------------------------------------------
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: <Widget>[
//         /// --- MINI HEADER'S BG COLOR IN MAX STATE
//         if (bzPageIsOn == true)
//           Container(color: Colorz.bzPageBGColor), //bzPageBGColor,),
//
//         /// --- HEADER SHADOW
//         Container(
//           width: flyerBoxWidth,
//           height: flyerBoxWidth,
//           decoration: BoxDecoration(
//             borderRadius: FlyerBox.superHeaderCorners(
//                 context: context,
//                 bzPageIsOn: bzPageIsOn,
//                 flyerBoxWidth: flyerBoxWidth),
//             boxShadow: Shadowz.flyerHeaderShadow(flyerBoxWidth),
//           ),
//         ),
//       ],
//     );
//   }
// }
