// import 'dart:math' as math;
// import 'package:bldrs/b_views/widgets/general/layouts/main_layout/main_layout.dart';
// import 'package:bldrs/b_views/widgets/specific/flyer/parts/old_flyer_zone_box.dart';
// import 'package:bldrs/b_views/widgets/specific/flyer/parts/pages_parts/slides_page_parts/a_flyer_footer.dart';
// import 'package:bldrs/b_views/z_components/sizing/expander.dart';
// import 'package:bldrs/f_helpers/drafters/scalers.dart' as Scale;
// import 'package:bldrs/f_helpers/router/navigators.dart' as Nav;
// import 'package:bldrs/f_helpers/theme/colorz.dart';
// import 'package:bldrs/b_views/z_components/flyer/d_flyer_tree.dart';
// import 'package:flutter/material.dart';
//
// class HeroMinScreen extends StatelessWidget {
//
//   const HeroMinScreen({Key key}) : super(key: key);
//
// // -----------------------------------------------------------------------------
//   Future <void> _goNextScreen(BuildContext context) async {
//     await Navigator.push(context,
//         MaterialPageRoute(builder: (context) =>
//
//             HeroMaxScreen()
//
//         ),
//     );
//
//   }
// // -----------------------------------------------------------------------------
//   @override
//   Widget build(BuildContext context) {
//
//     final double _screenWidth = Scale.superScreenWidth(context);
//     final double _screenHeight = Scale.superScreenHeight(context);
//
//     return AboHero(
//       tag: 'bobo',
//       sizeFactor: 0.4,
//       child: MainLayout(
//         pageTitle: 'Hero Test',
//         pyramidsAreOn: true,
//         sectionButtonIsOn: false,
//         zoneButtonIsOn: false,
//         appBarType: AppBarType.basic,
//         appBarRowWidgets: <Widget>[],
//         layoutWidget: Container(
//           width: _screenWidth,
//           height: _screenHeight,
//           // color: Colorz.BloodTest,
//           child: Center(
//             child: TheFlyer(
//               flyerWidthFactor: 0.4,
//               onTap: () => _goNextScreen(context),
//             ),
//           ),
//         ),
//       ),
//     );
//
//   }
// }
//
// class HeroMaxScreen extends StatelessWidget {
//
//   const HeroMaxScreen({Key key}) : super(key: key);
//
// // -----------------------------------------------------------------------------
//   Future <void> _goBack(BuildContext context) async {
//     await Nav.goBack(context);
//   }
// // -----------------------------------------------------------------------------
//   @override
//   Widget build(BuildContext context) {
//
//     final double _screenWidth = Scale.superScreenWidth(context);
//     final double _screenHeight = Scale.superScreenHeight(context);
//
//     return AboHero(
//       tag: 'bobo',
//       sizeFactor: 1,
//       child: MainLayout(
//         pageTitle: 'Hero Test',
//         appBarType: AppBarType.non,
//         zoneButtonIsOn: false,
//         sectionButtonIsOn: false,
//         pyramidsAreOn: true,
//         appBarRowWidgets: <Widget>[],
//         layoutWidget: Container(
//           width: _screenWidth,
//           height: _screenHeight,
//           // color: Colorz.BloodTest,
//           child: Center(
//             child: TheFlyer(
//               flyerWidthFactor: 1,
//               onTap: () => _goBack(context),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
//
// class PeakQuadraticCurve extends Curve {
//   @override
//   double transform(double t) {
//     assert(t >= 0.0 && t <= 1.0);
//     return -15 * math.pow(t, 2) + 15 * t + 1;
//   }
// }
//
// class FlyerTransition extends AnimatedWidget {
//   final Animation<double> animation;
//   final Widget child;
//   final double flyerSmallWidth;
//   final double flyerBigWidth;
//   final double flyerSmallHeight;
//   final double flyerBigHeight;
//
//
//   FlyerTransition({
//     @required this.animation,
//     @required this.child,
//     @required this.flyerSmallWidth,
//     @required this.flyerBigWidth,
//     @required this.flyerSmallHeight,
//     @required this.flyerBigHeight,
//   })
//       : assert(animation != null),
//         assert(child != null),
//         super(listenable: animation);
//
//   @override
//   Widget build(BuildContext context) {
//
//     double _screenWidth = Scale.superScreenWidth(context);
//     double _screenHeight = Scale.superScreenHeight(context);
//
//     double _xScale =
//         (
//             /// flyerScale
//             ( flyerSmallWidth ) +
//                 /// flyer margin variable scale
//                 ( (_screenWidth - flyerSmallWidth) * animation.value.ceil())
//         )
//             /
//             /// flyer big size
//             (_screenWidth)
//     ;
//
//     double _yScale =
//         (
//             /// flyerScale
//             ( flyerSmallHeight )
//                 +
//                 /// flyer margin variable scale
//                 ( (_screenHeight - flyerSmallHeight) * animation.value.ceil())
//         )
//             /
//             /// flyer big size
//             (_screenHeight)
//     ;
//
//     return Transform(
//       transform: Matrix4.identity()..scale(_xScale, _yScale),
//       alignment: FractionalOffset.center,
//       child: child,
//     );
//   }
// }
//
// class AboHero extends StatelessWidget {
//
//   const AboHero({
//     @required this.tag,
//     @required this.child,
//     @required this.sizeFactor,
//     Key key
//   }) : super(key: key);
//
//   final String tag;
//   final Widget child;
//   final double sizeFactor;
//
//   Widget _stupidFlightShuttle(flightContext, animation, direction, fromContext, toContext) {
//     final Hero toHero = toContext.widget;
//
//     final double _flyerSmallWidth = OldFlyerBox.width(fromContext, 0.4);
//     final double _flyerBigWidth = OldFlyerBox.width(fromContext, 1);
//     final double _heroBeginRatio = _flyerSmallWidth / _flyerBigWidth;
//     final double _heroEndRatio = _flyerBigWidth / _flyerBigWidth;
//
//     return ScaleTransition(
//       scale: animation.drive(
//         Tween<double>(begin: _heroBeginRatio, end: _heroEndRatio).chain(
//           CurveTween(
//             curve: Interval(
//               _heroBeginRatio, _heroEndRatio, curve: Curves.easeOut,
//             ), //PeakQuadraticCurve()),
//           ),
//         ),
//       ),
//       child: toHero.child,
//     );
//   }
//
//   Widget _flyerShuttle (
//       BuildContext flightContext,
//       Animation<double> animation, // 0 to 1
//       HeroFlightDirection flightDirection,
//       BuildContext fromHeroContext,
//       BuildContext toHeroContext,
//       ) {
//
//     print('animation value is : ${animation.value}');
//
//     final Hero toHero = toHeroContext.widget;
//
//     final double _flyerBoxWidth = OldFlyerBox.width(fromHeroContext, sizeFactor);
//     final double _flyerZoneHeight = OldFlyerBox.height(fromHeroContext, _flyerBoxWidth);
//     final double _headerHeight = OldFlyerBox.headerBoxHeight(
//         bzPageIsOn: false,
//         flyerBoxWidth: _flyerBoxWidth
//     );
//     final double _footerHeight = FlyerFooter.boxHeight(context: fromHeroContext, flyerBoxWidth: _flyerBoxWidth);
//
//     final double _flyerSmallWidth = OldFlyerBox.width(fromHeroContext, 0.4);
//     final double _flyerSmallHeight = OldFlyerBox.height(fromHeroContext, _flyerSmallWidth);
//
//     final double _flyerBigWidth = Scale.superScreenWidth(fromHeroContext);
//     final double _flyerBigHeight = OldFlyerBox.height(fromHeroContext, _flyerBigWidth);
//
//
//     return FlyerTransition(
//       animation: animation,
//       flyerSmallWidth: _flyerSmallWidth,
//       flyerBigWidth: _flyerBigWidth,
//       flyerSmallHeight: _flyerSmallHeight,
//       flyerBigHeight: _flyerBigHeight,
//       child: toHero,
//     );
//
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//       return Hero(
//         tag: tag,
//         transitionOnUserGestures: false,
//         /// ------------------------------------------------- o
//         // createRectTween: (begin, end) {
//         //   return CustomRectTween(a: begin, b: end);
//         //   },
//         /// ------------------------------------------------- o
//         flightShuttleBuilder: _flyerShuttle,
//         /// ------------------------------------------------- o
//         // placeholderBuilder: (context, size ,widget) {
//         //   return FlyerZoneBox(
//         //     flyerBoxWidth: _flyerBoxWidth,
//         //     superFlyer: SuperFlyer.createEmptySuperFlyer(flyerBoxWidth: _flyerBoxWidth),
//         //     onFlyerZoneTap: null,
//         //   );
//         // },
//         /// ------------------------------------------------- o
//         child: child,
//       );
//     }
//
//   }
//
