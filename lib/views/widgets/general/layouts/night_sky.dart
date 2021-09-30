import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/views/widgets/general/layouts/main_layout.dart';
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

class NightSky extends StatefulWidget {
  final Sky sky;

  const NightSky({
    this.sky,
});

  @override
  _NightSkyState createState() => _NightSkyState();
  }


class _NightSkyState extends State<NightSky> with TickerProviderStateMixin {
  // final _controllers = <AnimationController>[];
  //Animation _animation;
// -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();
    // _durations.forEach((Duration d) {
    //   _controllers.add(AnimationController(
    //     vsync: this, // the SingleTickerProviderStateMixin
    //     duration: d,
    //   ));
    // }
  }
// -----------------------------------------------------------------------------
  @override
  void dispose() {
    // _controllers.forEach((AnimationController c) => c.dispose());
    super.dispose();
  }
// -----------------------------------------------------------------------------
//     for (final controller in _controllers) {
//       controller.addStatusListener((AnimationStatus status) {
//         if (status == AnimationStatus.completed) {
//           controller.reverse();
//         } else if (status == AnimationStatus.dismissed) {
//           controller.forward();
//         }
//       });
//       controller.forward();
//     }
//   }
// -----------------------------------------------------------------------------
//     Color _starsColor = Colorz.White255;
// -----------------------------------------------------------------------------
//   Widget _createAnimatedStars(context) {
//
//     double _screenWidth = Scale.superScreenWidth(context);
//     double _screenHeight = Scale.superScreenHeight(context);
//
//     final _customController = _controllers[_random.nextInt(4)];
//     final _colorTween = ColorTween(begin: _starsColor, end: Colors.transparent);
//     final _tweenAnimation = _colorTween.animate(_customController);
//     final _positionAnimation = CurveTween(curve: ElasticInCurve()).animate(_customController);
//     final _pieceSize = 0.5;
//     final _topOffset = _random.nextDouble() * (_screenHeight - _pieceSize);
//     final _leftOffset = _random.nextDouble() * (_screenWidth - _pieceSize);
//
//     return AnimatedBuilder(
//       animation: _customController,
//       builder: (BuildContext context, Widget widget) {
//         final piece = Container(
//             width: _pieceSize, height: _pieceSize, color: _tweenAnimation.value);
//
//         return Positioned(
//           top: _topOffset + (_positionAnimation.value * _random.nextInt(5)),
//           left: _leftOffset + (_positionAnimation.value * _random.nextInt(5)),
//           child: piece,
//         );
//       },
//     );
//   }
// -----------------------------------------------------------------------------
//   List<Widget> _createStars(int numberOfStars) {
//     final pieces = <Widget>[];
//     //for (var i = 0; i< numPieces; i++) {
//     //    pieces.add(_createStateStars());
//     //  }
//     for (var i = 0; i < numberOfStars; i++) {
//       pieces.add(_createAnimatedStars(context));
//     }
//     //for (var i = 0; i < numPieces; i++) {
//     //    pieces.add(_createReverseStars());
//     //  }
//     return pieces;
//   }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
// -----------------------------------------------------------------------------
    final double _screenWidth = Scale.superScreenWidth(context);
    final double _screenHeight = Scale.superScreenHeight(context);
// -----------------------------------------------------------------------------
    final List<Color> _skyColors =
    widget.sky == Sky.Night ? <Color>[Colorz.SkyLightBlue, Colorz.SkyDarkBlue] :
        widget.sky == Sky.Black ? <Color>[Colorz.BlackSemi230, Colorz.BlackSemi230] :
        <Color>[Colorz.SkyDarkBlue, Colorz.SkyDarkBlue];
// -----------------------------------------------------------------------------
    final Gradient _skyGradient =
    widget.sky == Sky.Night || widget.sky == Sky.Black ? RadialGradient(
        center: const Alignment(0.75, 1.25),
        radius: 1,
        colors: _skyColors,
        stops: <double>[0.0, 0.65]
    ) : null;
// -----------------------------------------------------------------------------
    final Color _plainColor = widget.sky == Sky.Night || widget.sky == Sky.Black ? null : Colorz.SkyDarkBlue;
// -----------------------------------------------------------------------------
    return Center(
        child: Container(
          width: _screenWidth,
          height: _screenHeight,

          // the linear Gradient test
          //            decoration: BoxDecoration(
          //              gradient: LinearGradient(
          //                  begin: Alignment.topCenter,
          //                  end: Alignment.bottomCenter,
          //                  stops: [0.95,1],
          //                  colors: [
          //                    Color.fromARGB(1000, 0, 19, 56), // Dark
          //                    Color.fromARGB(1000, 0, 82, 137), // Medium
          ////                  Color.fromARGB(1000, 0, 71, 123), // Light
          //                  ]
          //              ),
          //            ), // Line

          /// Radial Gradient test
          decoration: BoxDecoration(
              color: _plainColor,
              gradient: _skyGradient
          ),

          // child: Stack(children: _createStars(100)),

        ));
  }
}