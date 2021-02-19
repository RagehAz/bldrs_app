import 'package:flutter/material.dart';
import 'package:websafe_svg/websafe_svg.dart';

import 'file_formatters.dart';
// === === === === === === === === === === === === === === === === === === ===
DecorationImage superImage(String picture, BoxFit boxFit){
  DecorationImage image = DecorationImage(
    image: AssetImage(picture),
    fit: boxFit,
  );

  return picture == '' ? null : image;
}
// === === === === === === === === === === === === === === === === === === ===

Widget superImageWidget(dynamic pic){
  return
    objectIsJPGorPNG(pic)?
    Image.asset(pic, fit: BoxFit.cover,)
        :
    objectIsSVG(pic)?
    WebsafeSvg.asset(pic, fit: BoxFit.cover)
        :
    /// max user NetworkImage(userPic), to try it later
    objectIsURL(pic)?
    Image.network(pic, fit: BoxFit.cover,)
        :
    Container();
}