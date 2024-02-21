import 'dart:ui' as ui;

import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/helpers/checks/object_check.dart';
import 'package:basics/components/super_box/super_box.dart';
import 'package:bldrs/a_models/f_flyer/sub/flyer_typer.dart';
import 'package:bldrs/z_components/images/bldrs_image_path_to_ui_image.dart';
import 'package:bldrs/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:bldrs/c_protocols/main_providers/ui_provider.dart';
import 'package:flutter/material.dart';

class BldrsBox extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const BldrsBox({
    required this.height,
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
    this.verseShadow = false,
    this.verseItalic = false,
    this.verseMaxLines = 1,
    this.secondVerseMaxLines = 10,
    this.onTap,
    this.margins,
    this.greyscale = false,
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
    this.borderColor,
    this.solidGreyScale = false,
    this.maxWidth,
    super.key
  });
  /// --------------------------------------------------------------------------
  final dynamic icon;
  /// works as a verseSizeFactor as well
  final double? iconSizeFactor;
  final Color? color;
  final double? width;
  final double height;
  final dynamic corners;
  final Color? iconColor;
  final Verse? verse;
  final Color? verseColor;
  final VerseWeight? verseWeight;
  final double? verseScaleFactor;
  final bool verseShadow;
  final bool verseItalic;
  final int? verseMaxLines;
  final int? secondVerseMaxLines;
  final Function? onTap;
  final dynamic margins;
  final bool greyscale;
  final bool? bubble;
  final Verse? secondLine;
  final bool verseCentered;
  final Widget? subChild;
  final Alignment childAlignment;
  final double? opacity;
  final bool? isDisabled;
  final Color? splashColor;
  final Function? onTapDown;
  final Function? onTapUp;
  final Function? onTapCancel;
  final TextDirection? textDirection;
  final double? blur;
  final Color? secondLineColor;
  final bool redDot;
  final double secondLineScaleFactor;
  final bool loading;
  final Color? iconBackgroundColor;
  final Function? onDisabledTap;
  final ValueNotifier<dynamic>? verseHighlight;
  final Color? verseHighlightColor;
  final Function? onLongTap;
  final Function? onDoubleTap;
  final Color? borderColor;
  final bool solidGreyScale;
  final double? maxWidth;
  // --------------------------------------------------------------------------
  /// TESTED : WORKS PERFECT
  Widget getChild({
    required BuildContext context,
    required dynamic theIcon,
    bool? isLoading = false,
  }) {

    final double _borderFix = borderColor == null ? 0 : 1;

    return SuperBox(
      // package: 'bldrs_theme',
      height: height - _borderFix,
      width: width,
      maxWidth: maxWidth,
      icon: theIcon,
      iconSizeFactor: iconSizeFactor,
      color: color,
      corners: corners,
      iconColor: iconColor,
      text: Verse.bakeVerseToString(verse: verse),
      textColor: verseColor,
      textWeight: BldrsText.superVerseWeight(verseWeight),
      textScaleFactor: verseScaleFactor,
      textShadow: verseShadow,
      textItalic: verseItalic,
      textMaxLines: verseMaxLines,
      secondTextMaxLines: secondVerseMaxLines,
      onTap: onTap,
      margins: margins,
      greyscale: greyscale,
      bubble: bubble ?? true,
      secondText: Verse.bakeVerseToString(verse: secondLine),
      textCentered: verseCentered,
      opacity: opacity,
      isDisabled: isDisabled ?? false,
      splashColor: splashColor,
      onTapDown: onTapDown,
      onTapUp: onTapUp,
      onTapCancel: onTapCancel,
      textDirection: textDirection ?? UiProvider.getAppTextDir(),
      blur: blur,
      secondTextColor: secondLineColor,
      redDot: redDot,
      secondTextScaleFactor: secondLineScaleFactor,
      loading: isLoading ?? loading,
      iconBackgroundColor: iconBackgroundColor,
      onDisabledTap: onDisabledTap,
      textHighlight: verseHighlight,
      textHighlightColor: verseHighlightColor,
      onLongTap: onLongTap,
      onDoubleTap: onDoubleTap,
      appIsLTR: UiProvider.checkAppIsLeftToRight(),
      textFont: BldrsText.superVerseFont(verseWeight),
      childAlignment: childAlignment,
      letterSpacing: BldrsText.superVerseLetterSpacing(
          verseWeight,
          SuperBoxController.textLineHeight(
            height: height,
            iconSizeFactor: iconSizeFactor,
            textScaleFactor: verseScaleFactor,
          )),
      borderColor: borderColor,
      solidGreyScale: solidGreyScale,
      subChild: subChild,
    );
  }
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    /// WITHOUT ICON
    if (icon == null) {
      return getChild(
        context: context,
        theIcon: null,
        isLoading: loading,
      );
    }

    /// WITH ICON
    else {

      final bool isPicPath = ObjectCheck.objectIsPicPath(icon);
      final String? _rootIcon = FlyerTyper.getRootIcon(icon);
      // final bool isURL = ObjectCheck.isAbsoluteURL(icon);
      // final bool isRaster = ObjectCheck.objectIsJPGorPNG(icon);
      // final bool isSVG = ObjectCheck.objectIsSVG(icon);
      // final bool isFile = ObjectCheck.objectIsFile(icon);
      // final bool isPicModel = icon is PicModel;
      // final bool _isBytes = ObjectCheck.objectIsUint8List(icon);
      // final bool _isBase64 = ObjectCheck.isBase64(icon);
      // final bool _isUiImage = ObjectCheck.objectIsUiImage(icon);
      // final bool _isImgImage = ObjectCheck.objectIsImgImage(icon);

      if (_rootIcon != null){
        return getChild(
          context: context,
          theIcon: _rootIcon,
          isLoading: loading,
        );
      }

      /// PIC PATH
      if (isPicPath == true) {
        return BldrsImagePathToUiImage(
          imagePath: icon,
          builder: (bool loading, ui.Image? uiImage) {
            return getChild(
              context: context,
              theIcon: uiImage,
              isLoading: loading,
            );
          },
        );
      }

      // /// CAN VIEW
      // else if (isURL ||
      //     isRaster ||
      //     isSVG ||
      //     isFile ||
      //     _isBytes ||
      //     _isBase64 ||
      //     _isUiImage ||
      //     _isImgImage ||
      //     isPicModel) {
      //   return getChild(
      //     context: context,
      //     theIcon: icon,
      //   );
      // }

      else {
        return getChild(
          context: context,
          theIcon: icon,
          isLoading: loading,
        );
      }
    }

    // -----------------------------------------------------------------------------
  }
  // --------------------------------------------------------------------------
}
