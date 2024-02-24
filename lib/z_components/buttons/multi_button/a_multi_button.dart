import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bldrs_theme/classes/iconz.dart';
import 'package:basics/helpers/maps/lister.dart';
import 'package:basics/helpers/space/borderers.dart';
import 'package:basics/helpers/space/scale.dart';
import 'package:bldrs/z_components/buttons/general_buttons/bldrs_box.dart';
import 'package:bldrs/z_components/buttons/multi_button/b_double_pics_box.dart';
import 'package:bldrs/z_components/buttons/multi_button/c_many_pics_box.dart';
import 'package:bldrs/z_components/texting/super_verse/verse_model.dart';
import 'package:flutter/material.dart';

class MultiButton extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const MultiButton({
    required this.pics,
    required this.height,
    this.maxWidth,
    this.width,
    this.verse,
    this.secondLine,
    this.color,
    this.margins,
    this.bubble,
    this.onTap,
    this.verseScaleFactor = 0.7,
    this.verseItalic = false,
    this.verseCentered = false,
    this.verseMaxLines,
    this.loading = false,
    this.textColor = Colorz.white255,
    this.borderColor,
    this.corners,
    super.key
  });
  /// --------------------------------------------------------------------------
  final double height;
  final double? maxWidth;
  final double? width;
  final List<dynamic>? pics;
  final Verse? verse;
  final Verse? secondLine;
  final Color? color;
  final dynamic margins;
  final bool? bubble;
  final Function? onTap;
  final bool verseItalic;
  final double? verseScaleFactor;
  final bool verseCentered;
  final int? verseMaxLines;
  final bool loading;
  final Color textColor;
  final Color? borderColor;
  final dynamic corners;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    if (Lister.checkCanLoop(pics) == false || loading == true){
      return BldrsBox(
        width: width,
        maxWidth: maxWidth,
        height: height,
        margins: Scale.superMargins(margin: margins),
        color: color,
        verseMaxLines: verseMaxLines,
        loading: loading,
      );
    }

    else {
      return GestureDetector(
        onTap: onTap == null ? null : () => onTap!(),
        child: Container(
          width: width,
          height: height,
          margin: Scale.superMargins(margin: margins),
          child: Stack(
            // alignment: Aligners.superCenterAlignment(context),
            children: <Widget>[

              BldrsBox(
                width: width,
                maxWidth: maxWidth,
                height: height,
                verse: verse,
                verseScaleFactor: verseScaleFactor,
                verseCentered: verseCentered,
                secondLine: secondLine,
                icon: pics?.length == 1 ? pics?.first : Iconz.dvBlankSVG,
                iconColor: pics?.length == 1 ? null : Colorz.nothing,
                bubble: bubble,
                color: color,
                borderColor: borderColor,
                verseMaxLines: verseMaxLines ?? 2,
                verseItalic: verseItalic,
                verseColor: textColor,
                corners: Borderers.superCorners(corners: corners),
              ),

              if (pics?.length == 2)
                DoublePicsBox(
                  size: height,
                  pics: pics ?? [],
                ),

              if ((pics?.length ?? 0) > 2)
                ManyPicsBox(
                  size: height,
                  textColor: textColor,
                  pics: pics ?? [],
                ),

            ],
          ),
        ),
      );
    }

  }

}
