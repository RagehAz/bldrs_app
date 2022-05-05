import 'dart:convert';

import 'package:bldrs/b_views/z_components/animators/widget_fader.dart';
import 'package:bldrs/b_views/z_components/loading/loading.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
import 'package:bldrs/f_helpers/drafters/borderers.dart';
import 'package:bldrs/f_helpers/drafters/object_checkers.dart' as ObjectChecker;
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart' as Iconz;
import 'package:flutter/material.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';
import 'package:websafe_svg/websafe_svg.dart';

class SuperImage extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const SuperImage({
    @required this.width,
    @required this.height,
    @required this.pic,
    this.boxFit = BoxFit.cover,
    this.scale = 1,
    this.iconColor,
    this.loading = false,
    this.backgroundColor,
    this.corners,
    this.greyscale = false,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final dynamic pic;
  final double width;
  final double height;
  final BoxFit boxFit;
  final double scale;
  final Color iconColor;
  final bool loading;
  final Color backgroundColor;
  final dynamic corners;
  final bool greyscale;
  /// --------------------------------------------------------------------------
  static const bool _gaplessPlayback = true;
// -----------------------------------------------------------------------------
  static DecorationImage decorationImage({
    @required String picture,
    BoxFit boxFit
  }) {
    DecorationImage _image;

    if (picture != null && picture != '') {
      _image = DecorationImage(
        image: AssetImage(picture),
        fit: boxFit ?? BoxFit.cover,
      );
    }

    return picture == '' ? null : _image;
  }
// -----------------------------------------------------------------------------
  Widget _errorBuilder (BuildContext ctx, Object error, StackTrace stackTrace) {
    blog('SUPER IMAGE ERROR : ${pic.runtimeType} : error : $error');
    return Container(
      width: width,
      height: height,
      color: Colorz.white10,
    );
  }
// -----------------------------------------------------------------------------
  Widget _loadingBuilder(BuildContext context , Widget child, ImageChunkEvent imageChunkEvent){

    // blog('SUPER IMAGE LOADING BUILDER : imageChunkEvent.cumulativeBytesLoaded : ${imageChunkEvent?.cumulativeBytesLoaded} / ${imageChunkEvent?.expectedTotalBytes}');

    /// AFTER LOADED
    if (imageChunkEvent == null){
      return child;
    }
    /// WHILE LOADING
    else {

      final double _percentage = imageChunkEvent.cumulativeBytesLoaded / imageChunkEvent.expectedTotalBytes;

      return Container(
        width: width,
        height: height,
        color: Colorz.white50,
        alignment: Alignment.bottomCenter,
        child: Container(
          width: width,
          height: height * _percentage,
          color: backgroundColor ?? Colorz.white20,
        ),
      );
    }

  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    /// PIC IS NULL
    if (pic == null){
      return const SizedBox();
    }

    /// ON LOADING
    else if (loading == true){
      return Loading(
        size: height,
        loading: loading,
      );
    }

    /// IMAGE
    else {

      final Color _imageSaturationColor = greyscale == true ? Colorz.grey255 : Colorz.nothing;

      return ClipRRect(
        key: const ValueKey<String>('SuperImage'),
        borderRadius: superBorder(
          context: context,
          corners: corners,
        ),
        child: ColorFiltered(
          colorFilter: ColorFilter.mode(_imageSaturationColor, BlendMode.saturation),
          child: Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              color: backgroundColor,
                // boxShadow: <BoxShadow>[
                //   Shadowz.CustomBoxShadow(
                //       color: bubble == true ? Colorz.black200 : Colorz.nothing,
                //       offset: Offset(0, width * -0.019),
                //       blurRadius: width * 0.2,
                //       style: BlurStyle.outer
                //   ),
                // ]
            ),
            alignment: Alignment.center,
            child: Transform.scale(
              scale: scale,
              child:

              /// JPG OR PNG
              ObjectChecker.objectIsJPGorPNG(pic) ?
              Image.asset(
                pic,
                fit: boxFit,
                width: width,
                height: height,
                errorBuilder: _errorBuilder,
                scale: 1,
                gaplessPlayback: _gaplessPlayback,
              )

                  :

              /// SVG
              ObjectChecker.objectIsSVG(pic) ?
              WebsafeSvg.asset(
                pic,
                fit: boxFit,
                color: iconColor,
                width: width,
                height: height,
              )

                  :

              /// URL
              ObjectChecker.objectIsURL(pic) ?
              Image.network(
                pic,
                fit: boxFit,
                width: width,
                height: height,
                errorBuilder: _errorBuilder,
                gaplessPlayback: _gaplessPlayback,
                loadingBuilder: _loadingBuilder,
              )

                  :

              /// FILE
              ObjectChecker.objectIsFile(pic) ?
              Image.file(
                pic,
                fit: boxFit,
                width: width,
                height: height,
                errorBuilder: _errorBuilder,
                gaplessPlayback: _gaplessPlayback,
              )

                  :

              /// UINT8LIST
              ObjectChecker.objectIsUint8List(pic) ?
              Image.memory(
                pic,
                fit: boxFit,
                width: width,
                height: height,
                gaplessPlayback: _gaplessPlayback,
                errorBuilder: _errorBuilder,
              )

                  :

              /// BASE64
              ObjectChecker.isBase64(pic) ?
              Image.memory(
                base64Decode(pic),
                fit: boxFit,
                width: width,
                height: height,
                errorBuilder: _errorBuilder,
                // scale: 1,

              )

                  :

              /// ASSET
              ObjectChecker.objectIsAsset(pic) ?
              AssetThumb(
                asset: pic,
                width: width.toInt(), //(pic.originalWidth).toInt(),
                height: height.toInt(), //(pic.originalHeight).toInt(),
                // quality: 100,
                spinner: const Loading(
                  loading: true,
                ),
              )

                  :

              Image.asset(
                Iconz.dvGouran,
                fit: boxFit,
                width: width,
                height: height,
                errorBuilder: _errorBuilder,
                scale: 1,
              )
              ,

            ),
          ),
        ),
      );
    }

  }
}
