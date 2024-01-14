import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bldrs_theme/classes/iconz.dart';
import 'package:bldrs/z_components/buttons/general_buttons/bldrs_box.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:flutter/material.dart';

class TileButton extends StatelessWidget {
  // -----------------------------------------------------------------------------
  const TileButton({
    this.height,
    this.width,
    this.color = Colorz.white10,
    this.onTap,
    this.icon,
    this.verse,
    this.secondLine,
    this.iconSizeFactor = 1,
    this.margins,
    this.isActive = true,
    this.corners,
    this.verseCentered = false,
    super.key
  });
  // -----------------------------------------------------------------------------
  final Verse? verse;
  final Verse? secondLine;
  final double? height;
  final double? width;
  final Color? color;
  final Function? onTap;
  final String? icon;
  final double iconSizeFactor;
  final dynamic margins;
  final bool isActive;
  final dynamic corners;
  final bool verseCentered;
  // -----------------------------------------------------------------------------
  static const double defaultHeight = 40;
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return BldrsBox(
      width: width,
      isDisabled: !isActive,
      // greyscale: !isActive,
      height: height ?? defaultHeight,
      icon: isActive == true ? icon : Iconz.dvBlankSVG,
      iconColor: isActive == true ? null : Colorz.white255,
      verse: verse,
      verseCentered: verseCentered,
      secondLine: secondLine,
      secondLineScaleFactor: 1.2,
      verseScaleFactor: 0.8 / iconSizeFactor,
      secondVerseMaxLines: 1,
      bubble: false,
      color: color,
      onTap: isActive == true ? onTap : null,
      margins: margins,
      iconSizeFactor: iconSizeFactor,
      corners: corners,
    );

  }
  // -----------------------------------------------------------------------------
}
