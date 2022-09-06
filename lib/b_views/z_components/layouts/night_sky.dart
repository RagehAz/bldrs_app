import 'package:bldrs/b_views/z_components/animators/widget_fader.dart';
import 'package:bldrs/b_views/z_components/images/super_image.dart';
import 'package:bldrs/f_helpers/drafters/numeric.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:flutter/material.dart';

enum SkyType {
  night,
  black,
  nightStars,
  blackStars,
  non,
}

class Sky extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const Sky({
    this.skyType = SkyType.night,
    this.gradientIsOn = false,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final SkyType skyType;
  final bool gradientIsOn;
  /// --------------------------------------------------------------------------
  static List<Color> _getSkyColors({
    @required SkyType skyType,
  }){

    final List<Color> _skyColors = skyType == SkyType.night ? <Color>[Colorz.skyLightBlue, Colorz.skyDarkBlue]
        :
    skyType == SkyType.black ?
    <Color>[Colorz.blackSemi230, Colorz.blackSemi230]
        :
    <Color>[Colorz.skyDarkBlue, Colorz.skyDarkBlue];

    return _skyColors;
  }
  // --------------------
  static Color _getBaseColor({
    @required SkyType skyType,
  }){

    final Color _baseColor = skyType == SkyType.night || skyType == SkyType.black ?
    null
        :
    Colorz.skyDarkBlue;

    return _baseColor;
  }
  // --------------------
  static Gradient _getSkyGradient({
    @required SkyType skyType,
    @required bool gradientIsOn,
  }){

    final List<Color> _skyColors = _getSkyColors(skyType: skyType);

    final Gradient _skyGradient = gradientIsOn == true ?
    RadialGradient(
        center: const Alignment(0.75, 1.25),
        radius: 1,
        colors: _skyColors,
        stops: const <double>[0, 0.65]
    )
        :
    null;

    return _skyGradient;
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _screenWidth = Scale.superScreenWidth(context);
    final double _screenHeight = Scale.superScreenHeight(context);
    // --------------------
    final Gradient _skyGradient = _getSkyGradient(
      skyType: skyType,
      gradientIsOn: gradientIsOn,
    );
    // --------------------
    final Color _plainColor = _getBaseColor(
      skyType: skyType,
    );
    // --------------------
    return Container(
      key: key,
      width: _screenWidth,
      height: _screenHeight,
      decoration: BoxDecoration(
        color: _plainColor,
        gradient: _skyGradient,
      ),
      child: SkyStars(
        starsAreOn: skyType == SkyType.blackStars || skyType == SkyType.nightStars,
      ),
    );
  }
// --------------------
}

class SkyStars extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const SkyStars({
    @required this.starsAreOn,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final bool starsAreOn;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _screenWidth = Scale.superScreenWidth(context);
    final double _screenHeight = Scale.superScreenHeight(context);
    // --------------------
    if (starsAreOn == false){
      return const SizedBox();
    }
    // --------------------
    else {
      return SizedBox(
        width: _screenWidth,
        height: _screenHeight,
        child: Stack(
          children: const <Widget>[

            StarsLayer(
              numberOfStars: 1,
              seconds: 3,
              starSize: 4,
            ),

            StarsLayer(
              numberOfStars: 1,
              seconds: 6,
              starSize: 5,
            ),

            StarsLayer(
              numberOfStars: 10,
              color: Colorz.yellow255,
              seconds: 5,
              starSize: 3,
            ),

            StarsLayer(
              numberOfStars: 5,
              color: Colorz.yellow255,
              // seconds: 2,
              starSize: 2.5,
            ),

            StarsLayer(
              numberOfStars: 80,
              color: Colorz.white125,
              seconds: 8,
              starSize: 2,
            ),

          ],
        ),
      );
    }
    // --------------------
  }
/// --------------------------------------------------------------------------
}

class StarsLayer extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const StarsLayer({
    @required this.numberOfStars,
    this.seconds = 2,
    this.minOpacity = 0,
    this.maxOpacity = 1,
    this.color = Colorz.white255,
    this.starSize = 1,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final int numberOfStars;
  final int seconds;
  final double minOpacity;
  final double maxOpacity;
  final Color color;
  final double starSize;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return WidgetFader(
      fadeType: FadeType.repeatAndReverse,
      min: minOpacity,
      max: maxOpacity,
      duration: Duration(seconds: seconds),
      child: Stack(
        children: <Widget>[

          ...List.generate(numberOfStars, (index){
            return RandomStar(
              size: starSize,
              color: color,
            );
          }),

        ],
      ),
    );

  }
/// --------------------------------------------------------------------------
}

class RandomStar extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const RandomStar({
    @required this.size,
    @required this.color,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double size;
  final Color color;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _screenWidth = Scale.superScreenWidth(context);
    final double _screenHeight = Scale.superScreenHeight(context);
    // --------------------
    return Positioned(
      left: (Numeric.createRandomIndex(listLength: 100) / 100) * _screenWidth,
      bottom: (Numeric.createRandomIndex(listLength: 100) / 100) * _screenHeight,
      child: SuperImage(
        width: size,
        height: size,
        pic: Iconz.star,
        iconColor: color,
      ),
    );
    // --------------------
  }
/// --------------------------------------------------------------------------
}
