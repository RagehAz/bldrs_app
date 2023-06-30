import 'package:basics/bldrs_theme/classes/colorz.dart';
import 'package:basics/bldrs_theme/classes/iconz.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/bldrs_box.dart';
import 'package:bldrs/b_views/z_components/buttons/multi_button/b_double_pics_box.dart';
import 'package:bldrs/b_views/z_components/buttons/multi_button/c_many_pics_box.dart';
import 'package:basics/helpers/classes/maps/mapper.dart';
import 'package:basics/helpers/classes/space/scale.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/verse_model.dart';
import 'package:flutter/material.dart';

class MultiButton extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const MultiButton({
    required this.pics,
    required this.height,
    this.width,
    this.verse,
    this.secondLine,
    this.color,
    this.margins,
    this.bubble,
    this.onTap,
    super.key
  });
  /// --------------------------------------------------------------------------
  final double height;
  final double? width;
  final List<String> pics;
  final Verse? verse;
  final Verse? secondLine;
  final Color? color;
  final dynamic margins;
  final bool? bubble;
  final Function? onTap;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    if (Mapper.checkCanLoopList(pics) == false){
      return BldrsBox(
        width: width,
        height: height,
        margins: Scale.superMargins(margin: margins),
        color: color,
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
                height: height,
                verse: verse,
                verseScaleFactor: 0.6,
                verseCentered: false,
                secondLine: secondLine,
                icon: pics?.length == 1 ? pics.first : Iconz.dvBlankSVG,
                iconColor: pics?.length == 1 ? null : Colorz.nothing,
                bubble: bubble,
                color: color,
                verseMaxLines: 2,
              ),

              if (pics.length == 2)
                DoublePicsBox(
                  size: height,
                  pics: pics,
                ),

              if (pics.length > 2)
                ManyPicsBox(
                  size: height,
                  pics: pics,
                ),

            ],
          ),
        ),
      );
    }


  }

}
