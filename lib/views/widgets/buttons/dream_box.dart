import 'dart:io';
import 'package:bldrs/view_brains/drafters/iconizers.dart';
import 'package:bldrs/view_brains/drafters/shadowers.dart';
import 'package:bldrs/view_brains/theme/colorz.dart';
import 'package:bldrs/view_brains/theme/ratioz.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';
import 'package:websafe_svg/websafe_svg.dart';

class DreamBox extends StatelessWidget {
  final String icon;
  final File iconFile;
  /// works as a verseSizeFactor as well
  final double iconSizeFactor;
  final Color color;
  final double width;
  final double height;
  final double corners;
  final Color iconColor;
  final String verse;
  final Color verseColor;
  final VerseWeight verseWeight;
  final double verseScaleFactor;
  final bool verseItalic;
  final int verseMaxLines;
  final Function boxFunction;
  final EdgeInsets boxMargins;
  final bool blackAndWhite;
  final bool iconRounded;
  final bool bubble;
  final String secondLine;
  final Widget dreamChild;
  final double opacity;

  DreamBox({
    @required this.height,
    this.width,
    this.icon,
    this.iconFile,
    this.iconSizeFactor = 1,
    this.color = Colorz.Nothing,
    this.corners = Ratioz.ddBoxCorner *1.5,
    this.iconColor,
    this.verse,
    this.verseColor = Colorz.White,
    this.verseWeight = VerseWeight.bold,
    this.verseScaleFactor = 1,
    this.verseItalic = false,
    this.verseMaxLines = 1,
    this.boxFunction,
    this.boxMargins,
    this.blackAndWhite = false,
    this.iconRounded = true,
    this.bubble = true,
    this.secondLine,
    this.dreamChild,
    this.opacity = 1,
  });

