import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
// -----------------------------------------------------------------------------
class Colorizer{
  static Gradient superSlideGradient(){
    Gradient slideGradient = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: <Color>[Colorz.Black200, Colorz.Black0],
        stops: <double>[0,0.90]
    );
    return slideGradient;
  }
// -----------------------------------------------------------------------------
  static Gradient superHeaderStripGradient(Color color){
    Gradient headerStripGradient = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: <Color>[Colorz.Nothing, color],
        stops: <double>[0.3, 1]);
    return headerStripGradient;
  }
// -----------------------------------------------------------------------------
  static Gradient superFollowBTGradient(){
    Gradient followBTGradient = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: <Color>[Colorz.White50, Colorz.Nothing],
        stops: <double>[0, 0.5]
    );
    return followBTGradient;
  }
// -----------------------------------------------------------------------------
  static ImageFilter superBlur(bool trigger){
    double blueValue = trigger == true ? 8 : 0;
    ImageFilter blur = ImageFilter.blur(sigmaX: blueValue, sigmaY: blueValue);
    return blur;
  }
// -----------------------------------------------------------------------------
  /// if i want to black and white a widget, put it as child in here
  /// child: ColorFiltered(
  ///     colorFilter: superDesaturation(blackAndWhite),
  ///     child: ,
  static ColorFilter superDesaturation(bool isItBlackAndWhite){
    Color imageSaturationColor = isItBlackAndWhite == true ? Colorz.Grey225 : Colorz.Nothing;
    return ColorFilter.mode(
        imageSaturationColor,
        BlendMode.saturation
    );
  }

}
// -----------------------------------------------------------------------------
class BlurLayer extends StatelessWidget {
  final BorderRadius borders;
  final double blur;
  final double width;
  final double height;
  final Color color;

  BlurLayer({
    this.borders,
    this.blur = Ratioz.blur1,
    this.width = double.infinity,
    this.height = double.infinity,
    this.color = Colorz.Nothing
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // child: ClipRRect(
      //   borderRadius: borders,
      //   child: BackdropFilter(
      //     filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
      //     child: Container(
      //       width: width,
      //       height: height,
      //       decoration: BoxDecoration(
      //         color: color,
      //         borderRadius: borders,
      //       ),
      //     ),
      //   ),
      // ),
    );
  }
}
// -----------------------------------------------------------------------------
