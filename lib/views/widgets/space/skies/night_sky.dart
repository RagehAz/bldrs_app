import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

//double  _width = 500.0;
//double _height = 500.0;
const _durations = <Duration>[
//  Duration(seconds: 1),
  Duration(seconds: 10),
  Duration(seconds: 3),
  Duration(seconds: 6),
  Duration(seconds: 5),
  Duration(seconds: 2),
];
final _random = math.Random();

class NightSky extends StatefulWidget {
  NightSky({Key key}) : super(key: key);

  @override
  _NightSkyState createState() => _NightSkyState();
  }


class _NightSkyState extends State<NightSky> with TickerProviderStateMixin {
  final _controllers = <AnimationController>[];
  //Animation _animation;
// -----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();
    _durations.forEach((Duration d) {
      _controllers.add(AnimationController(
        vsync: this, // the SingleTickerProviderStateMixin
        duration: d,
      ));
    });
// -----------------------------------------------------------------------------
  @override
  void dispose() {
    _controllers.forEach((AnimationController c) => c.dispose());
    super.dispose();
  }
// -----------------------------------------------------------------------------
    for (final controller in _controllers) {
      controller.addStatusListener((AnimationStatus status) {
        if (status == AnimationStatus.completed) {
          controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          controller.forward();
        }
      });
      controller.forward();
    }
  }
// -----------------------------------------------------------------------------
    Color _getRandomColor() {
    return Color.fromARGB(150, 255, 255, 255);
  }
// -----------------------------------------------------------------------------
  Widget _createAnimatedStars(context) {

    double _screenWidth = Scale.superScreenWidth(context);
    double _screenHeight = Scale.superScreenWidth(context);

    final _customController = _controllers[_random.nextInt(4)];
    final _colorTween = ColorTween(begin: _getRandomColor(), end: Colors.transparent);
    final _tweenAnimation = _colorTween.animate(_customController);
    final _positionAnimation = CurveTween(curve: ElasticInCurve()).animate(_customController);
    final _pieceSize = 0.5;
    final _topOffset = _random.nextDouble() * (_screenHeight - _pieceSize);
    final _leftOffset = _random.nextDouble() * (_screenWidth - _pieceSize);

    return AnimatedBuilder(
      animation: _customController,
      builder: (BuildContext context, Widget widget) {
        final piece = Container(
            width: _pieceSize, height: _pieceSize, color: _tweenAnimation.value);

        return Positioned(
          top: _topOffset + (_positionAnimation.value * _random.nextInt(5)),
          left: _leftOffset + (_positionAnimation.value * _random.nextInt(5)),
          child: piece,
        );
      },
    );
  }

  // Widget _creatReverseStars() {
  //
  //   double heightMQ = MediaQuery.of(context).size.height;
  //   double widthMQ = MediaQuery.of(context).size.width;
  //
  //
  //   final customController = _controllers[_random.nextInt(5)];
  //
  //   final colorTween =
  //   ColorTween(begin: Colors.transparent, end: _getRandomColor());
  //   final animation = colorTween.animate(customController);
  //   final pieceSize = 0.5;
  //   final piece = AnimatedBuilder(
  //     animation: animation,
  //     builder: (BuildContext context, Widget widget) {
  //       return Container(
  //           width: pieceSize, height: pieceSize, color: animation.value);
  //     },
  //   );
  //   final topOffset = _random.nextDouble() * (heightMQ - pieceSize * 1.9);
  //   final leftOffset = _random.nextDouble() * (widthMQ - pieceSize * 4.2);
  //
  //   return Positioned(
  //     top: topOffset,
  //     left: leftOffset,
  //     child: piece,
  //   );
  // }

  // Widget _createStateStars() {
  //
  //   double heightMQ = MediaQuery.of(context).size.height;
  //   double widthMQ = MediaQuery.of(context).size.width;
  //
  //
  //   final pieceSize = 0.5;
  //   final piece = Container(
  //       width: pieceSize, height: pieceSize, color: _getRandomColor());
  //   final topOffset = _random.nextDouble() * (heightMQ - pieceSize*2);
  //   final leftOffset = _random.nextDouble() * (widthMQ - pieceSize*5);
  //
  //   return Positioned(
  //     top: topOffset,
  //     left: leftOffset,
  //     child: piece,
  //   );
  // }

  List<Widget> _createStars(int numberOfStars) {
    final pieces = <Widget>[];
    //for (var i = 0; i< numPieces; i++) {
    //    pieces.add(_createStateStars());
    //  }
    for (var i = 0; i < numberOfStars; i++) {
      pieces.add(_createAnimatedStars(context));
    }
    //for (var i = 0; i < numPieces; i++) {
    //    pieces.add(_createReverseStars());
    //  }
    return pieces;
  }

  @override
  Widget build(BuildContext context) {

    double _screenWidth = Scale.superScreenWidth(context);
    double _screenHeight = Scale.superScreenWidth(context);

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
              gradient: RadialGradient(
                  center: const Alignment(0.75, 1.25),
                  radius: 1,
                  colors: <Color>[
                    Colorz.SkyLightBlue,
                    Colorz.SkyDarkBlue
                  ],
                  stops: <double>[0.0, 0.65]
              )
          ),
          // child: Stack(children: _createStars(100)),

        ));
  }
}