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

    if (skyType == SkyType.night){
      return <Color>[Colorz.skyLightBlue, Colorz.skyDarkBlue];
    }
    else if (skyType == SkyType.black){
      return <Color>[Colorz.blackSemi230, Colorz.blackSemi230];
    }
    else {
      return <Color>[Colorz.skyDarkBlue, Colorz.skyDarkBlue];
    }

  }
  // --------------------
  static Color _getBaseColor({
    @required SkyType skyType,
  }){

    if (skyType == SkyType.night || skyType == SkyType.black){
      return null;
    }
    else {
      return Colorz.skyDarkBlue;
    }

  }
  // --------------------
  static Gradient _getSkyGradient({
    @required SkyType skyType,
    @required bool gradientIsOn,
  }){

    if (gradientIsOn == true){
      return RadialGradient(
          center: const Alignment(0.75, 1.25),
          radius: 1,
          colors: _getSkyColors(skyType: skyType),
          stops: const <double>[0, 0.65]
      );
    }

    else {
      return null;
    }

  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return Container(
      key: key,
      width: Scale.superScreenWidth(context),
      height: Scale.superScreenHeight(context),
      decoration: BoxDecoration(
        color: _getBaseColor(
          skyType: skyType,
        ),
        gradient: _getSkyGradient(
          skyType: skyType,
          gradientIsOn: gradientIsOn,
        ),
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
    if (starsAreOn == false){
      return const SizedBox();
    }
    // --------------------
    else {
      return SizedBox(
        width: Scale.superScreenWidth(context),
        height: Scale.superScreenHeight(context),
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
    return Positioned(
      left: (Numeric.createRandomIndex(listLength: 100) / 100) * Scale.superScreenWidth(context),
      bottom: (Numeric.createRandomIndex(listLength: 100) / 100) * Scale.superScreenHeight(context),
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
