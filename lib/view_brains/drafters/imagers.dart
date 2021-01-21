import 'package:flutter/material.dart';
// === === === === === === === === === === === === === === === === === === ===
DecorationImage superImage(String picture, BoxFit boxFit){
  DecorationImage image = DecorationImage(
    image: AssetImage(picture),
    fit: boxFit,
  );

  return picture == '' ? null : image;
}
// === === === === === === === === === === === === === === === === === === ===
