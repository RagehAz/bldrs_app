import 'dart:io';
import 'package:bldrs/view_brains/drafters/file_formatters.dart';
import 'package:bldrs/view_brains/drafters/localizers.dart';
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
  final bool inActiveMode;
  final String underLine;
  final Color splashColor;
  final Color underLineColor;
  final Color underLineLabelColor;
  final Function onTapDown;
  final Function onTapUp;
  final Function onTapCancel;
  final TextDirection textDirection;

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
    this.inActiveMode = false,
    this.underLine,
    this.splashColor = Colorz.WhiteSmoke,
    this.underLineColor = Colorz.White,
    this.underLineLabelColor = Colorz.WhiteAir,
    this.onTapDown,
    this.onTapUp,
    this.onTapCancel,
    this.textDirection,
  });

  @override
  Widget build(BuildContext context) {

    double _sizeFactor = iconSizeFactor;
    double _boxHeight = height ;

    Color _imageSaturationColor =
        blackAndWhite == true ? Colorz.Grey : Colorz.Nothing;


    double _verseIconSpacing = verse != null ? height * 0.3 * iconSizeFactor * verseScaleFactor : 0;

    double _svgGraphicWidth = height * _sizeFactor;
    double _jpgGraphicWidth = height * _sizeFactor;
    double _graphicWidth = icon == null ? 0 :
        fileExtensionOf(icon) == 'svg' ? _svgGraphicWidth :
        fileExtensionOf(icon) == 'jpg' ||
        fileExtensionOf(icon) == 'jpeg' ||
        fileExtensionOf(icon) == 'png' ? _jpgGraphicWidth : height;

    double _iconMargin = verse == null || icon == null ? 0 : (height - _graphicWidth)/2;

    double _verseWidth = width != null ? width - (_iconMargin * 2) - _graphicWidth - ((_verseIconSpacing * 2) + _iconMargin) : width;

    int _verseSize =  iconSizeFactor == 1 ? 4 : 4;

    double _iconCorners = iconRounded == true ? (corners-_iconMargin) : 0;

    Color _boxColor =
    (blackAndWhite == true && color != Colorz.Nothing) ?
    Colorz.GreySmoke :
    (color == Colorz.Nothing && blackAndWhite == true) ?
    Colorz.Nothing :
    color;

    Color _iconColor = blackAndWhite == true ? Colorz.WhiteSmoke : iconColor;

    TextDirection _textDirection = textDirection == null ? superTextDirection(context) : textDirection;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[

        IntrinsicWidth(

          child: Opacity(
            opacity: inActiveMode == true ? 0.5 : opacity,
            child: Padding(
              padding: boxMargins == null ? EdgeInsets.all(0) : boxMargins,
              child: Column(
                mainAxisAlignment: underLine == null ? MainAxisAlignment.center : MainAxisAlignment.start,
                crossAxisAlignment: underLine == null ? CrossAxisAlignment.center : CrossAxisAlignment.start,
                children: <Widget>[

                  // --- THE BOX
                  Container(
                    width: width,
                    height: _boxHeight,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: inActiveMode == true ? Colorz.WhiteAir : _boxColor,
                        borderRadius: BorderRadius.circular(corners),
                        boxShadow: [
                          CustomBoxShadow(
                              color: bubble == true ? Colorz.BlackLingerie : Colorz.Nothing,
                              offset: new Offset(0, height * -0.019 * 0 ),
                              blurRadius: height * 0.15,
                              blurStyle: BlurStyle.outer
                          ),
                        ]
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(corners),
                      child: Stack(
                        alignment: Alignment.center,
                        children: <Widget>[

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
                            textDirection: _textDirection,
                            children: <Widget>[

                              // --- ICON
                              Stack(
                                alignment: Alignment.center,
                                children: <Widget>[
                                  iconFile != null ?
                                  Container(
                                    width: _jpgGraphicWidth,
                                    height: _jpgGraphicWidth,
                                    margin: EdgeInsets.all(_iconMargin),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(Radius.circular(_iconCorners)),
                                        boxShadow: <CustomBoxShadow>[
                                          CustomBoxShadow(
                                              color: bubble == true ? Colorz.BlackLingerie : Colorz.Nothing,
                                              offset: new Offset(0, _jpgGraphicWidth * -0.019 ),
                                              blurRadius: _jpgGraphicWidth * 0.2,
                                              blurStyle: BlurStyle.outer),
                                        ]
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.all(Radius.circular(_iconCorners)),
                                      child: ColorFiltered(
                                        colorFilter: ColorFilter.mode(
                                            _imageSaturationColor,
                                            BlendMode.saturation),
                                        child: Container(
                                          width: _jpgGraphicWidth,
                                          height: _jpgGraphicWidth,
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
                                    padding: EdgeInsets.all(_iconMargin),
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.all(Radius.circular(_iconCorners)),
                                        child: WebsafeSvg.asset(icon, color: _iconColor, height: _svgGraphicWidth, fit: BoxFit.cover)),
                                  )
                                      :
                                  fileExtensionOf(icon) == 'jpg' || fileExtensionOf(icon) == 'jpeg' || fileExtensionOf(icon) == 'png' ?
                                  Container(
                                    width: _jpgGraphicWidth,
                                    height: _jpgGraphicWidth,
                                    margin: EdgeInsets.all(_iconMargin),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(Radius.circular(_iconCorners)),
                                        boxShadow: [
                                          CustomBoxShadow(
                                              color: bubble == true ? Colorz.BlackLingerie : Colorz.Nothing,
                                              offset: new Offset(0, _jpgGraphicWidth * -0.019 ),
                                              blurRadius: _jpgGraphicWidth * 0.2,
                                              blurStyle: BlurStyle.outer),
                                        ]
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.all(Radius.circular(_iconCorners)),
                                      child: ColorFiltered(
                                        colorFilter: ColorFilter.mode(
                                            _imageSaturationColor,
                                            BlendMode.saturation),
                                        child: Container(
                                          width: _jpgGraphicWidth,
                                          height: _jpgGraphicWidth,
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
                                    height: _jpgGraphicWidth,
                                    width: _jpgGraphicWidth,
                                    decoration: BoxDecoration(
                                      // color: Colorz.Yellow,
                                      borderRadius: BorderRadius.circular(_iconCorners),
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
                                width: iconSizeFactor != 1 && icon != null ? _verseIconSpacing * 0.25 : _verseIconSpacing,
                                height: height,
                              ),

                              // --- VERSE
                              verse == null ? Container() :
                              Container(
                                height: height,
                                width: _verseWidth,
                                // color: Colorz.YellowSmoke, // for design purpose only
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: icon == null && textDirection == null? CrossAxisAlignment.center :
                                  textDirection != null ? CrossAxisAlignment.end :
                                  CrossAxisAlignment.center,
                                  children: <Widget>[
                                    SuperVerse(
                                      verse: verse,
                                      size: _verseSize,
                                      weight: verseWeight,
                                      color: blackAndWhite == true || inActiveMode == true ? Colorz.WhiteSmoke : verseColor,
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
                                width: _verseIconSpacing + _iconMargin,
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

                          // --- RIPPLE & TAP LAYER
                          Container(
                            width: width,
                            height: height,
                            child: Material(
                              color: Colorz.Nothing,
                              child: GestureDetector(
                                onTapDown: inActiveMode == true || onTapDown == null ? (TapDownDetails details){} : (TapDownDetails details) => onTapDown(),
                                onTapUp: inActiveMode == true || onTapUp == null ? (TapUpDetails details){} : (TapUpDetails details) => onTapUp(),
                                child: InkWell(
                                  splashColor: splashColor,
                                  onTap: inActiveMode == true ? (){} : boxFunction,
                                  onTapCancel: inActiveMode == true ? (){} : onTapCancel,
                                ),
                              ),
                            ),
                          ),

                        ],
                      ),
                    ),
                  ),

                  // --- THE UnderLine
                  underLine == null ? Container() :
                      SuperVerse(
                        verse: underLine,
                        color: underLineColor,
                        size: _verseSize,
                        scaleFactor: height * 0.005 * verseScaleFactor,
                        maxLines: 2,
                        shadow: true,
                        labelColor: underLineLabelColor,
                      ),

                ],
              ),
            ),
          ),
        ),

      ],
    );
  }
}
