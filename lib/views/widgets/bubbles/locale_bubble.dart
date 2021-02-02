import 'package:bldrs/view_brains/drafters/scalers.dart';
import 'package:bldrs/view_brains/theme/colorz.dart';
import 'package:bldrs/view_brains/theme/flagz.dart';
import 'package:bldrs/view_brains/theme/ratioz.dart';
import 'package:bldrs/view_brains/theme/wordz.dart';
import 'package:bldrs/views/widgets/buttons/dream_box.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';
import 'in_pyramids_bubble.dart';

class LocaleBubble extends StatelessWidget {
  final String title;
  final Function tapCountry;
  final Function tapProvince;
  final Function tapArea;
  final String country;
  final String province;
  final String area;

  LocaleBubble({
    @required this.title,
    @required this.tapCountry,
    @required this.tapProvince,
    @required this.tapArea,
    @required this.country,
    @required this.province,
    @required this.area,
});
  // ----------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    double _bubbleClearWidth = superBubbleClearWidth(context);
    double _buttonsSpacing = Ratioz.ddAppBarMargin;
    double _buttonWidth = (_bubbleClearWidth / 3)-((2*_buttonsSpacing)/3);

    return InPyramidsBubble(
        bubbleColor: Colorz.WhiteAir,
        columnChildren: <Widget>[

          SuperVerse(
            verse: title,
            margin: 5,
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[

              // --- COUNTRY BUTTON
              LocaleButton(
                  title: Wordz.country(context),
                  icon: Flagz.egy, //geebCountryFlagByCountryName(context),
                  verse: country,
                  onTap: tapCountry,
              ),

              // --- PROVINCE BUTTON
              LocaleButton(
                title: 'Province', //Wordz.province(context),
                verse: province,
                onTap: tapProvince,
              ),

              // --- AREA BUTTON
              LocaleButton(
                title: 'Area', //Wordz.area(context),
                verse: area,
                onTap: tapArea,
              ),

            ],
          ),
        ]
    );
  }
}

class LocaleButton extends StatelessWidget {
  final String title;
  final String verse;
  final String icon;
  final Function onTap;

  LocaleButton({
    @required this.title,
    @required this.verse,
    this.icon,
    @required this.onTap,
});

  @override
  Widget build(BuildContext context) {

    double _bubbleClearWidth = superBubbleClearWidth(context);
    double _buttonsSpacing = Ratioz.ddAppBarMargin;
    double _buttonWidth = (_bubbleClearWidth / 3)-((2*_buttonsSpacing)/3);

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[

        Container(
          width: _buttonWidth,
          child: SuperVerse(
            verse: title,
            centered: false,
            italic: true,
            weight: VerseWeight.thin,
            size: 2,
            color: Colorz.WhiteSmoke,
          ),
        ),

        DreamBox(
          height: 40,
          width: _buttonWidth,
          verseScaleFactor: 1,
          iconSizeFactor: 0.8,
          icon: icon == null ? null : icon,
          bubble: false,
          verse: verse == null ? '' : verse,
          color: Colorz.WhiteAir,
          boxFunction: onTap,
        ),

      ],
    );
  }
}
