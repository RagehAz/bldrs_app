import 'dart:io';
import 'package:bldrs/controllers/drafters/object_checkers.dart';
import 'package:bldrs/controllers/drafters/shadowers.dart';
import 'package:bldrs/controllers/drafters/text_directionerz.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/views/widgets/loading/loading.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';
import 'package:websafe_svg/websafe_svg.dart';



class DreamBoxIconVerseSecondLine extends StatelessWidget {
  final String verse;
  final TextDirection textDirection;
  final String icon;
  final bool loading;
  final String underLine;
  final double width;
  final double height;
  final BorderRadius iconCorners;
  final File iconFile;
  final double iconMargin;
  final Color imageSaturationColor;
  final bool bubble;
  final bool blackAndWhite;
  final Color iconColor;
  final double iconSizeFactor;
  final double verseScaleFactor;
  final bool verseCentered;
  final String secondLine;
  final int verseSize;
  final VerseWeight verseWeight;
  final bool inActiveMode;
  final Color verseColor;
  final bool verseShadow;
  final int verseMaxLines;
  final bool verseItalic;
  final bool redDot;
  final double secondLineScaleFactor;
  final Color secondLineColor;


  const DreamBoxIconVerseSecondLine({
    @required this.verse,
    @required this.textDirection,
    @required this.icon,
    @required this.loading,
    @required this.underLine,
    @required this.height,
    @required this.width,
    @required this.iconCorners,
    @required this.iconFile,
    @required this.iconMargin,
    @required this.imageSaturationColor,
    @required this.bubble,
    @required this.blackAndWhite,
    @required this.iconColor,
    @required this.iconSizeFactor,
    @required this.verseScaleFactor,
    @required this.verseCentered,
    @required this.secondLine,
    @required this.verseSize,
    @required this.verseWeight,
    @required this.inActiveMode,
    @required this.verseColor,
    @required this.verseShadow,
    @required this.verseMaxLines,
    @required this.verseItalic,
    @required this.redDot,
    @required this.secondLineScaleFactor,
    @required this.secondLineColor,
    Key key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    TextDirection _textDirection = textDirection == null ? superTextDirection(context) : textDirection;

    double _svgGraphicWidth = height * iconSizeFactor;
    double _jpgGraphicWidth = height * iconSizeFactor;

    double _graphicWidth = icon == null && loading == false ? 0 :
    ObjectChecker.fileExtensionOf(icon) == 'svg' ? _svgGraphicWidth :
    ObjectChecker.fileExtensionOf(icon) == 'jpg' ||
        ObjectChecker.fileExtensionOf(icon) == 'jpeg' ||
        ObjectChecker.fileExtensionOf(icon) == 'png' ? _jpgGraphicWidth : height;

    double _verseIconSpacing = verse != null ? height * 0.3 * iconSizeFactor * verseScaleFactor : 0;

    double _verseWidth = width != null ? width - (iconMargin * 2) - _graphicWidth - ((_verseIconSpacing * 2) + iconMargin) : width;

    CrossAxisAlignment _versesCrossAlignment =
    icon == null && textDirection == null && secondLine == null ? CrossAxisAlignment.center
        :
    textDirection != null ? CrossAxisAlignment.start // dunno why
        :
    (icon != null && secondLine != null) || (verseCentered == false) ? CrossAxisAlignment.start
        :
    CrossAxisAlignment.center; // verseCentered


    return Row(
      mainAxisAlignment: verse == null ? MainAxisAlignment.center : MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      // mainAxisSize: MainAxisSize.min,
      textDirection: _textDirection,
      children: <Widget>[

        /// --- ICON & UNDERLINE BOX footprint
        if (icon != null || loading == true)
          Container(
            width: underLine == null ? height : width,
            height: underLine == null ? height : height,
            alignment: Alignment.topCenter,

            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[

                /// ICON
                Container(
                  width: underLine == null ? height : width,
                  height: underLine == null ? height : width,

                  decoration: BoxDecoration(
                    borderRadius: iconCorners,
                    // color: Colorz.BloodTest
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: <Widget>[

                      loading == true ?
                      Container(
                        width: _jpgGraphicWidth,
                        height: _jpgGraphicWidth,
                        child: Loading(loading: loading,),
                      )
                          :
                      iconFile != null ?
                      Container(
                        width: _jpgGraphicWidth,
                        height: _jpgGraphicWidth,
                        margin: EdgeInsets.all(iconMargin),
                        decoration: BoxDecoration(
                            borderRadius: iconCorners,
                            boxShadow: <CustomBoxShadow>[
                              CustomBoxShadow(
                                  color: bubble == true ? Colorz.Black200 : Colorz.Nothing,
                                  offset: new Offset(0, _jpgGraphicWidth * -0.019 ),
                                  blurRadius: _jpgGraphicWidth * 0.2,
                                  blurStyle: BlurStyle.outer),
                            ]
                        ),
                        child: ClipRRect(
                          borderRadius: iconCorners,
                          child: ColorFiltered(
                            colorFilter: ColorFilter.mode(
                                imageSaturationColor,
                                BlendMode.saturation),
                            child: Container(
                              width: _jpgGraphicWidth,
                              height: _jpgGraphicWidth,
                              decoration: BoxDecoration(
                                borderRadius: iconCorners,
                                image: DecorationImage(image: FileImage(iconFile), fit: BoxFit.cover),
                              ),
                            ),
                          ),),
                      )
                          :
                      icon == null || icon == '' ?
                      Container()
                          :
                      ObjectChecker.objectIsSVG(icon) ?
                      Padding(
                        padding: EdgeInsets.all(iconMargin),
                        child: ClipRRect(
                            borderRadius: iconCorners,
                            child: WebsafeSvg.asset(icon, color: iconColor, height: _svgGraphicWidth, fit: BoxFit.cover)),
                      )
                          :
                      ObjectChecker.objectIsJPGorPNG(icon) ?
                      Container(
                        width:
                        _jpgGraphicWidth,
                        height:
                        _jpgGraphicWidth,
                        margin: EdgeInsets.all(iconMargin),
                        decoration: BoxDecoration(
                            borderRadius: iconCorners,
                            boxShadow: <BoxShadow>[
                              CustomBoxShadow(
                                  color: bubble == true ? Colorz.Black200 : Colorz.Nothing,
                                  offset: new Offset(0,
                                      _jpgGraphicWidth * -0.019 ),
                                  blurRadius:
                                  _jpgGraphicWidth * 0.2,
                                  blurStyle: BlurStyle.outer),
                            ]
                        ),
                        child: ClipRRect(
                          borderRadius: iconCorners,
                          child: ColorFiltered(
                            colorFilter: ColorFilter.mode(
                                imageSaturationColor,
                                BlendMode.saturation),
                            child: Container(
                              width:
                              _jpgGraphicWidth,
                              height:
                              _jpgGraphicWidth,
                              decoration: BoxDecoration(
                                image: DecorationImage(image: AssetImage(icon), fit: BoxFit.cover),
                              ),
                            ),
                          ),),
                      )
                          :
                      ObjectChecker.objectIsURL(icon) ? /// WORK WITH FILE
                      Container(
                        width:
                        _jpgGraphicWidth,
                        height:
                        _jpgGraphicWidth,
                        margin: EdgeInsets.all(iconMargin),
                        decoration: BoxDecoration(
                            borderRadius: iconCorners,
                            boxShadow: <BoxShadow>[
                              CustomBoxShadow(
                                  color: bubble == true ? Colorz.Black200 : Colorz.Nothing,
                                  offset: new Offset(0,
                                      _jpgGraphicWidth * -0.019 ),
                                  blurRadius:
                                  _jpgGraphicWidth * 0.2,
                                  blurStyle: BlurStyle.outer),
                            ]
                        ),
                        child: ClipRRect(
                          borderRadius: iconCorners,
                          child: ColorFiltered(
                            colorFilter: ColorFilter.mode(
                                imageSaturationColor,
                                BlendMode.saturation),
                            child: Container(
                              width:
                              _jpgGraphicWidth,
                              height:
                              _jpgGraphicWidth,
                              decoration: BoxDecoration(
                                borderRadius: iconCorners,
                                image: DecorationImage(image: NetworkImage(icon), fit: BoxFit.cover),
                              ),
                            ),
                          ),),
                      )
                          :
                      Container(),

                      // --- BUTTON BLACK LAYER IF GREYED OUT
                      blackAndWhite == true && icon != null && ObjectChecker.fileExtensionOf(icon) != 'svg'?
                      Container(
                        height:
                        _jpgGraphicWidth,
                        width:
                        _jpgGraphicWidth,
                        decoration: BoxDecoration(
                          // color: Colorz.Yellow,
                          borderRadius: iconCorners,
                          gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: <Color>[Colorz.Black80, Colorz.Black125],
                              stops: <double>[0.5, 1]),
                        ),
                      ) : Container(),

                    ],
                  ),
                ),

                // /// --- THE UnderLine foorprint
                // if (underLine != null)
                // Container(
                //   width: width,
                //   height: _underlineHeight,
                // ),

              ],
            ),
          ),

        /// --- SPACING
        if (verse != null)
          SizedBox(
            width: iconSizeFactor != 1 && icon != null ? _verseIconSpacing * 0.25 : _verseIconSpacing,
            height: height,
          ),

        /// --- VERSES
        if (verse != null)
          Container(
            height: height,
            width: _verseWidth,
            // color: Colorz.Yellow80, // for design purpose only
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: _versesCrossAlignment,

              children: <Widget>[
                SuperVerse(
                  verse: verse,
                  size: verseSize,
                  weight: verseWeight,
                  color: blackAndWhite == true || inActiveMode == true ? Colorz.White30 : verseColor,
                  shadow: verseShadow != null ? verseShadow : blackAndWhite == true || inActiveMode == true ? false : true,
                  maxLines: verseMaxLines,
                  designMode: false,
                  centered: icon == null ? true : false,
                  scaleFactor: iconSizeFactor * verseScaleFactor,
                  italic: verseItalic,
                  redDot: redDot,
                ),

                if (secondLine != null)
                  SuperVerse(
                    verse: secondLine,
                    weight: VerseWeight.thin,
                    size: 1,
                    color: blackAndWhite == true || inActiveMode == true ? Colorz.White30 : secondLineColor,
                    maxLines: 10,
                    italic: true,
                    shadow: blackAndWhite == true || inActiveMode == true ? false : true,
                    centered: false,
                    scaleFactor: secondLineScaleFactor,
                  ),
              ],
            ),
          ),

        /// --- SPACING
        if (verse != null)
          SizedBox(
            width: _verseIconSpacing + iconMargin,
            height: height,
          ),

      ],
    );
  }
}
