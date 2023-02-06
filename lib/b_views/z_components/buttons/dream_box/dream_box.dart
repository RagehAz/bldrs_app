import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/c_protocols/app_state_protocols/provider/ui_provider.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:flutter/material.dart';
import 'package:super_box/super_box.dart';

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
    this.isDisabled = false,
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
    this.onDisabledTap,
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
  final bool isDisabled;
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
  final Function onDisabledTap;
  final ValueNotifier<dynamic> verseHighlight;
  final Color verseHighlightColor;
  final Function onLongTap;
  final Function onDoubleTap;
  /// --------------------------------------------------------------------------
  // static Color getIconColor({
  //   bool blackAndWhite = false,
  //   bool inActiveMode = false,
  //   Color colorOverride}) {
  //   if (blackAndWhite == true || inActiveMode == true) {
  //     return Colorz.white30;
  //   } else {
  //     return colorOverride;
  //   }
  // }
  // // --------------------
  // static double graphicWidth({
  //   dynamic icon,
  //   double height,
  //   bool loading,
  //   double iconSizeFactor,
  // }) {
  //   if (icon == null && loading == false) {
  //     return 0;
  //   } else if (ObjectCheck.fileExtensionOf(icon) == 'svg' ||
  //       ObjectCheck.fileExtensionOf(icon) == 'jpg' ||
  //       ObjectCheck.fileExtensionOf(icon) == 'jpeg' ||
  //       ObjectCheck.fileExtensionOf(icon) == 'png') {
  //     return height * iconSizeFactor;
  //   } else {
  //     return height;
  //   }
  // }
  // // --------------------
  // static double iconMargin({
  //   dynamic icon,
  //   double height,
  //   double graphicWidth,
  //   String verse,
  // }) {
  //   if (verse == null || icon == null) {
  //     return 0;
  //   } else {
  //     return (height - graphicWidth) / 2;
  //   }
  // }
  // // --------------------
  // static Color boxColor({bool blackAndWhite, Color color}) {
  //   if (blackAndWhite == true && color != Colorz.nothing) {
  //     return Colorz.grey80;
  //   } else if (color == Colorz.nothing && blackAndWhite == true) {
  //     return Colorz.nothing;
  //   } else {
  //     return color;
  //   }
  // }
  // // --------------------
  // static BorderRadius boxCorners = Borderers.constantCornersAll12;
  // // --------------------
  // static BorderRadius getBoxCorners({
  //   @required BuildContext context,
  //   @required dynamic cornersOverride,
  // }) {
  //   if (cornersOverride == null) {
  //     return boxCorners;
  //   } else {
  //     return Borderers.getCornersAsBorderRadius(context, cornersOverride ?? 0);
  //   }
  // }
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return SuperBox(
      // package: 'bldrs_theme',
      height: height,
      width: width,
      icon: icon,
      iconSizeFactor: iconSizeFactor,
      color: color,
      corners: corners,
      iconColor: iconColor,
      text: Verse.bakeVerseToString(context: context, verse: verse),
      textColor: verseColor,
      textWeight: SuperVerse.superVerseWeight(verseWeight),
      textScaleFactor: verseScaleFactor,
      textShadow: verseShadow,
      textItalic: verseItalic,
      textMaxLines: verseMaxLines,
      secondTextMaxLines: secondVerseMaxLines,
      onTap: onTap,
      margins: margins,
      greyscale: greyscale,
      iconRounded: iconRounded,
      bubble: bubble,
      secondText: Verse.bakeVerseToString(context: context, verse: secondLine),
      textCentered: verseCentered,
      opacity: opacity,
      isDisabled: isDisabled,
      splashColor: splashColor,
      onTapDown: onTapDown,
      onTapUp: onTapUp,
      onTapCancel: onTapCancel,
      textDirection: textDirection ?? UiProvider.getAppTextDir(context),
      blur: blur,
      secondTextColor: secondLineColor,
      redDot: redDot,
      secondTextScaleFactor: secondLineScaleFactor,
      loading: loading,
      iconBackgroundColor: iconBackgroundColor,
      onDisabledTap: onDisabledTap,
      textHighlight: verseHighlight,
      textHighlightColor: verseHighlightColor,
      onLongTap: onLongTap,
      onDoubleTap: onDoubleTap,
      appIsLTR: UiProvider.checkAppIsLeftToRight(context),
      textFont: SuperVerse.superVerseFont(context, verseWeight),
      childAlignment: childAlignment,
      letterSpacing: SuperVerse.superVerseLetterSpacing(
          verseWeight,
          SuperBoxController.textLineHeight(
            height: height,
            iconSizeFactor: iconSizeFactor,
            textScaleFactor: verseScaleFactor,
          )),
      subChild: subChild,
    );
    // --------------------
  }
// -----------------------------------------------------------------------------
}
