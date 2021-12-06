// import 'package:bldrs/controllers/drafters/scalers.dart';
// import 'package:bldrs/controllers/router/navigators.dart';
// import 'package:bldrs/controllers/theme/colorz.dart';
// import 'package:bldrs/controllers/theme/iconz.dart';
// import 'package:bldrs/models/flyer/mutables/super_flyer.dart';
// import 'package:bldrs/views/widgets/flyer/parts/flyer_zone_box.dart';
// import 'package:bldrs/views/widgets/flyer/parts/pages_parts/slides_page_parts/footer.dart';
// import 'package:bldrs/views/widgets/layouts/main_layout.dart';
// import 'package:flutter/material.dart';
// import 'dart:math' as math;
//
//
// class HeroMinScreen extends StatelessWidget {
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
//     double _screenWidth = Scale.superScreenWidth(context);
//     double _screenHeight = Scale.superScreenHeight(context);
//
//     return AboHero(
//       tag: 'bobo',
//       sizeFactor: 0.4,
//       child: MainLayout(
//         pageTitle: 'Hero Test',
//         pyramids: Iconz.DvBlankSVG,
//         appBarType: AppBarType.Basic,
//         appBarRowWidgets: <Widget>[],
//         layoutWidget: Container(
//           width: _screenWidth,
//           height: _screenHeight,
//           // color: Colorz.BloodTest,
//           child: Center(
//             child: AbstractFlyer(
//               sizeFactor: 0.4,
//               onTap: () => _goNextScreen(context),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class HeroMaxScreen extends StatelessWidget {
//
// // -----------------------------------------------------------------------------
//   Future <void> _goBack(BuildContext context) async {
//     await Nav.goBack(context);
//   }
// // -----------------------------------------------------------------------------
//   @override
//   Widget build(BuildContext context) {
//
//     double _screenWidth = Scale.superScreenWidth(context);
//     double _screenHeight = Scale.superScreenHeight(context);
//
//     return AboHero(
//       tag: 'bobo',
//       sizeFactor: 1,
//       child: MainLayout(
//         pageTitle: 'Hero Test',
//         pyramids: Iconz.DvBlankSVG,
//         appBarType: AppBarType.Non,
//         appBarRowWidgets: <Widget>[],
//         layoutWidget: Container(
//           width: _screenWidth,
//           height: _screenHeight,
//           // color: Colorz.BloodTest,
//           child: Center(
//             child: AbstractFlyer(
//               sizeFactor: 1,
//               onTap: () => _goBack(context),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class AbstractFlyer extends StatelessWidget {
//   final double sizeFactor;
//   final Function onTap;
//
//   const AbstractFlyer({
//     this.sizeFactor = 1,
//     @required this.onTap,
//   });
//
//   static const double flyerSmallWidth = 200;
//
//
//
//   @override
//   Widget build(BuildContext context) {
//
//     double _flyerBoxWidth = Scale.superFlyerBoxWidth(context, sizeFactor);
//     double _flyerZoneHeight = Scale.superFlyerZoneHeight(context, _flyerBoxWidth);
//     double _headerHeight = Scale.superHeaderHeight(false, _flyerBoxWidth);
//     double _footerHeight = FlyerFooter.boxHeight(context: context, flyerBoxWidth: _flyerBoxWidth);
//
//     return GestureDetector(
//       onTap: (){
//         print('tapping fucker');
//         onTap();
//       },
//       child: Container(
//         width: _flyerBoxWidth,
//         height: _flyerZoneHeight,
//         color: Colorz.BloodTest,
//         child: Stack(
//           children: <Widget>[
//
//             Positioned(
//               top: 0,
//               child: Container(
//                 width: _flyerBoxWidth,
//                 height: _headerHeight,
//                 color: Colorz.White20,
//                 child: Row(
//                   children: [
//
//                     Container(
//                       width: _headerHeight,
//                       height: _headerHeight,
//                       color: Colorz.White50,
//                     ),
//
//                     const Expander(),
//
//                   ],
//                 ),
//               ),
//             ),
//
//             Positioned(
//               bottom: 0,
//               child: Container(
//                 width: _flyerBoxWidth,
//                 height: _footerHeight,
//                 color: Colorz.White80,
//               ),
//             ),
//
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// ///
// class PeakQuadraticCurve extends Curve {
//   @override
//   double transform(double t) {
//     assert(t >= 0.0 && t <= 1.0);
//     return -15 * math.pow(t, 2) + 15 * t + 1;
//   }
// }
// ///
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
//   final String tag;
//   final Widget child;
//   final double sizeFactor;
//
//   const AboHero({
//     @required this.tag,
//     @required this.child,
//     @required this.sizeFactor,
//   });
//
//   Widget _stupidFlightShuttle(flightContext, animation, direction, fromContext, toContext) {
//     final Hero toHero = toContext.widget;
//
//     double _flyerSmallWidth = Scale.superFlyerBoxWidth(fromContext, 0.4);
//     double _flyerBigWidth = Scale.superFlyerBoxWidth(fromContext, 1);
//     double _heroBeginRatio = _flyerSmallWidth / _flyerBigWidth;
//     double _heroEndRatio = _flyerBigWidth / _flyerBigWidth;
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
//     double _flyerBoxWidth = Scale.superFlyerBoxWidth(fromHeroContext, sizeFactor);
//     double _flyerZoneHeight = Scale.superFlyerZoneHeight(fromHeroContext, _flyerBoxWidth);
//     double _headerHeight = Scale.superHeaderHeight(false, _flyerBoxWidth);
//     double _footerHeight = FlyerFooter.boxHeight(context: fromHeroContext, flyerBoxWidth: _flyerBoxWidth);
//
//     double _flyerSmallWidth = Scale.superFlyerBoxWidth(fromHeroContext, 0.4);
//     double _flyerSmallHeight = Scale.superFlyerZoneHeight(fromHeroContext, _flyerSmallWidth);
//
//     double _flyerBigWidth = Scale.superScreenWidth(fromHeroContext);
//     double _flyerBigHeight = Scale.superFlyerZoneHeight(fromHeroContext, _flyerBigWidth);
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
