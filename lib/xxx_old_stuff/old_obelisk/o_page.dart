// import 'package:bldrs/b_views/z_components/app_bar/bldrs_app_bar.dart';
// import 'package:bldrs/b_views/z_components/layouts/main_layout/main_layout.dart';
// import 'package:bldrs/b_views/z_components/layouts/obelisk_layout/o_button_row.dart';
// import 'package:bldrs/b_views/z_components/layouts/page_bubble.dart';
// import 'package:bldrs/b_views/z_components/sizing/expander.dart';
// import 'package:bldrs/b_views/z_components/static_progress_bar/static_strips.dart';
// import 'package:bldrs/f_helpers/drafters/borderers.dart';
// import 'package:bldrs/f_helpers/drafters/scalers.dart';
// import 'package:bldrs/f_helpers/theme/colorz.dart';
// import 'package:bldrs/f_helpers/theme/ratioz.dart';
// import 'package:flutter/material.dart';
//
// class OPage extends StatelessWidget {
//   /// --------------------------------------------------------------------------
//   const OPage({
//     @required this.screenHeight,
//     @required this.title,
//     this.child,
//     this.color = Colorz.white10,
//     Key key
//   }) : super(key: key);
//   /// --------------------------------------------------------------------------
//   final double screenHeight;
//   final String title;
//   final Widget child;
//   final Color color;
//   /// --------------------------------------------------------------------------
//   static double getHeight({
//     @required double screenHeight,
//     @required BuildContext context,
//   }){
//     return screenHeight - StaticStrips.boxHeight(superScreenWidth(context)); //- Ratioz.pyramidsHeight
//   }
// // -----------------------------------------------------------------------------
//   static double getWidth(BuildContext context){
//     return BldrsAppBar.width(context);
//   }
// // -----------------------------------------------------------------------------
//   @override
//   Widget build(BuildContext context) {
//
//     blog('Building : $title');
//
//     const double _obeliskRadius = (OButtonRow.circleWidth + 10) * 0.5;
//     final double _bubbleWidth = getWidth(context);
//
//     return PageBubble(
//       key: const ValueKey<String>('ObeliskPage'),
//       appBarType: AppBarType.basic,
//       screenHeightWithoutSafeArea: getHeight(
//         context: context,
//         screenHeight: screenHeight,
//       ),
//       color: color,
//       bubbleWidth: _bubbleWidth,
//       progressBarIsOn: true,
//       corners: superBorderOnly(
//         context: context,
//         enBottomLeft: _obeliskRadius,
//         enBottomRight: _obeliskRadius,
//         enTopRight: Ratioz.appBarCorner,
//         enTopLeft: Ratioz.appBarCorner,
//       ),
//       child: child,
//     );
//
//   }
// }