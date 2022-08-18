import 'dart:convert';
import 'dart:typed_data';
import 'package:bldrs/b_views/z_components/animators/widget_fader.dart';
import 'package:bldrs/b_views/z_components/images/local_asset_checker.dart';
import 'package:bldrs/b_views/z_components/loading/loading.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
import 'package:bldrs/f_helpers/drafters/borderers.dart';
import 'package:bldrs/f_helpers/drafters/floaters.dart';
import 'package:bldrs/f_helpers/drafters/object_checkers.dart';
import 'package:bldrs/f_helpers/drafters/stream_checkers.dart';
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:flutter/material.dart';
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
      color: Colorz.red255, // Colorz.white10,
      child: const SuperVerse(
        verse: 'FOKING ERROR',
        size: 0,
        maxLines: 2,
      ),
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
  Widget _futureImageBuilder (BuildContext ctx, AsyncSnapshot<Uint8List> snapshot){

    return _FutureImage(
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
        borderRadius: Borderers.superBorder(
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
              ObjectChecker.objectIsSVG(pic) ?
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
              ObjectChecker.objectIsURL(pic) ?
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
              ObjectChecker.objectIsFile(pic) ?
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
              ObjectChecker.objectIsUint8List(pic) ?
              Image.memory(
                pic,
                key: const ValueKey<String>('SuperImage_uInt8List'),
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
                key: const ValueKey<String>('SuperImage_base64'),
                fit: boxFit,
                width: width,
                height: height,
                errorBuilder: _errorBuilder,
                // scale: 1,
              )

                  :

              /// UI.IMAGE
              ObjectChecker.objectIsUiImage(pic) ?
              FutureBuilder(
                key: const ValueKey<String>('SuperImage_uiImage'),
                future: Floaters.getUint8ListFromUiImage(pic),
                builder: _futureImageBuilder,
              )

                  :

              /// IMG.IMAGE
              ObjectChecker.objectIsImgImage(pic) ?
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

  }
}

class _FutureImage extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const _FutureImage({
    @required this.snapshot,
    @required this.width,
    @required this.height,
    @required this.boxFit,
    @required this.errorBuilder,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final AsyncSnapshot<Uint8List> snapshot;
  final double width;
  final double height;
  final BoxFit boxFit;
  final Function(BuildContext, Object, StackTrace) errorBuilder;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    /// LOADING
    if (Streamer.connectionIsLoading(snapshot) == true){
      return InfiniteLoadingBox(
        width: width,
        height: height,
      );
    }

    /// UI.IMAGE
    else {

      return Image.memory(
        snapshot.data,
        fit: boxFit,
        width: width,
        height: height,
        errorBuilder: errorBuilder,
        // scale: 1,
      );
    }

  }
}

class InfiniteLoadingBox extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const InfiniteLoadingBox({
    @required this.width,
    @required this.height,
    this.color,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double width;
  final double height;
  final Color color;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return WidgetFader(
      fadeType: FadeType.repeatForwards,
      curve: Curves.decelerate,
      duration: const Duration(milliseconds: 1000),
      builder: (double value, Widget child){

        final double _percentage = value / 1;

        return Container(
          width: width,
          height: height,
          color: Colorz.white50,
          alignment: Alignment.bottomCenter,
          child: Container(
            width: width,
            height: height * _percentage,
            color: color ?? Colorz.white20,
          ),
        );

      },
    );
  }
}
