import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box_icon.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/f_helpers/drafters/aligners.dart';
import 'package:bldrs/f_helpers/drafters/object_checkers.dart';
import 'package:bldrs/f_helpers/drafters/text_directioners.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';

class DreamBoxIconVerseSecondLine extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const DreamBoxIconVerseSecondLine({
    @required this.verse,
    @required this.textDirection,
    @required this.icon,
    @required this.loading,
    @required this.height,
    @required this.width,
    @required this.iconCorners,
    @required this.iconMargin,
    @required this.greyscale,
    @required this.bubble,
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
    @required this.secondVerseMaxLines,
    @required this.verseItalic,
    @required this.redDot,
    @required this.secondLineScaleFactor,
    @required this.secondLineColor,
    @required this.centered,
    @required this.backgroundColor,
    @required this.highlight,
    @required this.highlightColor,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final Verse verse;
  final TextDirection textDirection;
  final dynamic icon;
  final bool loading;
  final double width;
  final double height;
  final BorderRadius iconCorners;
  final double iconMargin;
  final bool greyscale;
  final bool bubble;
  final Color iconColor;
  final double iconSizeFactor;
  final double verseScaleFactor;
  final bool verseCentered;
  final Verse secondLine;
  final int verseSize;
  final VerseWeight verseWeight;
  final bool inActiveMode;
  final Color verseColor;
  final bool verseShadow;
  final int verseMaxLines;
  final int secondVerseMaxLines;
  final bool verseItalic;
  final bool redDot;
  final double secondLineScaleFactor;
  final Color secondLineColor;
  final bool centered;
  final Color backgroundColor;
  final ValueNotifier<dynamic> highlight;
  final Color highlightColor;
  /// ----------------------------------------------------------------------------
  static CrossAxisAlignment versesCrossAlignment({
    dynamic icon,
    TextDirection textDirection,
    String secondLine,
    bool verseCentered
  }) {

    final CrossAxisAlignment _versesCrossAlignment =
    verseCentered ? CrossAxisAlignment.center
    :
    icon == null && textDirection == null && secondLine == null ?
    CrossAxisAlignment.center
        :
    textDirection != null ?
    CrossAxisAlignment.start // dunno why
        :
    (icon != null && secondLine != null) || (verseCentered == false) ?
    CrossAxisAlignment.start
        :
    CrossAxisAlignment.center; // verseCentered

    return _versesCrossAlignment;
  }
  // --------------------
  static double verseWidth({
    @required double width,
    @required double iconMargin,
    @required double verseIconSpacing,
    @required double graphicWidth,
    @required bool hasIcon,
  }) {

    if (hasIcon == true){

      if (width != null ){
        return  width
            - (iconMargin * 2)
            - graphicWidth
            - ((verseIconSpacing * 2) + iconMargin);
      }
      else {
        return width; // return null bitch
      }

    }
    else {
      return width;
    }

  }
  // --------------------
  static double verseIconSpacing({
    @required double height,
    @required Verse verse,
    @required double iconSizeFactor,
    @required double verseScaleFactor,
    @required bool hasIcon,
  }) {

    if (hasIcon == false){
      return 0;
    }
    else if (verse?.text != null){
      return height * 0.3 * iconSizeFactor * verseScaleFactor;
    }
    else {
      return 0;
    }
  }
  // --------------------
  bool _verseShadowIsOn() {
    bool _isOn;

    if (verseShadow != null) {
      _isOn = verseShadow;
    } else if (greyscale == true || inActiveMode == true) {
      _isOn = false;
    } else {
      _isOn = true;
    }

    return _isOn;
  }
  // --------------------
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
  // --------------------
  bool _secondLineShadowIsOn() {
    bool _isOn;

    if (greyscale == true || inActiveMode == true || verseShadow == false) {
      _isOn = false;
    } else {
      _isOn = true;
    }

    return _isOn;
  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final TextDirection _textDirection = textDirection ?? TextDir.getAppLangTextDirection(context);
    // --------------------
    final double _jpgGraphicWidth = height * iconSizeFactor;
    // --------------------
    final double _graphicWidth = DreamBox.graphicWidth(
      icon: icon,
      height: height,
      loading: loading,
      iconSizeFactor: iconSizeFactor,
    );
    // --------------------
    final double _verseIconSpacing = verseIconSpacing(
      iconSizeFactor: iconSizeFactor,
      height: height,
      verse: verse,
      verseScaleFactor: verseScaleFactor,
      hasIcon: icon != null,
    );
    // --------------------
    final double _verseWidth = verseWidth(
      graphicWidth: _graphicWidth,
      width: width,
      iconMargin: iconMargin,
      verseIconSpacing: _verseIconSpacing,
      hasIcon: icon != null,
    );
    // --------------------
    final CrossAxisAlignment _versesCrossAlignment = versesCrossAlignment(
      icon: icon,
      secondLine: secondLine?.text,
      textDirection: textDirection,
      verseCentered: verseCentered,
    );
    // --------------------
    final MainAxisAlignment _mainAxisAlignment = centered == true ?
    MainAxisAlignment.center
        :
    MainAxisAlignment.start;
    // --------------------
    final Alignment _verseAlignment = centered == true ?
    Alignment.center
        :
    Aligners.superCenterAlignment(context);
    // --------------------
    return Row(
      mainAxisAlignment: _mainAxisAlignment,
      textDirection: _textDirection,
      children: <Widget>[

        /// --- ICON BOX footprint
        if (icon != null || loading == true)
          Container(
            width: height,
            height: height,
            alignment: Alignment.topCenter,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[

                /// ICON
                Container(
                  width: height,
                  height: height,
                  decoration: BoxDecoration(
                    borderRadius: iconCorners,
                    // color: Colorz.BloodTest
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: <Widget>[

                      DreamBoxIcon(
                        icon: icon,
                        loading: loading,
                        size: height,
                        corners: iconCorners,
                        iconMargin: iconMargin,
                        greyscale: greyscale,
                        bubble: bubble,
                        iconColor: iconColor,
                        iconSizeFactor: iconSizeFactor,
                        backgroundColor: backgroundColor,
                      ),

                      /// --- BUTTON BLACK LAYER IF GREYED OUT
                      if (greyscale == true &&
                          icon != null &&
                          ObjectCheck.fileExtensionOf(icon) != 'svg')
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
            child: SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: _versesCrossAlignment,
                children: <Widget>[

                  SizedBox(
                    width: _verseWidth,
                    height: secondLine == null ? height : null,
                    child: SuperVerse(
                        width: _verseWidth,

                        verse: verse,
                        size: verseSize,
                        weight: verseWeight,

                        color: greyscale == true || inActiveMode == true ?
                        Colorz.white30
                            :
                        verseColor,
                        shadow: _verseShadowIsOn(),
                        maxLines: verseMaxLines,
                        centered: _verseIsCentered(),
                        scaleFactor: iconSizeFactor * verseScaleFactor,
                        italic: verseItalic,
                        redDot: redDot,
                        highlight: highlight,
                        highlightColor: highlightColor,
                        margin:
                        // _verseWidth == null ?
                        EdgeInsets.symmetric(horizontal: height * 0.2)
                      //     :
                      // EdgeInsets.zero,
                    ),
                  ),

                  if (secondLine != null)
                    SizedBox(
                      width: _verseWidth,
                      child: SuperVerse(
                          verse: secondLine,
                          weight: VerseWeight.thin,
                          size: 1,
                          color: greyscale == true || inActiveMode == true ?
                          Colorz.white30
                              :
                          secondLineColor,
                          maxLines: secondVerseMaxLines,
                          italic: true,
                          shadow: _secondLineShadowIsOn(),
                          centered: _verseIsCentered(),
                          scaleFactor: secondLineScaleFactor,
                          highlight: highlight,
                          highlightColor: highlightColor,
                          margin:
                          // _verseWidth == null ?
                          EdgeInsets.symmetric(horizontal: height * 0.2)
                        //     :
                        // EdgeInsets.zero,
                      ),
                    ),
                ],
              ),
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
    // --------------------
  }
  // -----------------------------------------------------------------------------
}
