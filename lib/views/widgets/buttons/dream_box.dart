import 'dart:io';
import 'package:bldrs/controllers/drafters/borderers.dart';
import 'package:bldrs/controllers/drafters/colorizers.dart';
import 'package:bldrs/controllers/drafters/object_checkers.dart';
import 'package:bldrs/controllers/drafters/shadowers.dart';
import 'package:bldrs/controllers/drafters/text_directionerz.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/views/widgets/loading/loading.dart';
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
  final dynamic corners;
  final Color iconColor;
  final String verse;
  final Color verseColor;
  final VerseWeight verseWeight;
  final double verseScaleFactor;
  final bool verseItalic;
  final int verseMaxLines;
  final Function onTap;
  final dynamic margins;
  final bool blackAndWhite;
  final bool iconRounded;
  final bool bubble;
  final String secondLine;
  final bool verseCentered;
  final Widget dreamChild;
  final double opacity;
  final bool inActiveMode;
  final String underLine;
  final Color splashColor;
  final Color underLineColor;
  final bool underLineShadowIsOn;
  final Function onTapDown;
  final Function onTapUp;
  final Function onTapCancel;
  final TextDirection textDirection;
  final bool designMode;
  final double blur;
  final Color secondLineColor;
  final bool redDot;
  final double secondLineScaleFactor;
  final bool loading;

  DreamBox({
    @required this.height,
    this.width,
    this.icon,
    this.iconFile,
    this.iconSizeFactor = 1,
    this.color = Colorz.Nothing,
    this.corners = Ratioz.boxCorner12,
    this.iconColor,
    this.verse,
    this.verseColor = Colorz.White255,
    this.verseWeight = VerseWeight.bold,
    this.verseScaleFactor = 1,
    this.verseItalic = false,
    this.verseMaxLines = 1,
    this.onTap,
    this.margins,
    this.blackAndWhite = false,
    this.iconRounded = true,
    this.bubble = true,
    this.secondLine,
    this.verseCentered = true,
    this.dreamChild,
    this.opacity = 1,
    this.inActiveMode = false,
    this.underLine,
    this.splashColor = Colorz.White80,
    this.underLineColor = Colorz.White255,
    this.underLineShadowIsOn = true,
    this.onTapDown,
    this.onTapUp,
    this.onTapCancel,
    this.textDirection,
    this.designMode = false,
    this.blur,
    this.secondLineColor = Colorz.White255,
    this.redDot = false,
    this.secondLineScaleFactor = 1,
    this.loading = false,
  });

  @override
  Widget build(BuildContext context) {
// -----------------------------------------------------------------------------
    double _sizeFactor = iconSizeFactor;
// -----------------------------------------------------------------------------
    Color _imageSaturationColor =
        blackAndWhite == true ? Colorz.Grey225 : Colorz.Nothing;
// -----------------------------------------------------------------------------
    double _verseIconSpacing = verse != null ? height * 0.3 * iconSizeFactor * verseScaleFactor : 0;
// -----------------------------------------------------------------------------
    double _svgGraphicWidth = height * _sizeFactor;
    double _jpgGraphicWidth = height * _sizeFactor;
    double _graphicWidth = icon == null && loading == false ? 0 :
    ObjectChecker.fileExtensionOf(icon) == 'svg' ? _svgGraphicWidth :
    ObjectChecker.fileExtensionOf(icon) == 'jpg' ||
        ObjectChecker.fileExtensionOf(icon) == 'jpeg' ||
        ObjectChecker.fileExtensionOf(icon) == 'png' ? _jpgGraphicWidth : height;
// -----------------------------------------------------------------------------
    double _iconMargin = verse == null || icon == null ? 0 : (height - _graphicWidth)/2;
// -----------------------------------------------------------------------------
    double _verseWidth = width != null ? width - (_iconMargin * 2) - _graphicWidth - ((_verseIconSpacing * 2) + _iconMargin) : width;
    int _verseSize =  iconSizeFactor == 1 ? 4 : 4;
// -----------------------------------------------------------------------------
// -----------------------------------------------------------------------------
    double getCornersAsDouble(){
      BorderRadius _cornerBorders;
      double _topLeftCorner;
      if (corners.runtimeType == BorderRadius){
        _cornerBorders = corners;
        Radius _topLeftCornerRadius = _cornerBorders?.topLeft;
        _topLeftCorner =  _topLeftCornerRadius?.x;
        // print('_topLeftCorner : $_topLeftCorner');
      } else {
        _topLeftCorner = corners;
      }

      return _topLeftCorner == null ? 0 : _topLeftCorner;
    }
// -----------------------------------------------------------------------------
    BorderRadius getCornersAsBorderRadius(){
      BorderRadius _cornerBorders;
      double _topLeftCorner;
      if (corners.runtimeType == BorderRadius){
        _cornerBorders = corners;
      } else {
        _cornerBorders = Borderers.superBorderAll(context, corners);
      }

      return _cornerBorders;
    }
// -----------------------------------------------------------------------------
    BorderRadius _getIconCornerByRadius(){
      BorderRadius _IconCornerAsBorderRadius;
      double _iconCorners;

      /// IF ICON IS ROUNDED
      if(iconRounded == true){
        _iconCorners =  (getCornersAsDouble() - _iconMargin);
        _IconCornerAsBorderRadius = Borderers.superBorderAll(context, _iconCorners);
      }

      /// IF CUSTOM BORDER RADIUS PASSES THROUGH corners
      else if (corners.runtimeType ==  BorderRadius){
        BorderRadius _cornerBorders;

        _IconCornerAsBorderRadius = Borderers.superBorderRadius(
          context: context,
          enTopRight: corners.topRight.x - _iconMargin,
          enTopLeft: corners.topLeft.x - _iconMargin,
          enBottomRight: corners.bottomRight.x - _iconMargin,
          enBottomLeft: corners.bottomLeft.x - _iconMargin,
        );
      }

      /// IF corners IS DOUBLE AND ICON IS NOT ROUNDED
      else {
        _IconCornerAsBorderRadius = Borderers.superBorderAll(context, 0);
      }


      return _IconCornerAsBorderRadius;
    }
    BorderRadius _iconCorners = getCornersAsBorderRadius();
// -----------------------------------------------------------------------------
    Color _boxColor =
    (blackAndWhite == true && color != Colorz.Nothing) ?
    Colorz.Grey80 :
    (color == Colorz.Nothing && blackAndWhite == true) ?
    Colorz.Nothing :
    color;
// -----------------------------------------------------------------------------
    Color _iconColor =
    blackAndWhite == true || inActiveMode == true ? Colorz.White80 :
    iconColor;
// -----------------------------------------------------------------------------
    TextDirection _textDirection = textDirection == null ? superTextDirection(context) : textDirection;
// -----------------------------------------------------------------------------
    EdgeInsets _boxMargins =
        margins == null ? const EdgeInsets.all(0)
            :
        margins.runtimeType == double ? EdgeInsets.all(margins)
            :
        margins.runtimeType == int ? EdgeInsets.all(margins.toDouble())
            :
        margins.runtimeType == EdgeInsets ? margins
            :
        margins;
// -----------------------------------------------------------------------------
    CrossAxisAlignment _versesCrossAlignment =
    icon == null && textDirection == null && secondLine == null ? CrossAxisAlignment.center
        :
    textDirection != null ? CrossAxisAlignment.end // dunno why
        :
    (icon != null && secondLine != null) || (verseCentered == false) ? CrossAxisAlignment.start
        :
    CrossAxisAlignment.center; // verseCentered
// -----------------------------------------------------------------------------
    /// underline should only available if dreambox is portrait && verse is null && secondVerse is null
    double _underLineTopMargin = underLine == null ? 0 :
    ObjectChecker.objectIsSVG(icon) ? width - ((width - _graphicWidth)/2) :
    width;
    double _underlineHeight = underLine == null ? 0 : height - _underLineTopMargin;
// -----------------------------------------------------------------------------
    return RepaintBoundary(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[

          IntrinsicWidth(

            child: Opacity(
              opacity: inActiveMode == true ? 0.5 : opacity,
              child: Padding(
                padding: _boxMargins,
                child: Container(
                  color: designMode == true ? Colorz.BloodTest : null,
                  child: Column(
                    mainAxisAlignment: underLine == null ? MainAxisAlignment.center : MainAxisAlignment.start,
                    crossAxisAlignment: underLine == null ? CrossAxisAlignment.center : CrossAxisAlignment.start,
                    children: <Widget>[

                      /// --- THE BOX
                      Container(
                        width: width,
                        height: height,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: inActiveMode == true ? Colorz.White10 : _boxColor,
                            borderRadius: getCornersAsBorderRadius(),
                            boxShadow: <CustomBoxShadow>[
                              CustomBoxShadow(
                                  color: bubble == true ? Colorz.Black200 : Colorz.Nothing,
                                  offset: new Offset(0, 0),
                                  blurRadius: height * 0.15,
                                  blurStyle: BlurStyle.outer
                              ),
                            ]
                        ),
                        child: ClipRRect(
                          borderRadius: getCornersAsBorderRadius(),
                          child: Stack(
                            alignment: Alignment.center,
                            children: <Widget>[

                              // --- BLUR LAYER
                              if (blur != null)
                              BlurLayer(
                                width: width,
                                height: height,
                                blur: blur,
                                borders: getCornersAsBorderRadius(),
                              ),

                              // --- DREAM CHILD
                               if (dreamChild != null)
                              Container(
                                height: height,
                                width: width,
                                decoration: BoxDecoration(
                                  borderRadius: getCornersAsBorderRadius(),
                                ),
                                child: dreamChild,
                              ),

                              /// ICON - VERSE - SECOND LINE
                              Row(
                                mainAxisAlignment: verse == null ? MainAxisAlignment.center : MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                // mainAxisSize: MainAxisSize.min,
                                textDirection: _textDirection,
                                children: <Widget>[

                                  /// --- ICON & UNDERLINE BOX footprint
                                  if (icon != null)
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
                                            borderRadius: _iconCorners,
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
                                                margin: EdgeInsets.all(_iconMargin),
                                                decoration: BoxDecoration(
                                                    borderRadius: _iconCorners,
                                                    boxShadow: <CustomBoxShadow>[
                                                      CustomBoxShadow(
                                                          color: bubble == true ? Colorz.Black200 : Colorz.Nothing,
                                                          offset: new Offset(0, _jpgGraphicWidth * -0.019 ),
                                                          blurRadius: _jpgGraphicWidth * 0.2,
                                                          blurStyle: BlurStyle.outer),
                                                    ]
                                                ),
                                                child: ClipRRect(
                                                  borderRadius: _iconCorners,
                                                  child: ColorFiltered(
                                                    colorFilter: ColorFilter.mode(
                                                        _imageSaturationColor,
                                                        BlendMode.saturation),
                                                    child: Container(
                                                      width: _jpgGraphicWidth,
                                                      height: _jpgGraphicWidth,
                                                      decoration: BoxDecoration(
                                                        borderRadius: _iconCorners,
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
                                                padding: EdgeInsets.all(_iconMargin),
                                                child: ClipRRect(
                                                    borderRadius: _iconCorners,
                                                    child: WebsafeSvg.asset(icon, color: _iconColor, height: _svgGraphicWidth, fit: BoxFit.cover)),
                                              )
                                                  :
                                              ObjectChecker.objectIsJPGorPNG(icon) ?
                                              Container(
                                                width: _jpgGraphicWidth,
                                                height: _jpgGraphicWidth,
                                                margin: EdgeInsets.all(_iconMargin),
                                                decoration: BoxDecoration(
                                                    borderRadius: _iconCorners,
                                                    boxShadow: <BoxShadow>[
                                                      CustomBoxShadow(
                                                          color: bubble == true ? Colorz.Black200 : Colorz.Nothing,
                                                          offset: new Offset(0, _jpgGraphicWidth * -0.019 ),
                                                          blurRadius: _jpgGraphicWidth * 0.2,
                                                          blurStyle: BlurStyle.outer),
                                                    ]
                                                ),
                                                child: ClipRRect(
                                                  borderRadius: _iconCorners,
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
                                              )
                                                  :
                                              ObjectChecker.objectIsURL(icon) ? /// WORK WITH FILE
                                              Container(
                                                width: _jpgGraphicWidth,
                                                height: _jpgGraphicWidth,
                                                margin: EdgeInsets.all(_iconMargin),
                                                decoration: BoxDecoration(
                                                    borderRadius: _iconCorners,
                                                    boxShadow: <BoxShadow>[
                                                      CustomBoxShadow(
                                                          color: bubble == true ? Colorz.Black200 : Colorz.Nothing,
                                                          offset: new Offset(0, _jpgGraphicWidth * -0.019 ),
                                                          blurRadius: _jpgGraphicWidth * 0.2,
                                                          blurStyle: BlurStyle.outer),
                                                    ]
                                                ),
                                                child: ClipRRect(
                                                  borderRadius: _iconCorners,
                                                  child: ColorFiltered(
                                                    colorFilter: ColorFilter.mode(
                                                        _imageSaturationColor,
                                                        BlendMode.saturation),
                                                    child: Container(
                                                      width: _jpgGraphicWidth,
                                                      height: _jpgGraphicWidth,
                                                      decoration: BoxDecoration(
                                                        borderRadius: _iconCorners,
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
                                                height: _jpgGraphicWidth,
                                                width: _jpgGraphicWidth,
                                                decoration: BoxDecoration(
                                                  // color: Colorz.Yellow,
                                                  borderRadius: _iconCorners,
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
                                  if (verse != null && icon != null)
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
                                          size: _verseSize,
                                          weight: verseWeight,
                                          color: blackAndWhite == true || inActiveMode == true ? Colorz.White80 : verseColor,
                                          shadow: blackAndWhite == true || inActiveMode == true ? false : true,
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
                                          color: blackAndWhite == true || inActiveMode == true ? Colorz.White80 : secondLineColor,
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
                                  if (verse != null && icon != null)
                                  SizedBox(
                                    width: _verseIconSpacing + _iconMargin,
                                    height: height,
                                  ),

                                ],
                              ),

                              /// --- BOX HIGHLIGHT
                              bubble == false ? Container() :
                              Container(
                                width: width,
                                height: height * 0.27,
                                decoration: BoxDecoration(
                                  // color: Colorz.White,
                                    borderRadius: BorderRadius.circular(
                                        getCornersAsDouble() - (height * 0.8) ),
                                    boxShadow: <BoxShadow>[
                                      CustomBoxShadow(
                                          color: Colorz.White50,
                                          offset: new Offset(0, height * -0.33),
                                          blurRadius: height * 0.2,
                                          blurStyle: BlurStyle.normal),
                                    ]),
                              ),

                              /// --- BOX GRADIENT
                              bubble == false ? Container() :
                              Container(
                                height: height,
                                width: width,
                                decoration: BoxDecoration(
                                  // color: Colorz.Grey,
                                  borderRadius: getCornersAsBorderRadius(),
                                  gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: <Color>[Colorz.Black0, Colorz.Black125],
                                      stops: <double>[0.5, 0.95]),
                                ),
                              ),

                              /// --- UNDERLINE
                              if (underLine != null)
                                Container(
                                  width: underLine == null ? height : width,
                                  height: underLine == null ? height : height,
                                  alignment: Alignment.topCenter,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      /// ICON footprint
                                      Container(
                                        width: width,
                                        height: _underLineTopMargin,
                                        // color: Colorz.BloodTest,
                                      ),
                                      /// --- THE UnderLine
                                      if (underLine != null)
                                        Container(
                                          width: width,
                                          height: _underlineHeight,
                                          color: Colorz.Black10,
                                          child: SuperVerse(
                                            verse: underLine,
                                            color: underLineColor,
                                            size: _verseSize,
                                            scaleFactor: verseScaleFactor * 0.45,
                                            maxLines: 2,
                                            shadow: underLineShadowIsOn,
                                          ),
                                        ),
                                    ],
                                  ),
                                ),

                              /// --- RIPPLE & TAP LAYER
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
                                      onTap: onTap,
                                      onTapCancel: onTapCancel,
                                    ),
                                  ),
                                ),
                              ),

                            ],
                          ),
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
