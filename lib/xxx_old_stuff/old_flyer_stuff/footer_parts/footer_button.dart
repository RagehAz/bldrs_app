// import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
// import 'package:bldrs/b_views/z_components/flyer/a_flyer_structure/e_flyer_box.dart';
// import 'package:bldrs/b_views/z_components/images/super_image.dart';
// import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
// import 'package:bldrs/xxx_lab/xxx_old_stuff/old_flyer_stuff/old_flyer_zone_box.dart';
// import 'package:bldrs/b_views/widgets/specific/flyer/parts/pages_parts/slides_page_parts/footer.dart';
// import 'package:bldrs/f_helpers/theme/colorz.dart';
// import 'package:flutter/material.dart';
//
// class OldFooterButton extends StatelessWidget {
//   /// --------------------------------------------------------------------------
//   const OldFooterButton({
//     @required this.icon,
//     @required this.flyerBoxWidth,
//     @required this.onTap,
//     @required this.verse,
//
//     /// initializing size value overrides all values and suppresses margins
//     this.size,
//     this.inActiveMode = false,
//     this.isOn = false,
//     Key key,
//   }) : super(key: key);
//   /// --------------------------------------------------------------------------
//   final String icon;
//   final double flyerBoxWidth;
//   final Function onTap;
//   final String verse;
//   final double size;
//   final bool inActiveMode;
//
//   /// needed for ankh button value
//   final bool isOn;
//   /// --------------------------------------------------------------------------
//   @override
//   Widget build(BuildContext context) {
//
//     final double _footerBTMargins = size != null ? 0
//         :
//     OldFlyerFooter.buttonMargin(
//         context: context,
//         flyerBoxWidth: flyerBoxWidth,
//         buttonIsOn: isOn
//     );
//
//     final double _saveBTRadius = size != null ?
//     size / 2
//         :
//     OldFlyerFooter.buttonRadius(
//         context: context,
//         flyerBoxWidth: flyerBoxWidth,
//         buttonIsOn: isOn
//     );
//
//     final double _buttonSize = size ??
//         OldFlyerFooter.buttonSize(
//             context: context,
//             flyerBoxWidth: flyerBoxWidth,
//             buttonIsOn: isOn
//         );
//
//     final bool _tinyMode = FlyerBox.isTinyMode(context, flyerBoxWidth);
//
//     return Container(
//       key: const ValueKey<String>('Footer_button'),
//       width: _buttonSize,
//       height: _buttonSize,
//       margin: EdgeInsets.all(_footerBTMargins),
//       child: Stack(
//         alignment: Alignment.center,
//         children: <Widget>[
//
//           DreamBox(
//             icon: _tinyMode ? icon : null,
//             iconSizeFactor: 0.5,
//             width: _buttonSize,
//             height: _buttonSize,
//             corners: _saveBTRadius,
//             color: OldFlyerFooter.buttonColor(buttonIsOn: isOn),
//             onTap: inActiveMode == true ? null : onTap,
//             childAlignment: Alignment.topCenter,
//             inActiveMode: inActiveMode,
//             subChild: _tinyMode ?
//             null
//                 :
//             SizedBox(
//               width: _buttonSize * 0.8,
//               height: _buttonSize * 0.9,
//               // color: Colorz.BloodTest,
//               child: SuperImage(
//                 pic: icon,
//                 iconColor: DreamBox.getIconColor(inActiveMode: inActiveMode),
//                 scale: 0.7,
//               ),
//             ),
//           ),
//
//           /// verse
//           if (!_tinyMode)
//             Positioned(
//               bottom: flyerBoxWidth * 0.01,
//               child: SuperVerse(
//                 verse: verse,
//                 size: 1,
//                 scaleFactor: FlyerBox.sizeFactorByWidth(context, flyerBoxWidth),
//                 color: DreamBox.getIconColor(
//                     inActiveMode: inActiveMode, colorOverride: Colorz.white125),
//               ),
//             ),
//
//         ],
//       ),
//     );
//   }
// }
