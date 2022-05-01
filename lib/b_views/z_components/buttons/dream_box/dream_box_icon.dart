import 'dart:io';
import 'package:bldrs/b_views/z_components/loading/loading.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
import 'package:bldrs/f_helpers/drafters/object_checkers.dart' as ObjectChecker;
import 'package:bldrs/f_helpers/drafters/shadowers.dart' as Shadowz;
import 'package:bldrs/f_helpers/drafters/tracers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';
import 'package:websafe_svg/websafe_svg.dart';

class DreamBoxIcon extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const DreamBoxIcon(
      {@required this.verse,
      @required this.textDirection,
      @required this.icon,
      @required this.loading,
      @required this.height,
      @required this.width,
      @required this.iconCorners,
      @required this.iconFile,
      @required this.iconMargin,
      @required this.imageSaturationColor,
      @required this.bubble,
      @required this.iconColor,
      @required this.iconSizeFactor,
      @required this.verseWeight,
      Key key})
      : super(key: key);

  /// --------------------------------------------------------------------------
  final String verse;
  final TextDirection textDirection;
  final String icon;
  final bool loading;
  final double width;
  final double height;
  final BorderRadius iconCorners;
  final File iconFile;
  final double iconMargin;
  final Color imageSaturationColor;
  final bool bubble;
  final Color iconColor;
  final double iconSizeFactor;
  final VerseWeight verseWeight;

  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
// ---------------------------------------------------------
    final double _svgGraphicWidth = height * iconSizeFactor;
    final double _jpgGraphicWidth = height * iconSizeFactor;
// ---------------------------------------------------------

    if (loading == true) {
      return SizedBox(
        width: _jpgGraphicWidth,
        height: _jpgGraphicWidth,
        child: Loading(
          loading: loading,
        ),
      );
    }

    else if (iconFile != null) {
      return Container(
        width: _jpgGraphicWidth,
        height: _jpgGraphicWidth,
        margin: EdgeInsets.all(iconMargin),
        decoration: BoxDecoration(
            borderRadius: iconCorners,
            boxShadow: <BoxShadow>[
              Shadowz.CustomBoxShadow(
                  color: bubble == true ? Colorz.black200 : Colorz.nothing,
                  offset: Offset(0, _jpgGraphicWidth * -0.019),
                  blurRadius: _jpgGraphicWidth * 0.2,
                  style: BlurStyle.outer),
            ]
        ),
        child: ClipRRect(
          borderRadius: iconCorners,
          child: ColorFiltered(
            colorFilter:
                ColorFilter.mode(imageSaturationColor, BlendMode.saturation),
            child: Container(
              width: _jpgGraphicWidth,
              height: _jpgGraphicWidth,
              decoration: BoxDecoration(
                borderRadius: iconCorners,
                image: DecorationImage(
                    image: FileImage(iconFile), fit: BoxFit.cover),
              ),
            ),
          ),
        ),
      );
    }

    else if (icon == null || icon == '') {
      return Container();
    }

    else if (ObjectChecker.objectIsSVG(icon)) {
      return Padding(
        padding: EdgeInsets.all(iconMargin),
        child: WebsafeSvg.asset(icon,
            color: iconColor, height: _svgGraphicWidth, fit: BoxFit.cover),
      );
    }

    else if (ObjectChecker.objectIsJPGorPNG(icon)) {
      return Container(
        width: _jpgGraphicWidth,
        height: _jpgGraphicWidth,
        margin: EdgeInsets.all(iconMargin),
        decoration: BoxDecoration(
            borderRadius: iconCorners,
            boxShadow: <BoxShadow>[
              Shadowz.CustomBoxShadow(
              color: bubble == true ? Colorz.black200 : Colorz.nothing,
              offset: Offset(0, _jpgGraphicWidth * -0.019),
              blurRadius: _jpgGraphicWidth * 0.2,
              style: BlurStyle.outer),
        ]),
        child: ClipRRect(
          borderRadius: iconCorners,
          child: ColorFiltered(
            colorFilter:
                ColorFilter.mode(imageSaturationColor, BlendMode.saturation),
            child: SizedBox(
              width: _jpgGraphicWidth,
              height: _jpgGraphicWidth,
              // decoration: BoxDecoration(
              //   image: DecorationImage(image: AssetImage(icon), fit: BoxFit.cover),
              // ),
              child: Image.asset(
                icon,
                errorBuilder:
                    (BuildContext ctx, Object error, StackTrace stackTrace) {
                  blog('error of image is : $error');

                  return Container();
                },
              ),
            ),
          ),
        ),
      );
    }

    else if (ObjectChecker.objectIsURL(icon)) {
      return Container(
        width: _jpgGraphicWidth,
        height: _jpgGraphicWidth,
        margin: EdgeInsets.all(iconMargin),
        decoration:
            BoxDecoration(borderRadius: iconCorners, boxShadow: <BoxShadow>[
          Shadowz.CustomBoxShadow(
              color: bubble == true ? Colorz.black200 : Colorz.nothing,
              offset: Offset(0, _jpgGraphicWidth * -0.019),
              blurRadius: _jpgGraphicWidth * 0.2,
              style: BlurStyle.outer),
        ]),
        child: ClipRRect(
          borderRadius: iconCorners,
          child: ColorFiltered(
            colorFilter:
                ColorFilter.mode(imageSaturationColor, BlendMode.saturation),
            child: SizedBox(
              width: _jpgGraphicWidth,
              height: _jpgGraphicWidth,
              // decoration: BoxDecoration(
              // image: DecorationImage(image: AssetImage(icon), fit: BoxFit.cover),
              // ),
              child: Image.network(
                icon,

                /// TASK : CREATE IMAGE LOADING BUILDER
                // loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent loadingProgress){
                //
                //   blog('loadingProgress : $loadingProgress');
                //
                //   return
                //       const Loading(loading: true,);
                // },

                errorBuilder:
                    (BuildContext ctx, Object error, StackTrace stackTrace) {
                  blog('error of image is : $error');

                  return Container();
                },
              ),
            ),
          ),
        ),
      );
    }

    else {
      return Container();
    }
  }
}
