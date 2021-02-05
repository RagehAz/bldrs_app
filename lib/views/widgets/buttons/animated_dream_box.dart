import 'dart:io';
import 'package:bldrs/view_brains/drafters/file_formatters.dart';
import 'package:bldrs/view_brains/drafters/shadowers.dart';
import 'package:bldrs/view_brains/theme/colorz.dart';
import 'package:bldrs/view_brains/theme/ratioz.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';
import 'package:websafe_svg/websafe_svg.dart';

class AnimatedDreamBox extends StatefulWidget {
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

  AnimatedDreamBox({
    @required this.height,
    this.width,
    this.icon,
    this.iconFile,
    this.iconSizeFactor = 1,
    this.color = Colorz.Nothing,
    this.corners = Ratioz.ddBoxCorner12,
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
  });

  @override
  _AnimatedDreamBoxState createState() => _AnimatedDreamBoxState();
}

class _AnimatedDreamBoxState extends State<AnimatedDreamBox> {
  int bounceDuration = 200;
  double boxWidth ;
  double boxHeight ;


  @override
  void initState() {
     boxWidth = widget.width ;
     boxHeight = widget.height;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    double sizeFactor = widget.iconSizeFactor;

    Color imageSaturationColor =
    widget.blackAndWhite == true ? Colorz.Grey : Colorz.Nothing;

    double verseIconSpacing = widget.verse != null ? boxHeight * 0.3 * widget.iconSizeFactor * widget.verseScaleFactor : 0;

    double svgGraphicWidth = boxHeight * sizeFactor;
    double jpgGraphicWidth = boxHeight * sizeFactor;
    double graphicWidth = widget.icon == null ? 0 :
    fileExtensionOf(widget.icon) == 'svg' ? svgGraphicWidth :
    fileExtensionOf(widget.icon) == 'jpg' ||
        fileExtensionOf(widget.icon) == 'jpeg' ||
        fileExtensionOf(widget.icon) == 'png' ? jpgGraphicWidth : boxHeight;

    double iconMargin = widget.verse == null || widget.icon == null ? 0 : (boxHeight - graphicWidth)/2;

    double verseWidth = boxWidth  != null ? boxWidth - (iconMargin * 2) - graphicWidth - ((verseIconSpacing * 2) + iconMargin) : boxWidth;

    int verseSize =  widget.iconSizeFactor == 1 ? 4 : 4;

    double iconCorners = widget.iconRounded == true ? (widget.corners-iconMargin) : 0;

    Color boxColor =
    (widget.blackAndWhite == true && widget.color != Colorz.Nothing) ?
    Colorz.GreySmoke :
    (widget.color == Colorz.Nothing && widget.blackAndWhite == true) ?
    Colorz.Nothing :
    widget.color;

    Color _iconColor = widget.blackAndWhite == true ? Colorz.WhiteSmoke : widget.iconColor;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[

        Opacity(
          opacity: widget.inActiveMode == true ? 0.5 : widget.opacity,
          child: Padding(
            padding: widget.boxMargins == null ? EdgeInsets.all(0) : widget.boxMargins,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[

                // --- THE BOX
                AnimatedContainer(
                  duration: Duration(milliseconds: bounceDuration),
                  curve: Curves.easeInOutQuint,
                  width: boxWidth,
                  height: boxHeight,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: widget.inActiveMode == true ? Colorz.WhiteAir : boxColor,
                      borderRadius: BorderRadius.circular(widget.corners),
                      boxShadow: [
                        CustomBoxShadow(
                            color: widget.bubble == true ? Colorz.BlackLingerie : Colorz.Nothing,
                            offset: new Offset(0, boxHeight * -0.019 * 0 ),
                            blurRadius: boxHeight * 0.15,
                            blurStyle: BlurStyle.outer
                        ),
                      ]
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(widget.corners),
                    child: Stack(
                      alignment: Alignment.center,
                      children: <Widget>[

                        widget.dreamChild == null ? Container() :
                        AnimatedContainer(
                          duration: Duration(milliseconds: bounceDuration),
                          curve: Curves.easeInOutQuint,
                          height: boxHeight,
                          width: boxWidth,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(widget.corners),
                          ),
                          child: widget.dreamChild,
                        ),

                        Row(
                          mainAxisAlignment: widget.verse != null ? MainAxisAlignment.start : MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[

                            // --- ICON
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                widget.iconFile != null ?
                                AnimatedContainer(
                                  duration: Duration(milliseconds: bounceDuration),
                                  curve: Curves.easeInOutQuint,
                                  width: jpgGraphicWidth,
                                  height: jpgGraphicWidth,
                                  margin: EdgeInsets.all(iconMargin),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(iconCorners)),
                                      boxShadow: [
                                        CustomBoxShadow(
                                            color: widget.bubble == true ? Colorz.BlackLingerie : Colorz.Nothing,
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
                                      child: AnimatedContainer(
                                        duration: Duration(milliseconds: bounceDuration),
                                        curve: Curves.easeInOutQuint,
                                        width: jpgGraphicWidth,
                                        height: jpgGraphicWidth,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(image: FileImage(widget.iconFile), fit: BoxFit.cover),
                                        ),
                                      ),
                                    ),),
                                ) :
                                widget.icon == null || widget.icon == '' ?
                                Container()
                                    :
                                fileExtensionOf(widget.icon) == 'svg' ?
                                Padding(
                                  padding: EdgeInsets.all(iconMargin),
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.all(Radius.circular(iconCorners)),
                                      child: WebsafeSvg.asset(widget.icon, color: _iconColor, height: svgGraphicWidth, fit: BoxFit.cover)),
                                )
                                    :
                                fileExtensionOf(widget.icon) == 'jpg' || fileExtensionOf(widget.icon) == 'jpeg' || fileExtensionOf(widget.icon) == 'png' ?
                                AnimatedContainer(
                                  duration: Duration(milliseconds: bounceDuration),
                                  curve: Curves.easeInOutQuint,
                                  width: jpgGraphicWidth,
                                  height: jpgGraphicWidth,
                                  margin: EdgeInsets.all(iconMargin),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(iconCorners)),
                                      boxShadow: [
                                        CustomBoxShadow(
                                            color: widget.bubble == true ? Colorz.BlackLingerie : Colorz.Nothing,
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
                                      child: AnimatedContainer(
                                        duration: Duration(milliseconds: bounceDuration),
                                        curve: Curves.easeInOutQuint,
                                        width: jpgGraphicWidth,
                                        height: jpgGraphicWidth,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(image: AssetImage(widget.icon), fit: BoxFit.cover),
                                        ),
                                      ),
                                    ),),
                                ) :
                                Container(),

                                // --- BUTTON BLACK LAYER IF GREYED OUT
                                widget.blackAndWhite == true && widget.icon != null && fileExtensionOf(widget.icon) != 'svg'?
                                AnimatedContainer(
                                  duration: Duration(milliseconds: bounceDuration),
                                  curve: Curves.easeInOutQuint,
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
                              width: widget.iconSizeFactor != 1 && widget.icon != null ? verseIconSpacing * 0.25 : verseIconSpacing,
                              height: boxHeight,
                            ),

                            // --- VERSE
                            widget.verse == null ? Container() :
                            AnimatedContainer(
                              duration: Duration(milliseconds: bounceDuration),
                              curve: Curves.easeInOutQuint,
                              height: boxHeight,
                              width: verseWidth,
                              // color: Colorz.YellowSmoke, // for design purpose only
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: widget.icon == null ? CrossAxisAlignment.center : CrossAxisAlignment.start,
                                children: <Widget>[
                                  SuperVerse(
                                    verse: widget.verse,
                                    size: verseSize,
                                    weight: widget.verseWeight,
                                    color: widget.blackAndWhite == true || widget.inActiveMode == true ? Colorz.WhiteSmoke : widget.verseColor,
                                    shadow: widget.blackAndWhite == true ? false : true,
                                    maxLines: widget.verseMaxLines,
                                    designMode: false,
                                    centered: widget.icon == null ? true : false,
                                    scaleFactor: widget.iconSizeFactor * widget.verseScaleFactor,
                                    italic: widget.verseItalic,
                                  ),

                                  widget.secondLine == null ? Container() :
                                  SuperVerse(
                                    verse: widget.secondLine,
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
                              height: boxHeight,
                            ),
                          ],
                        ),

                        // --- BOX HIGHLIGHT
                        widget.bubble == false ? Container() :
                        AnimatedContainer(
                          duration: Duration(milliseconds: bounceDuration),
                          curve: Curves.easeInOutQuint,
                          width: boxWidth,
                          height: boxHeight * 0.27,
                          decoration: BoxDecoration(
                            // color: Colorz.White,
                              borderRadius: BorderRadius.circular(
                                  widget.corners - (boxHeight * 0.8) ),
                              boxShadow: [
                                CustomBoxShadow(
                                    color: Colorz.WhiteZircon,
                                    offset: new Offset(0, boxHeight * -0.33),
                                    blurRadius: boxHeight * 0.2,
                                    blurStyle: BlurStyle.normal),
                              ]),
                        ),

                        // --- BOX GRADIENT
                        widget.bubble == false ? Container() :
                        AnimatedContainer(
                          duration: Duration(milliseconds: bounceDuration),
                          curve: Curves.easeInOutQuint,
                          height: boxHeight,
                          width: boxWidth,
                          decoration: BoxDecoration(
                            // color: Colorz.Grey,
                            borderRadius: BorderRadius.circular(widget.corners),
                            gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [Colorz.BlackNothing, Colorz.BlackPlastic],
                                stops: [0.5, 0.95]),
                          ),
                        ),

                        // --- RIPPLE & TAP LAYER
                        AnimatedContainer(
                          duration: Duration(milliseconds: bounceDuration),
                          curve: Curves.easeInOutQuint,
                          width: boxWidth,
                          height: boxHeight,
                          child: Material(
                            color: Colorz.Nothing,
                            child: InkWell(
                              splashColor: widget.splashColor,
                              onTap: widget.inActiveMode == true ? (){} :
                              (){
                                print('boxWidth: $boxWidth, widget.width: ${widget.width}');
                                widget.boxFunction();
                                setState(() {
                                  boxWidth = widget.width * 0.8;
                                  boxHeight = widget.height * 0.8;
                                  Future.delayed(Duration(milliseconds: bounceDuration), (){setState(() {
                                    boxWidth = widget.width;
                                    boxHeight = widget.width;
                                  });});
                                });
                                print('boxWidth: $boxWidth, widget.width: ${widget.width}');
                              },
                              onTapDown: (TapDownDetails details){
                                print('boxWidth: $boxWidth, widget.width: ${widget.width}');
                                setState(() {
                                  boxWidth = widget.width * 0.85;
                                  Future.delayed(Duration(milliseconds: bounceDuration), (){setState(() {
                                    boxWidth = widget.width * 0.9;
                                    boxHeight = widget.width * 0.9;
                                  });});
                                });
                                print('boxWidth: $boxWidth, widget.width: ${widget.width}');
                              },
                              onTapCancel: (){
                                print('boxWidth: $boxWidth, widget.width: ${widget.width}');
                                setState(() {
                                  boxWidth = widget.width * 1.05;
                                  Future.delayed(Duration(milliseconds: bounceDuration), (){setState(() {
                                    boxWidth = widget.width;
                                    boxHeight = widget.width;
                                  });});
                                });
                                print('boxWidth: $boxWidth, widget.width: ${widget.width}');
                              },
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),
                ),

                // --- THE UNDERlINE
                widget.underLine == null ? Container() :
                SuperVerse(
                  verse: widget.underLine,
                  color: widget.underLineColor,
                  size: verseSize,
                  scaleFactor: boxHeight * 0.005 * widget.verseScaleFactor,
                  maxLines: 2,
                  shadow: true,
                  labelColor: widget.underLineLabelColor,
                ),

              ],
            ),
          ),
        ),

      ],
    );
  }
}
