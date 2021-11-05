

import 'dart:convert';

import 'package:bldrs/controllers/drafters/object_checkers.dart';
import 'package:bldrs/views/widgets/general/loading/loading.dart';
import 'package:flutter/material.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';
import 'package:websafe_svg/websafe_svg.dart';

class SuperImage extends StatelessWidget {
  final dynamic pic;
  final double width;
  final double height;
  final BoxFit fit;
  final double scale;
  final Color  iconColor;

  const SuperImage(
      this.pic,
      {
        this.width,
        this.height,
        this.fit,
        this.scale,
        this.iconColor,
      });

// -----------------------------------------------------------------------------
  static DecorationImage decorationImage({@required String picture, BoxFit boxFit}){
    DecorationImage _image;

    if (picture != null && picture != ''){

      _image = DecorationImage(
        image: AssetImage(picture),
        fit: boxFit ?? BoxFit.cover,
      );

    }

    return picture == '' ? null : _image;
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final BoxFit _boxFit = fit == null ? BoxFit.cover : fit;
    // int _width = fit == BoxFit.fitWidth ? width : null;
    // int _height = fit == BoxFit.fitHeight ? height : null;
    // Asset _asset = ObjectChecker.objectIsAsset(pic) == true ? pic : null;
    final double _scale = scale == null ? 1 : scale;
    final Color _iconColor = iconColor == null ? null : iconColor;

    return
      pic == null ? null :
      Transform.scale(
        scale: _scale,
        child:
        ObjectChecker.objectIsJPGorPNG(pic)?
        Image.asset(pic, fit: _boxFit)
            :
        ObjectChecker.objectIsSVG(pic)?
        WebsafeSvg.asset(pic, fit: _boxFit,color: _iconColor)
            :
        /// max user NetworkImage(userPic), to try it later
        ObjectChecker.objectIsURL(pic)?
        Image.network(pic, fit: _boxFit)
            :
        ObjectChecker.objectIsFile(pic)?
        Image.file(
          pic,
          fit: _boxFit,
          width: width,
          height: height,
        )
            :
        ObjectChecker.objectIsUint8List(pic) || ObjectChecker.isBase64(pic) ? // Image.memory(logoBase64!);
        Image.memory(base64Decode(pic),
          fit: _boxFit,
          // width: width?.toDouble(),
          // height: height?.toDouble(),
        )
            :
        ObjectChecker.objectIsAsset(pic)?
        AssetThumb(
          asset: pic,
          width: (pic.originalWidth).toInt(),
          height: (pic.originalHeight).toInt(),
          spinner: const Loading(loading: true,),
        )
            :
        Container(),

      );
  }
}
