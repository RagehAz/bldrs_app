import 'dart:io';

import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box_icon.dart';
import 'package:bldrs/b_views/z_components/texting/unfinished_super_verse.dart';
import 'package:bldrs/f_helpers/drafters/aligners.dart' as Aligners;
import 'package:bldrs/f_helpers/drafters/object_checkers.dart' as ObjectChecker;
import 'package:bldrs/f_helpers/drafters/text_directionerz.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';

class DreamBoxIconVerseSecondLine extends StatelessWidget {
  /// --------------------------------------------------------------------------
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
    @required this.centered,
    Key key,
  }) : super(key: key);

  /// --------------------------------------------------------------------------
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
  final bool centered;

  /// ----------------------------------------------------------------------------
  static CrossAxisAlignment versesCrossAlignment({
    String icon,
    TextDirection textDirection,
    String secondLine,
    bool verseCentered
  }) {

    final CrossAxisAlignment _versesCrossAlignment =
    icon == null
        &&
        textDirection == null
        &&
        secondLine == null ?
    CrossAxisAlignment.center
        :
    textDirection != null ?
    CrossAxisAlignment.start // dunno why
        :
    (icon != null && secondLine != null)
        ||
        (verseCentered == false) ?
    CrossAxisAlignment.start
        :
    CrossAxisAlignment.center; // verseCentered

    return _versesCrossAlignment;
  }

// -----------------------------------------------------------------------------
  static double verseWidth({
    double width,
    double iconMargin,
    double verseIconSpacing,
    double graphicWidth
  }) {
    final double _verseWidth = width != null ?
    width
        - (iconMargin * 2)
        - graphicWidth
        - ((verseIconSpacing * 2) + iconMargin)
        :
    width;
    return _verseWidth;
  }
// -----------------------------------------------------------------------------
  static double verseIconSpacing({
    double height,
    String verse,
    double iconSizeFactor,
    double verseScaleFactor
  }) {

    final double _verseIconSpacing = verse != null ?
    height * 0.3 * iconSizeFactor * verseScaleFactor : 0;

    return _verseIconSpacing;
  }
// -----------------------------------------------------------------------------
  bool _verseShadowIsOn() {
    bool _isOn;

    if (verseShadow != null) {
      _isOn = verseShadow;
    } else if (blackAndWhite == true || inActiveMode == true) {
      _isOn = false;
    } else {
      _isOn = true;
    }

    return _isOn;
  }
// -----------------------------------------------------------------------------
  bool _verseIsCentered() {
    bool _centered;

    if (verseCentered == true){
      _centered = true;
    }
    else if (icon == null && verseCentered == null) {
      _centered = true;
    } else {
      _centered = false;
    }

    return _centered;
  }
// -----------------------------------------------------------------------------
  bool _secondLineShadowIsOn() {
    bool _isOn;

    if (blackAndWhite == true || inActiveMode == true || verseShadow == false) {
      _isOn = false;
    } else {
      _isOn = true;
    }

    return _isOn;
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
// ---------------------------------------------------------
    final TextDirection _textDirection = textDirection ?? textDirectionAsPerAppDirection(context);
// ---------------------------------------------------------
//     final double _svgGraphicWidth = height * iconSizeFactor;
    final double _jpgGraphicWidth = height * iconSizeFactor;
// ---------------------------------------------------------
    final double _graphicWidth = DreamBox.graphicWidth(
      icon: icon,
      height: height,
      loading: loading,
      iconSizeFactor: iconSizeFactor,
    );
// ---------------------------------------------------------
    final double _verseIconSpacing = verseIconSpacing(
      iconSizeFactor: iconSizeFactor,
      height: height,
      verse: verse,
      verseScaleFactor: verseScaleFactor,
    );
// ---------------------------------------------------------
    final double _verseWidth = verseWidth(
      graphicWidth: _graphicWidth,
      width: width,
      iconMargin: iconMargin,
      verseIconSpacing: _verseIconSpacing,
    );
// ---------------------------------------------------------
    final CrossAxisAlignment _versesCrossAlignment = versesCrossAlignment(
      icon: icon,
      secondLine: secondLine,
      textDirection: textDirection,
      verseCentered: verseCentered,
    ); // verseCentered
// ---------------------------------------------------------
    final MainAxisAlignment _mainAxisAlignment =
        centered == true ? MainAxisAlignment.center : MainAxisAlignment.start;
// ---------------------------------------------------------
    final Alignment _verseAlignment = centered == true ?
    Alignment.center
        :
    Aligners.superCenterAlignment(context);
// ---------------------------------------------------------
    return Row(
      mainAxisAlignment: _mainAxisAlignment,
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
                      DreamBoxIcon(
                        verse: verse,
                        textDirection: textDirection,
                        icon: icon,
                        loading: loading,
                        height: height,
                        width: width,
                        iconCorners: iconCorners,
                        iconFile: iconFile,
                        iconMargin: iconMargin,
                        imageSaturationColor: imageSaturationColor,
                        bubble: bubble,
                        iconColor: iconColor,
                        iconSizeFactor: iconSizeFactor,
                        verseWeight: verseWeight,
                      ),

                      /// --- BUTTON BLACK LAYER IF GREYED OUT
                      if (blackAndWhite == true &&
                          icon != null &&
                          ObjectChecker.fileExtensionOf(icon) != 'svg')
                        Container(
                          height: _jpgGraphicWidth,
                          width: _jpgGraphicWidth,
                          decoration: BoxDecoration(
                            // color: Colorz.Yellow,
                            borderRadius: iconCorners,
                            gradient: const LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: <Color>[
                                  Colorz.black80,
                                  Colorz.black125
                                ],
                                stops: <double>[
                                  0.5,
                                  1
                                ]),
                          ),
                        ),
                    ],
                  ),
                ),

                // /// --- THE UnderLine foortrint
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
            width: iconSizeFactor != 1 && icon != null ?
            _verseIconSpacing * 0.25
                :
            _verseIconSpacing,
            height: height,
          ),

        /// --- VERSES
        if (verse != null)
          Container(
            height: height,
            width: _verseWidth,
            alignment: _verseAlignment,
            // color: Colorz.Yellow80, // for design purpose only
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: _versesCrossAlignment,
              children: <Widget>[

                SuperVerse(
                  verse: verse,
                  size: verseSize,
                  weight: verseWeight,
                  color: blackAndWhite == true || inActiveMode == true
                      ? Colorz.white30
                      : verseColor,
                  shadow: _verseShadowIsOn(),
                  maxLines: verseMaxLines,
                  centered: _verseIsCentered(),
                  scaleFactor: iconSizeFactor * verseScaleFactor,
                  italic: verseItalic,
                  redDot: redDot,
                ),

                if (secondLine != null)
                  SuperVerse(
                    verse: secondLine,
                    weight: VerseWeight.thin,
                    size: 1,
                    color: blackAndWhite == true || inActiveMode == true ?
                    Colorz.white30
                        :
                    secondLineColor,
                    maxLines: 10,
                    italic: true,
                    shadow: _secondLineShadowIsOn(),
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
