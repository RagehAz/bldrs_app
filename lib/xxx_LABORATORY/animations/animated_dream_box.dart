import 'dart:io';
import 'package:bldrs/controllers/drafters/object_checkers.dart';
import 'package:bldrs/controllers/drafters/shadowers.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/views/widgets/general/textings/super_verse.dart';
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
  final Duration duration;

  AnimatedDreamBox({
    @required this.height,
    this.width,
    this.icon,
    this.iconFile,
    this.iconSizeFactor = 1,
    this.color = Colorz.nothing,
    this.corners = Ratioz.boxCorner12,
    this.iconColor,
    this.verse,
    this.verseColor = Colorz.white255,
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
    this.splashColor = Colorz.white80,
    this.underLineColor = Colorz.white255,
    this.underLineLabelColor = Colorz.white10,
    this.duration = Ratioz.duration150ms,
    Key key,
  }) : super(key: key);

  @override
  _AnimatedDreamBoxState createState() => _AnimatedDreamBoxState();
}

class _AnimatedDreamBoxState extends State<AnimatedDreamBox> {
  int bounceDuration = 200;
  double boxWidth ;
  double boxHeight ;


  @override
  void initState() {
    super.initState();
     boxWidth = widget.width ;
     boxHeight = widget.height;
  }

  @override
  Widget build(BuildContext context) {

    double sizeFactor = widget.iconSizeFactor;

    Color imageSaturationColor =
    widget.blackAndWhite == true ? Colorz.grey225 : Colorz.nothing;

    double verseIconSpacing = widget.verse != null ? boxHeight * 0.3 * widget.iconSizeFactor * widget.verseScaleFactor : 0;

    double svgGraphicWidth = boxHeight * sizeFactor;
    double jpgGraphicWidth = boxHeight * sizeFactor;
    double graphicWidth = widget.icon == null ? 0 :
    ObjectChecker.fileExtensionOf(widget.icon) == 'svg' ? svgGraphicWidth :
    ObjectChecker.fileExtensionOf(widget.icon) == 'jpg' ||
        ObjectChecker.fileExtensionOf(widget.icon) == 'jpeg' ||
        ObjectChecker.fileExtensionOf(widget.icon) == 'png' ? jpgGraphicWidth : boxHeight;

    double iconMargin = widget.verse == null || widget.icon == null ? 0 : (boxHeight - graphicWidth)/2;

    double verseWidth = boxWidth  != null ? boxWidth - (iconMargin * 2) - graphicWidth - ((verseIconSpacing * 2) + iconMargin) : boxWidth;

    int verseSize =  widget.iconSizeFactor == 1 ? 4 : 4;

    double iconCorners = widget.iconRounded == true ? (widget.corners-iconMargin) : 0;

    Color boxColor =
    (widget.blackAndWhite == true && widget.color != Colorz.nothing) ?
    Colorz.grey80 :
    (widget.color == Colorz.nothing && widget.blackAndWhite == true) ?
    Colorz.nothing :
    widget.color;

    Color _iconColor = widget.blackAndWhite == true ? Colorz.white80 : widget.iconColor;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[

        Opacity(
          opacity: widget.inActiveMode == true ? 0.5 : widget.opacity,
          child: Padding(
            padding: widget.boxMargins == null ? const EdgeInsets.all(0) : widget.boxMargins,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[

                // --- THE BOX
                AnimatedContainer(
                  duration: widget.duration,
                  curve: Curves.easeInOutQuint,
                  width: boxWidth,
                  height: boxHeight,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: widget.inActiveMode == true ? Colorz.white10 : boxColor,
                      borderRadius: BorderRadius.circular(widget.corners),
                      boxShadow: <BoxShadow>[
                        CustomBoxShadow(
                            color: widget.bubble == true ? Colorz.black200 : Colorz.nothing,
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
                          duration: widget.duration,
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
                              children: <Widget>[
                                widget.iconFile != null ?
                                AnimatedContainer(
                                  duration: widget.duration,
                                  curve: Curves.easeInOutQuint,
                                  width: jpgGraphicWidth,
                                  height: jpgGraphicWidth,
                                  margin: EdgeInsets.all(iconMargin),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(iconCorners)),
                                      boxShadow: <BoxShadow>[
                                        CustomBoxShadow(
                                            color: widget.bubble == true ? Colorz.black200 : Colorz.nothing,
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
                                        duration: widget.duration,
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
                                ObjectChecker.fileExtensionOf(widget.icon) == 'svg' ?
                                Padding(
                                  padding: EdgeInsets.all(iconMargin),
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.all(Radius.circular(iconCorners)),
                                      child: WebsafeSvg.asset(widget.icon, color: _iconColor, height: svgGraphicWidth, fit: BoxFit.cover)),
                                )
                                    :
                                ObjectChecker.fileExtensionOf(widget.icon) == 'jpg' || ObjectChecker.fileExtensionOf(widget.icon) == 'jpeg' || ObjectChecker.fileExtensionOf(widget.icon) == 'png' ?
                                AnimatedContainer(
                                  duration: widget.duration,
                                  curve: Curves.easeInOutQuint,
                                  width: jpgGraphicWidth,
                                  height: jpgGraphicWidth,
                                  margin: EdgeInsets.all(iconMargin),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(iconCorners)),
                                      boxShadow: <BoxShadow>[
                                        CustomBoxShadow(
                                            color: widget.bubble == true ? Colorz.black200 : Colorz.nothing,
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
                                        duration: widget.duration,
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
                                widget.blackAndWhite == true && widget.icon != null && ObjectChecker.fileExtensionOf(widget.icon) != 'svg'?
                                AnimatedContainer(
                                  duration: widget.duration,
                                  curve: Curves.easeInOutQuint,
                                  height: jpgGraphicWidth,
                                  width: jpgGraphicWidth,
                                  decoration: BoxDecoration(
                                    // color: Colorz.Yellow,
                                    borderRadius: BorderRadius.circular(iconCorners),
                                    gradient: const LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: <Color>[Colorz.black80, Colorz.black125],
                                        stops: <double>[0.5, 1]),
                                  ),
                                ) : Container(),

                              ],
                            ),

                            /// SPACING
                            SizedBox(
                              width: widget.iconSizeFactor != 1 && widget.icon != null ? verseIconSpacing * 0.25 : verseIconSpacing,
                              height: boxHeight,
                            ),

                            /// VERSE
                            widget.verse == null ? Container() :
                            AnimatedContainer(
                              duration: widget.duration,
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
                                    color: widget.blackAndWhite == true || widget.inActiveMode == true ? Colorz.white80 : widget.verseColor,
                                    shadow: widget.blackAndWhite == true ? false : true,
                                    maxLines: widget.verseMaxLines,
                                    centered: widget.icon == null ? true : false,
                                    scaleFactor: widget.iconSizeFactor * widget.verseScaleFactor,
                                    italic: widget.verseItalic,
                                  ),

                                  widget.secondLine == null ? Container() :
                                  SuperVerse(
                                    verse: widget.secondLine,
                                    weight: VerseWeight.regular,
                                    size: 1,
                                    color: Colorz.white255,
                                    maxLines: 1,
                                    italic: true,
                                    shadow: true,
                                    centered: false,
                                  ),
                                ],
                              ),
                            ),

                            /// --- SPACING
                            SizedBox(
                              width: verseIconSpacing + iconMargin,
                              height: boxHeight,
                            ),
                          ],
                        ),

                        /// --- BOX HIGHLIGHT
                        widget.bubble == false ? Container() :
                        AnimatedContainer(
                          duration: widget.duration,
                          curve: Curves.easeInOutQuint,
                          width: boxWidth,
                          height: boxHeight * 0.27,
                          decoration: BoxDecoration(
                            // color: Colorz.White,
                              borderRadius: BorderRadius.circular(
                                  widget.corners - (boxHeight * 0.8) ),
                              boxShadow: <BoxShadow>[
                                CustomBoxShadow(
                                    color: Colorz.white50,
                                    offset: new Offset(0, boxHeight * -0.33),
                                    blurRadius: boxHeight * 0.2,
                                    blurStyle: BlurStyle.normal),
                              ]),
                        ),

                        // --- BOX GRADIENT
                        widget.bubble == false ? Container() :
                        AnimatedContainer(
                          duration: widget.duration,
                          curve: Curves.easeInOutQuint,
                          height: boxHeight,
                          width: boxWidth,
                          decoration: BoxDecoration(
                            // color: Colorz.Grey,
                            borderRadius: BorderRadius.circular(widget.corners),
                            gradient: const LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: <Color>[Colorz.black0, Colorz.black125],
                                stops: <double>[0.5, 0.95]),
                          ),
                        ),

                        // --- RIPPLE & TAP LAYER
                        AnimatedContainer(
                          duration: widget.duration,
                          curve: Curves.easeInOutQuint,
                          width: boxWidth,
                          height: boxHeight,
                          child: Material(
                            color: Colorz.nothing,
                            child: InkWell(
                              splashColor: widget.splashColor,
                              onTap: widget.inActiveMode == true ? (){} :
                              (){
                                print('boxWidth: $boxWidth, widget.width: ${widget.width}');
                                widget.boxFunction();
                                // setState(() {
                                //   boxWidth = widget.width * 0.8;
                                //   boxHeight = widget.height * 0.8;
                                //   Future.delayed(widget.duration, (){setState(() {
                                //     boxWidth = widget.width;
                                //     boxHeight = widget.width;
                                //   });});
                                // });
                                print('boxWidth: $boxWidth, widget.width: ${widget.width}');
                              },
                              onTapDown: (TapDownDetails details){
                                print('boxWidth: $boxWidth, widget.width: ${widget.width}');
                                // setState(() {
                                //   boxWidth = widget.width * 0.85;
                                //   Future.delayed(widget.duration, (){setState(() {
                                //     boxWidth = widget.width * 0.9;
                                //     boxHeight = widget.width * 0.9;
                                //   });});
                                // });
                                print('boxWidth: $boxWidth, widget.width: ${widget.width}');
                              },
                              onTapCancel: (){
                                print('boxWidth: $boxWidth, widget.width: ${widget.width}');
                                setState(() {
                                  boxWidth = widget.width * 1.05;
                                  Future<void>.delayed(widget.duration, (){setState(() {
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
