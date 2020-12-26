
import 'package:flutter/material.dart';

DecorationImage superImage(String picture){
  DecorationImage image = DecorationImage(
    image: AssetImage(picture),
    fit: BoxFit.cover,
  );

  return picture == '' ? null : image;
}