  @override
  Widget build(BuildContext context) {

    double sizeFactor = iconSizeFactor;

    // double boxWidth = width ;
    double boxHeight = height ;

    Color imageSaturationColor =
        blackAndWhite == true ? Colorz.Grey : Colorz.Nothing;


    double verseIconSpacing = verse != null ? height * 0.3 * iconSizeFactor * verseScaleFactor : 0;

    double svgGraphicWidth = height * sizeFactor;
    double jpgGraphicWidth = height * sizeFactor;
    double graphicWidth = icon == null ? 0 :
        fileExtensionOf(icon) == 'svg' ? svgGraphicWidth :
        fileExtensionOf(icon) == 'jpg' ||
        fileExtensionOf(icon) == 'jpeg' ||
        fileExtensionOf(icon) == 'png' ? jpgGraphicWidth : height;

    double iconMargin = verse == null || icon == null ? 0 : (height - graphicWidth)/2;

    double verseWidth = width != null ? width - (iconMargin * 2) - graphicWidth - ((verseIconSpacing * 2) + iconMargin) : width;

    int verseSize =  iconSizeFactor == 1 ? 4 : 4;

    double iconCorners = iconRounded == true ? (corners-iconMargin) : 0;

    Color boxColor =
    (blackAndWhite == true && color != Colorz.Nothing) ?
    Colorz.GreySmoke :
    (color == Colorz.Nothing && blackAndWhite == true) ?
    Colorz.Nothing :
    color;

    Color _iconColor = blackAndWhite == true ? Colorz.WhiteSmoke : iconColor;

    return GestureDetector(
      onTap: boxFunction,

      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[

          IntrinsicWidth(

            child: Opacity(
              opacity: opacity,
              child: Container(
                width: width,
                height: boxHeight,
                alignment: Alignment.center,
                margin: boxMargins,
                decoration: BoxDecoration(
                    color: boxColor,
                    borderRadius: BorderRadius.circular(corners),
                    boxShadow: [
                      CustomBoxShadow(
                          color: bubble == true ? Colorz.BlackLingerie : Colorz.Nothing,
                          offset: new Offset(0, height * -0.019 * 0 ),
                          blurRadius: height * 0.15,
                          blurStyle: BlurStyle.outer),
                    ]
                ),

                child: ClipRRect(
                  borderRadius: BorderRadius.circular(corners),

                  child: Stack(
                    alignment: Alignment.center,
                    children: [

                      dreamChild == null ? Container() :
                      Container(
                        height: height,
                        width: width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(corners),
                        ),
                        child: dreamChild,
                      ),

                      Row(
                        mainAxisAlignment: verse != null ? MainAxisAlignment.start : MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[

                          // --- ICON
                          Stack(
                            alignment: Alignment.center,
                            children: [
                                iconFile != null ?
                            Container(
                              width: jpgGraphicWidth,
                              height: jpgGraphicWidth,
                              margin: EdgeInsets.all(iconMargin),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(iconCorners)),
                                boxShadow: [
                                  CustomBoxShadow(
                                      color: bubble == true ? Colorz.BlackLingerie : Colorz.Nothing,
                                      offset: new Offset(0, jpgGraphicWidth * -0.019 ),
                                      blurRadius: jpgGraphicWidth * 0.2,
                                      blurStyle: BlurStyle.outer),
                                ]
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.all(Radius.circular(iconCorners)),
                                child: ColorFiltered(
                                  colorFilter: ColorFilter.mode(
                                      imageSaturationColor,
                                      BlendMode.saturation),
                                  child: Container(
                                      width: jpgGraphicWidth,
                                      height: jpgGraphicWidth,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(image: FileImage(iconFile), fit: BoxFit.cover),
                                      ),
                                    ),
                                ),),
                            ) :
                            icon == null || icon == '' ?
                            Container()
                                :
                            fileExtensionOf(icon) == 'svg' ?
                            Padding(
                              padding: EdgeInsets.all(iconMargin),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.all(Radius.circular(iconCorners)),
                                  child: WebsafeSvg.asset(icon, color: _iconColor, height: svgGraphicWidth, fit: BoxFit.cover)),
                            )
                                :
                            fileExtensionOf(icon) == 'jpg' || fileExtensionOf(icon) == 'jpeg' || fileExtensionOf(icon) == 'png' ?
                            Container(
                              width: jpgGraphicWidth,
                              height: jpgGraphicWidth,
                              margin: EdgeInsets.all(iconMargin),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(iconCorners)),
                                boxShadow: [
                                  CustomBoxShadow(
                                      color: bubble == true ? Colorz.BlackLingerie : Colorz.Nothing,
                                      offset: new Offset(0, jpgGraphicWidth * -0.019 ),
                                      blurRadius: jpgGraphicWidth * 0.2,
                                      blurStyle: BlurStyle.outer),
                                ]
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.all(Radius.circular(iconCorners)),
                                child: ColorFiltered(
                                  colorFilter: ColorFilter.mode(
                                      imageSaturationColor,
                                      BlendMode.saturation),
                                  child: Container(
                                      width: jpgGraphicWidth,
                                      height: jpgGraphicWidth,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(image: AssetImage(icon), fit: BoxFit.cover),
                                      ),
                                    ),
                                ),),
                            ) :
                                    Container(),

                              // --- BUTTON BLACK LAYER IF GREYED OUT
                              blackAndWhite == true && icon != null && fileExtensionOf(icon) != 'svg'?
                              Container(
                                height: jpgGraphicWidth,
                                width: jpgGraphicWidth,
                                decoration: BoxDecoration(
                                  // color: Colorz.Yellow,
                                  borderRadius: BorderRadius.circular(iconCorners),
                                  gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [Colorz.BlackSmoke, Colorz.BlackPlastic],
                                      stops: [0.5, 1]),
                                ),
                              ) : Container(),

                            ],
                          ),

                          // --- SPACING
                          SizedBox(
                            width: iconSizeFactor != 1 && icon != null ? verseIconSpacing * 0.25 : verseIconSpacing,
                            height: height,
                          ),

                          // --- VERSE
                          verse == null ? Container() :
                          Container(
                            height: height,
                            width: verseWidth,
                            // color: Colorz.YellowSmoke, // for design purpose only
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: icon == null ? CrossAxisAlignment.center : CrossAxisAlignment.start,
                              children: <Widget>[
                                SuperVerse(
                                  verse: verse,
                                  size: verseSize,
                                  weight: verseWeight,
                                  color: blackAndWhite == true ? Colorz.WhiteSmoke : verseColor,
                                  shadow: blackAndWhite == true ? false : true,
                                  maxLines: verseMaxLines,
                                  designMode: false,
                                  centered: icon == null ? true : false,
                                  scaleFactor: iconSizeFactor * verseScaleFactor,
                                  italic: verseItalic,
                                ),

                                secondLine == null ? Container() :
                                    SuperVerse(
                                      verse: secondLine,
                                      weight: VerseWeight.regular,
                                      size: 1,
                                      color: Colorz.White,
                                      maxLines: 1,
                                      italic: true,
                                      shadow: true,
                                      centered: false,
                                    ),
                              ],
                            ),
                          ),

                          // --- SPACING
                          SizedBox(
                            width: verseIconSpacing + iconMargin,
                            height: height,
                          ),
                        ],
                      ),

                      // --- BOX HIGHLIGHT
                      bubble == false ? Container() :
                      Container(
                        width: width,
                        height: height * 0.27,
                        decoration: BoxDecoration(
                          // color: Colorz.White,
                            borderRadius: BorderRadius.circular(
                                corners - (height * 0.8) ),
                            boxShadow: [
                              CustomBoxShadow(
                                  color: Colorz.WhiteZircon,
                                  offset: new Offset(0, height * -0.33),
                                  blurRadius: height * 0.2,
                                  blurStyle: BlurStyle.normal),
                            ]),
                      ),

                      // --- BOX GRADIENT
                      bubble == false ? Container() :
                      Container(
                        height: height,
                        width: width,
                        decoration: BoxDecoration(
                          // color: Colorz.Grey,
                          borderRadius: BorderRadius.circular(corners),
                          gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [Colorz.BlackNothing, Colorz.BlackPlastic],
                              stops: [0.5, 0.95]),
                        ),
                      ),

                    ],
                  ),
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }
}
