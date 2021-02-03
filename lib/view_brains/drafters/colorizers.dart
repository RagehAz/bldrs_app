import 'package:bldrs/view_brains/theme/colorz.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
// === === === === === === === === === === === === === === === === === === ===
Gradient superSlideGradient(){
  Gradient slideGradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [Colorz.BlackLingerie, Colorz.BlackNothing],
      stops: [0,0.90]
  );
  return slideGradient;
}
// === === === === === === === === === === === === === === === === === === ===
Gradient superHeaderStripGradient(Color color){
  Gradient headerStripGradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [Colorz.Nothing, color],
      stops: [0.3, 1]);
return headerStripGradient;
}
// === === === === === === === === === === === === === === === === === === ===
Gradient superFollowBTGradient(){
  Gradient followBTGradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [Colorz.WhiteZircon, Colorz.Nothing],
      stops: [0, 0.5]
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
    this.blur = 10,
    this.width = double.infinity,
    this.height = double.infinity,
});
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borders,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
              color: Colorz.WhiteAir,
              borderRadius: borders,
          ),
        ),
      ),
    );
  }
}
