import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/buttons/multi_button/b_double_pics_box.dart';
import 'package:bldrs/b_views/z_components/buttons/multi_button/c_many_pics_box.dart';
import 'package:bldrs/f_helpers/drafters/scalers.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:bldrs/f_helpers/theme/iconz.dart';
import 'package:flutter/material.dart';

class MultiButton extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const MultiButton({
    @required this.pics,
    @required this.height,
    this.width,
    this.verse,
    this.secondLine,
    this.color,
    this.margins,
    this.bubble,
    Key key
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final double height;
  final double width;
  final List<String> pics;
  final Verse verse;
  final Verse secondLine;
  final Color color;
  final dynamic margins;
  final bool bubble;
  /// --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return Container(
      width: width,
      height: height,
      margin: Scale.superMargins(margins: margins),
      child: Stack(
        // alignment: Aligners.superCenterAlignment(context),
        children: <Widget>[

          DreamBox(
            width: width,
            height: height,
            verse: verse,
            verseScaleFactor: 0.6,
            verseCentered: false,
            secondLine: secondLine,
            icon: pics.length == 1 ? pics.first : Iconz.dvBlankSVG,
            iconColor: pics.length == 1 ? null : Colorz.nothing,
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
    );

  }

}