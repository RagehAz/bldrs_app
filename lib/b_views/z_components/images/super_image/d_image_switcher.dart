import 'dart:convert';
import 'dart:typed_data';

import 'package:bldrs/b_views/z_components/images/local_asset_checker.dart';
import 'package:bldrs/b_views/z_components/images/super_image/b_future_image.dart';
import 'package:bldrs/f_helpers/drafters/borderers.dart';
import 'package:bldrs/f_helpers/drafters/floaters.dart';
import 'package:bldrs/f_helpers/drafters/object_checkers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:flutter/material.dart';
import 'package:websafe_svg/websafe_svg.dart';

class ImageSwitcher extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const ImageSwitcher({
    @required this.width,
    @required this.height,
    @required this.pic,
    @required this.boxFit,
    @required this.scale,
    @required this.iconColor,
    @required this.loading,
    @required this.backgroundColor,
    @required this.corners,
    @required this.greyscale,
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
  // -----------------------------------------------------------------------------
  static const bool _gaplessPlayback = true;
  // -----------------------------------------------------------------------------
  Widget _errorBuilder (BuildContext ctx, Object error, StackTrace stackTrace) {
    blog('SUPER IMAGE ERROR : ${pic.runtimeType} : error : $error');
    return Container(
      width: width,
      height: height,
      color: Colorz.white10,
      // child: const SuperVerse(
      //   verse: Verse(
      //     text: 'phid_error',
      //     translate: true,
      //     casing: Casing.lowerCase,
      //   ),
      //   size: 0,
      //   maxLines: 2,
      // ),
    );
  }
  // --------------------
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
  // --------------------
  Widget _futureImageBuilder (BuildContext ctx, AsyncSnapshot<Uint8List> snapshot){

    return FutureImage(
      snapshot: snapshot,
      width: width,
      height: height,
      boxFit: boxFit,
      errorBuilder: _errorBuilder,
    );

  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return ClipRRect(
      key: const ValueKey<String>('SuperImage'),
      borderRadius: Borderers.superCorners(
        context: context,
        corners: corners,
      ),
      child: ColorFiltered(
        colorFilter: ColorFilter.mode(greyscale == true ? Colorz.grey255 : Colorz.nothing, BlendMode.saturation),
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
            ObjectCheck.objectIsJPGorPNG(pic) ?
            LocalAssetChecker(
              key: const ValueKey<String>('SuperImage_png_or_jpg'),
              asset: pic,
              child: Image.asset(
                pic,
                fit: boxFit,
                width: width,
                height: height,
                errorBuilder: _errorBuilder,
                scale: 1,
                gaplessPlayback: _gaplessPlayback,
              ),
            )

                :

            /// SVG
            ObjectCheck.objectIsSVG(pic) ?
            LocalAssetChecker(
              key: const ValueKey<String>('SuperImage_svg'),
              asset: pic,
              child: WebsafeSvg.asset(
                pic,
                fit: boxFit,
                color: iconColor,
                width: width,
                height: height,
              ),
            )

                :

            /// URL
            ObjectCheck.isAbsoluteURL(pic) ?
            Image.network(
              pic,
              key: const ValueKey<String>('SuperImage_url'),
              fit: boxFit,
              width: width,
              height: height,
              errorBuilder: _errorBuilder,
              gaplessPlayback: _gaplessPlayback,
              loadingBuilder: _loadingBuilder,
            )

                :

            /// FILE
            ObjectCheck.objectIsFile(pic) ?
            Image.file(
              pic,
              key: const ValueKey<String>('SuperImage_file'),
              fit: boxFit,
              width: width,
              height: height,
              errorBuilder: _errorBuilder,
              gaplessPlayback: _gaplessPlayback,
            )

                :

            /// UINT8LIST
            ObjectCheck.objectIsUint8List(pic) ?
            Image.memory(
              pic,
              key: const ValueKey<String>('SuperImage_uInt8List'),
              fit: boxFit,
              width: width,
              height: height,
              gaplessPlayback: _gaplessPlayback,
              errorBuilder: _errorBuilder,
              // cacheWidth: 0,
              // cacheHeight: 0,
            )

                :

            /// BASE64
            ObjectCheck.isBase64(pic) ?
            Image.memory(
              base64Decode(pic),
              key: const ValueKey<String>('SuperImage_base64'),
              fit: boxFit,
              width: width,
              height: height,
              errorBuilder: _errorBuilder,
              // scale: 1,
            )

                :

            /// UI.IMAGE
            ObjectCheck.objectIsUiImage(pic) ?
            FutureBuilder(
              key: const ValueKey<String>('SuperImage_uiImage'),
              future: Floaters.getUint8ListFromUiImage(pic),
              builder: _futureImageBuilder,
            )

                :

            /// IMG.IMAGE
            ObjectCheck.objectIsImgImage(pic) ?
            Image.memory(
              Floaters.getUint8ListFromImgImage(pic),
              key: const ValueKey<String>('SuperImage_imgImage'),
              fit: boxFit,
              width: width,
              height: height,
              errorBuilder: _errorBuilder,
              // scale: 1,
            )

                :

            Image.asset(
              Iconz.dvGouran,
              key: const ValueKey<String>('SuperImage_other'),
              fit: boxFit,
              width: width,
              height: height,
              errorBuilder: _errorBuilder,
              scale: 1,
            ),

          ),
        ),
      ),
    );

  }
  // -----------------------------------------------------------------------------
}
