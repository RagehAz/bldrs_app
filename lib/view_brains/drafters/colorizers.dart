import 'package:bldrs/view_brains/theme/colorz.dart';
import 'package:flutter/material.dart';
import 'dart:ui';

Gradient superSlideGradient(){
  Gradient slideGradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [Color.fromARGB(50, 0, 0, 0), Colorz.Nothing],
      stops: [0.45,1]
  );
  return slideGradient;
}

Gradient superHeaderStripGradient(){
  Gradient headerStripGradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [Colorz.Nothing, Colorz.WhiteZircon],
      stops: [0.3, 1]);
return headerStripGradient;
}

Gradient superFollowBTGradient(){
  Gradient followBTGradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [Colorz.WhiteZircon, Colorz.Nothing],
      stops: [0, 0.5]
  );
return followBTGradient;
}

ImageFilter superBlur(bool trigger){
  double blueValue = trigger == true ? 8 : 0;
  ImageFilter blur = ImageFilter.blur(sigmaX: blueValue, sigmaY: blueValue);
  return blur;
}

