import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box_gradient.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box_highlight.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box_tap_layer.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box_verse.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/the_box_of_dream_box.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/f_helpers/drafters/borderers.dart';
import 'package:bldrs/f_helpers/drafters/object_checkers.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/drafters/text_directioners.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';

import 'package:flutter/material.dart';

export 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';

class DreamBox extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const DreamBox({
    @required this.height,
    this.width,
    this.icon,
    this.iconSizeFactor = 1,
    this.color = Colorz.nothing,
    this.corners,
    this.iconColor,
    this.verse,
    this.verseColor = Colorz.white255,
    this.verseWeight = VerseWeight.bold,
    this.verseScaleFactor = 1,
    this.verseShadow,
    this.verseItalic = false,
    this.verseMaxLines = 1,
    this.secondVerseMaxLines = 10,
    this.onTap,
    this.margins,
    this.greyscale = false,
    this.iconRounded = true,
    this.bubble = true,
    this.secondLine,
    this.verseCentered = true,
    this.subChild,
    this.childAlignment = Alignment.center,
    this.opacity = 1,
    this.isDeactivated = false,
    this.splashColor = Colorz.white80,
    this.onTapDown,
    this.onTapUp,
    this.onTapCancel,
    this.textDirection,
    this.blur,
    this.secondLineColor = Colorz.white255,
    this.redDot = false,
    this.secondLineScaleFactor = 1,
    this.loading = false,
    this.iconBackgroundColor,
    this.onDeactivatedTap,
    this.verseHighlight,
    this.verseHighlightColor = Colorz.bloodTest,
    this.onLongTap,
    this.onDoubleTap,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final dynamic icon;
  /// works as a verseSizeFactor as well
  final double iconSizeFactor;
  final Color color;
  final double width;
  final double height;
  final dynamic corners;
  final Color iconColor;
  final Verse verse;
  final Color verseColor;
  final VerseWeight verseWeight;
  final double verseScaleFactor;
  final bool verseShadow;
  final bool verseItalic;
  final int verseMaxLines;
  final int secondVerseMaxLines;
  final Function onTap;
  final dynamic margins;
  final bool greyscale;
  final bool iconRounded;
  final bool bubble;
  final Verse secondLine;
  final bool verseCentered;
  final Widget subChild;
  final Alignment childAlignment;
  final double opacity;
  final bool isDeactivated;
  final Color splashColor;
  final Function onTapDown;
  final Function onTapUp;
  final Function onTapCancel;
  final TextDirection textDirection;
  final double blur;
  final Color secondLineColor;
  final bool redDot;
  final double secondLineScaleFactor;
  final bool loading;
  final Color iconBackgroundColor;
  final Function onDeactivatedTap;
  final ValueNotifier<dynamic> verseHighlight;
  final Color verseHighlightColor;
  final Function onLongTap;
  final Function onDoubleTap;
  /// --------------------------------------------------------------------------
  static Color getIconColor({
    bool blackAndWhite = false,
    bool inActiveMode = false,
    Color colorOverride
  }) {

    if (blackAndWhite == true || inActiveMode == true){
      return Colorz.white30;
    }
    else {
      return colorOverride;
    }

  }
  // --------------------
  static double graphicWidth({
    dynamic icon,
    double height,
    bool loading,
    double iconSizeFactor,
  }) {

    if (icon == null && loading == false){
      return 0;
    }
    else if (
    ObjectCheck.fileExtensionOf(icon) == 'svg' ||
    ObjectCheck.fileExtensionOf(icon) == 'jpg' ||
    ObjectCheck.fileExtensionOf(icon) == 'jpeg' ||
    ObjectCheck.fileExtensionOf(icon) == 'png'
    ){
      return height * iconSizeFactor;
    }
    else {
      return height;
    }

  }
  // --------------------
  static double iconMargin({
    dynamic icon,
    double height,
    double graphicWidth,
    String verse,
  }) {

    if (verse == null || icon == null){
      return 0;
    }
    else {
      return (height - graphicWidth) / 2;
    }

  }
  // --------------------
  static Color boxColor({
    bool blackAndWhite,
    Color color
  }) {

    if (blackAndWhite == true && color != Colorz.nothing){
      return Colorz.grey80;
    }
    else if (color == Colorz.nothing && blackAndWhite == true){
      return Colorz.nothing;
    }
    else {
      return color;
    }

  }
  // --------------------
  static BorderRadius boxCorners = Borderers.constantCornersAll12;
  // --------------------
  static BorderRadius getBoxCorners({
    @required BuildContext context,
    @required dynamic cornersOverride,
  }){

    if (cornersOverride == null){
      return boxCorners;
    }
    else {
      return Borderers.getCornersAsBorderRadius(context, cornersOverride ?? 0);
    }

  }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final BorderRadius _boxCorners = getBoxCorners(
      context: context,
      cornersOverride: corners,
    );
    // --------------------
    return TheBoxOfDreamBox(
      key: const ValueKey<String>('Dream_box_the_box'),
      inActiveMode: isDeactivated,
      opacity: opacity,
      boxMargins: Scale.superMargins(margin: margins),
      width: width,
      height: height,
      boxColor: boxColor(
        color: color,
        blackAndWhite: greyscale,
      ),
      cornersAsBorderRadius: _boxCorners,
      children: <Widget>[

        // /// --- BLUR LAYER
        // if (blur != null)
        //   BlurLayer(
        //     width: width,
        //     height: height,
        //     blur: blur,
        //     borders: _cornersAsBorderRadius,
        //   ),

        /// --- DREAM CHILD
        if (subChild != null)
          Container(
            height: height,
            width: width,
            decoration: BoxDecoration(
              borderRadius: _boxCorners,
            ),
            alignment: childAlignment,
            child: subChild,
          ),

        /// ICON - VERSE - SECOND LINE
        DreamBoxIconVerseSecondLine(
          key: const ValueKey<String>('DreamBoxIconVerseSecondLine'),
          verse: verse,
          textDirection: textDirection ?? TextDir.getAppLangTextDirection(context),
          icon: icon,
          loading: loading,
          height: height,
          width: width,
          iconCorners: Borderers.getCornersAsBorderRadius(context, _boxCorners),
          iconMargin: iconMargin(
            height: height,
            icon: icon,
            verse: verse?.text,
            graphicWidth: graphicWidth(
              icon: icon,
              height: height,
              iconSizeFactor: iconSizeFactor,
              loading: loading,
            ),
          ),
          greyscale: greyscale,
          bubble: bubble,
          iconColor: getIconColor(
            inActiveMode: isDeactivated,
            blackAndWhite: greyscale,
            colorOverride: iconColor,
          ),
          iconSizeFactor: iconSizeFactor,
          verseScaleFactor: verseScaleFactor,
          verseCentered: verseCentered,
          secondLine: secondLine,
          verseSize: iconSizeFactor == 1 ? 4 : 4,
          verseWeight: verseWeight,
          inActiveMode: isDeactivated,
          verseColor: verseColor,
          verseShadow: verseShadow,
          verseMaxLines: verseMaxLines,
          secondVerseMaxLines: secondVerseMaxLines,
          verseItalic: verseItalic,
          redDot: redDot,
          secondLineScaleFactor: secondLineScaleFactor,
          secondLineColor: secondLineColor,
          centered: verseCentered,
          backgroundColor: iconBackgroundColor,
          highlight: verseHighlight,
          highlightColor: verseHighlightColor,
        ),

        /// --- BOX HIGHLIGHT
        if (bubble == true)
          DreamBoxHighlight(
              key: const ValueKey<String>('DreamBoxHighlight'),
              width: width,
              height: height,
              corners: _boxCorners
          ),

        /// --- BOX GRADIENT
        if (bubble == true)
          DreamBoxGradient(
            key: const ValueKey<String>('DreamBoxGradient'),
            width: width,
            height: height,
            corners: _boxCorners,
          ),

        /// --- RIPPLE & TAP LAYER
        if (onTap != null || onDeactivatedTap != null || onLongTap != null || onDoubleTap != null)
          DreamBoxTapLayer(
            key: const ValueKey<String>('DreamBoxTapLayer'),
            width: width,
            height: height,
            splashColor: splashColor,
            onTap: onTap,
            onTapUp: onTapUp,
            onTapDown: onTapDown,
            onTapCancel: onTapCancel,
            deactivated: isDeactivated,
            onDeactivatedTap: onDeactivatedTap,
            onLongTap: onLongTap,
            onDoubleTap: onDoubleTap,
          ),

      ],
    );
    // --------------------
  }
// -----------------------------------------------------------------------------
}
