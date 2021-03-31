import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
// === === === === === === === === === === === === === === === === === === ===
Gradient superSlideGradient(){
  Gradient slideGradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: <Color>[Colorz.BlackLingerie, Colorz.BlackNothing],
      stops: <double>[0,0.90]
  );
  return slideGradient;
}
// === === === === === === === === === === === === === === === === === === ===
Gradient superHeaderStripGradient(Color color){
  Gradient headerStripGradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: <Color>[Colorz.Nothing, color],
      stops: <double>[0.3, 1]);
return headerStripGradient;
}
// === === === === === === === === === === === === === === === === === === ===
Gradient superFollowBTGradient(){
  Gradient followBTGradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: <Color>[Colorz.WhiteZircon, Colorz.Nothing],
      stops: <double>[0, 0.5]
  );
return followBTGradient;
}
// === === === === === === === === === === === === === === === === === === ===
ImageFilter superBlur(bool trigger){
  double blueValue = trigger == true ? 8 : 0;
  ImageFilter blur = ImageFilter.blur(sigmaX: blueValue, sigmaY: blueValue);
  return blur;
}
// === === === === === === === === === === === === === === === === === === ===
class BlurLayer extends StatelessWidget {
  final BorderRadius borders;
  final double blur;
  final double width;
  final double height;

  BlurLayer({
    this.borders,
    this.blur = Ratioz.blur1,
    this.width = double.infinity,
    this.height = double.infinity,
});

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colorz.BloodTest,
      child: ClipRRect(
        borderRadius: borders,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
          child: Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              color: Colorz.WhiteGlass,
              borderRadius: borders,
            ),
          ),
        ),
      ),
    );
  }
}
// === === === === === === === === === === === === === === === === === === ===
/// if i want to black and white a widget, put it as child in here
// child: ColorFiltered(
//     colorFilter: superDesaturation(blackAndWhite),
//     child: ,

ColorFilter superDesaturation(bool isItBlackAndWhite){
  Color imageSaturationColor = isItBlackAndWhite == true ? Colorz.Grey : Colorz.Nothing;
  return ColorFilter.mode(
      imageSaturationColor,
      BlendMode.saturation
  );
}
// === === === === === === === === === === === === === === === === === === ===
