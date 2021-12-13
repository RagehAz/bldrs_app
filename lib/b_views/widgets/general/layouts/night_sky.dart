import 'package:bldrs/f_helpers/drafters/scalers.dart' as Scale;
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';

//double  _width = 500.0;
//double _height = 500.0;
// const _durations = <Duration>[
// //  Duration(seconds: 1),
//   Duration(seconds: 10),
//   Duration(seconds: 3),
//   Duration(seconds: 6),
//   Duration(seconds: 5),
//   Duration(seconds: 2),
// ];
// final _random = math.Random();

// class NightSky extends StatefulWidget {
//   final SkyType sky;
//
//   const NightSky({
//     this.sky,
// });
//
//   @override
//   _NightSkyState createState() => _NightSkyState();
//   }
//
//
// class _NightSkyState extends State<NightSky> with TickerProviderStateMixin {
//   // final _controllers = <AnimationController>[];
//   //Animation _animation;
// // -----------------------------------------------------------------------------
//   @override
//   void initState() {
//     super.initState();
//     // _durations.forEach((Duration d) {
//     //   _controllers.add(AnimationController(
//     //     vsync: this, // the SingleTickerProviderStateMixin
//     //     duration: d,
//     //   ));
//     // }
//   }
// // -----------------------------------------------------------------------------
//   @override
//   void dispose() {
//     // _controllers.forEach((AnimationController c) => c.dispose());
//     super.dispose();
//   }
// // -----------------------------------------------------------------------------
// //     for (final controller in _controllers) {
// //       controller.addStatusListener((AnimationStatus status) {
// //         if (status == AnimationStatus.completed) {
// //           controller.reverse();
// //         } else if (status == AnimationStatus.dismissed) {
// //           controller.forward();
// //         }
// //       });
// //       controller.forward();
// //     }
// //   }
// // -----------------------------------------------------------------------------
// //     Color _starsColor = Colorz.White255;
// // -----------------------------------------------------------------------------
// //   Widget _createAnimatedStars(context) {
// //
// //     double _screenWidth = Scale.superScreenWidth(context);
// //     double _screenHeight = Scale.superScreenHeight(context);
// //
// //     final _customController = _controllers[_random.nextInt(4)];
// //     final _colorTween = ColorTween(begin: _starsColor, end: Colors.transparent);
// //     final _tweenAnimation = _colorTween.animate(_customController);
// //     final _positionAnimation = CurveTween(curve: ElasticInCurve()).animate(_customController);
// //     final _pieceSize = 0.5;
// //     final _topOffset = _random.nextDouble() * (_screenHeight - _pieceSize);
// //     final _leftOffset = _random.nextDouble() * (_screenWidth - _pieceSize);
// //
// //     return AnimatedBuilder(
// //       animation: _customController,
// //       builder: (BuildContext context, Widget widget) {
// //         final piece = Container(
// //             width: _pieceSize, height: _pieceSize, color: _tweenAnimation.value);
// //
// //         return Positioned(
// //           top: _topOffset + (_positionAnimation.value * _random.nextInt(5)),
// //           left: _leftOffset + (_positionAnimation.value * _random.nextInt(5)),
// //           child: piece,
// //         );
// //       },
// //     );
// //   }
// // -----------------------------------------------------------------------------
// //   List<Widget> _createStars(int numberOfStars) {
// //     final pieces = <Widget>[];
// //     //for (var i = 0; i< numPieces; i++) {
// //     //    pieces.add(_createStateStars());
// //     //  }
// //     for (var i = 0; i < numberOfStars; i++) {
// //       pieces.add(_createAnimatedStars(context));
// //     }
// //     //for (var i = 0; i < numPieces; i++) {
// //     //    pieces.add(_createReverseStars());
// //     //  }
// //     return pieces;
// //   }
// // -----------------------------------------------------------------------------
//   @override
//   Widget build(BuildContext context) {
// // -----------------------------------------------------------------------------
//     final double _screenWidth = Scale.superScreenWidth(context);
//     final double _screenHeight = Scale.superScreenHeight(context);
// // -----------------------------------------------------------------------------
//     final List<Color> _skyColors =
//     widget.sky == SkyType.Night ? <Color>[Colorz.skyLightBlue, Colorz.skyDarkBlue] :
//         widget.sky == SkyType.Black ? <Color>[Colorz.blackSemi230, Colorz.blackSemi230] :
//         <Color>[Colorz.skyDarkBlue, Colorz.skyDarkBlue];
// // -----------------------------------------------------------------------------
//     final Gradient _skyGradient =
//     widget.sky == SkyType.Night || widget.sky == SkyType.Black ? RadialGradient(
//         center: const Alignment(0.75, 1.25),
//         radius: 1,
//         colors: _skyColors,
//         stops: const <double>[0.0, 0.65]
//     ) : null;
// // -----------------------------------------------------------------------------
//     final Color _plainColor = widget.sky == SkyType.Night || widget.sky == SkyType.Black ? null : Colorz.skyDarkBlue;
// // -----------------------------------------------------------------------------
//     return Container(
//       width: _screenWidth,
//       height: _screenHeight,
//
//       // the linear Gradient test
//       //            decoration: BoxDecoration(
//       //              gradient: LinearGradient(
//       //                  begin: Alignment.topCenter,
//       //                  end: Alignment.bottomCenter,
//       //                  stops: [0.95,1],
//       //                  colors: [
//       //                    Color.fromARGB(1000, 0, 19, 56), // Dark
//       //                    Color.fromARGB(1000, 0, 82, 137), // Medium
//       ////                  Color.fromARGB(1000, 0, 71, 123), // Light
//       //                  ]
//       //              ),
//       //            ), // Line
//
//       /// Radial Gradient test
//       decoration: BoxDecoration(
//           color: _plainColor,
//           gradient: _skyGradient
//       ),
//
//       // child: Stack(children: _createStars(100)),
//
//     );
//   }
// }

// -----------------------------------------------------------------------------

class Sky extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const Sky({this.skyType = SkyType.night, Key key}) : super(key: key);

  /// --------------------------------------------------------------------------
  final SkyType skyType;

  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
// -----------------------------------------------------------------------------
    final double _screenWidth = Scale.superScreenWidth(context);
    final double _screenHeight = Scale.superScreenHeight(context);
// -----------------------------------------------------------------------------
    final List<Color> _skyColors = skyType == SkyType.night
        ? <Color>[Colorz.skyLightBlue, Colorz.skyDarkBlue]
        : skyType == SkyType.black
            ? <Color>[Colorz.blackSemi230, Colorz.blackSemi230]
            : <Color>[Colorz.skyDarkBlue, Colorz.skyDarkBlue];
// -----------------------------------------------------------------------------
    final Gradient _skyGradient =
        skyType == SkyType.night || skyType == SkyType.black
            ? RadialGradient(
                center: const Alignment(0.75, 1.25),
                radius: 1,
                colors: _skyColors,
                stops: const <double>[0, 0.65])
            : null;
// -----------------------------------------------------------------------------
    final Color _plainColor =
        skyType == SkyType.night || skyType == SkyType.black
            ? null
            : Colorz.skyDarkBlue;
// -----------------------------------------------------------------------------
    return Container(
      key: key,
      width: _screenWidth,
      height: _screenHeight,
      decoration: BoxDecoration(color: _plainColor, gradient: _skyGradient),
    );
  }
}

// -----------------------------------------------------------------------------
enum SkyType {
  night,
  black,
  non,
}
// -----------------------------------------------------------------------------
