// import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
// import 'package:bldrs/b_views/z_components/nav_bar/components/note_red_dot.dart';
// import 'package:bldrs/b_views/z_components/nav_bar/nav_bar_methods.dart';
// import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
// import 'package:bldrs/f_helpers/drafters/aligners.dart' as Aligners;
// import 'package:bldrs/f_helpers/drafters/scalers.dart';
// import 'package:bldrs/f_helpers/theme/ratioz.dart';
// import 'package:flutter/material.dart';
//
// class NavBarButton extends StatelessWidget {
//   /// --------------------------------------------------------------------------
//   const NavBarButton({
//     @required this.text,
//     @required this.size,
//     this.icon,
//     this.iconSizeFactor,
//     this.clipperWidget,
//     this.barType = BarType.maxWithText,
//     this.onTap,
//     this.corners,
//     this.notesDotIsOn = false,
//     this.notesCount,
//     Key key,
//   }) : super(key: key);
//   /// --------------------------------------------------------------------------
//   final String text;
//   final String icon;
//   final double iconSizeFactor;
//   final Widget clipperWidget;
//   final BarType barType;
//   final Function onTap;
//   final double size;
//   final double corners;
//   final bool notesDotIsOn;
//   final int notesCount;
//   /// --------------------------------------------------------------------------
//   @override
//   Widget build(BuildContext context) {
//
//     const double _circleWidth = 40;
//     final double _buttonCircleCorner = corners ?? _circleWidth * 0.5;
//     const double _paddings = Ratioz.appBarPadding * 1.5;
//
//     const double _textScaleFactor = 0.95;
//     const int _textSize = 1;
//
//     final double _textBoxHeight =
//         barType == BarType.maxWithText || barType == BarType.minWithText ?
//         SuperVerse.superVerseRealHeight(
//             context: context,
//             size: _textSize,
//             sizeFactor: _textScaleFactor,
//             hasLabelBox: false,
//         )
//             :
//         0;
//
//     final double _buttonHeight = _circleWidth + (2 * _paddings) + _textBoxHeight;
//     final double _buttonWidth = size;
//
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         height: _buttonHeight,
//         width: _buttonWidth,
//         padding: const EdgeInsets.symmetric(horizontal: _paddings * 0.25),
//         child: Stack(
//           alignment: Aligners.superInverseTopAlignment(context),
//           children: <Widget>[
//
//             /// BUTTON
//             Column(
//               children: <Widget>[
//
//                 const SizedBox(
//                   height: _paddings,
//                 ),
//
//                 if (clipperWidget == null)
//                   DreamBox(
//                     width: _circleWidth,
//                     height: _circleWidth,
//                     icon: icon,
//                     iconSizeFactor: iconSizeFactor,
//                     corners: _buttonCircleCorner,
//                     onTap: onTap,
//                   ),
//
//                 if (clipperWidget != null)
//                   SizedBox(
//                       width: _circleWidth,
//                       height: _circleWidth,
//                       child: clipperWidget),
//
//                 if (barType == BarType.maxWithText ||
//                     barType == BarType.minWithText)
//                   Container(
//                     width: _buttonWidth,
//                     height: _textBoxHeight,
//                     // color: Colorz.YellowLingerie,
//                     alignment: Alignment.center,
//                     child: SuperVerse(
//                       verse: text,
//                       maxLines: 2,
//                       size: _textSize,
//                       weight: VerseWeight.thin,
//                       shadow: true,
//                       scaleFactor: _textScaleFactor,
//                     ),
//                   ),
//
//               ],
//             ),
//
//             /// RED DOT
//             if (notesDotIsOn == true)
//               Padding(
//                 padding: superMargins(margins: 3),
//                 child: NoteRedDot(
//                   count: notesCount,
//                 ),
//               ),
//
//           ],
//         ),
//       ),
//     );
//   }
// }
