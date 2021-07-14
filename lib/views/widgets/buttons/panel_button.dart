import 'package:bldrs/controllers/drafters/borderers.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/views/widgets/buttons/dream_box.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';

class PanelButton extends StatelessWidget {
  final double size;
  final String icon;
  final String verse;
  final Function onTap;
  final double iconSizeFactor;
  final bool blackAndWhite;
  final bool isAuthorButton;
  final double flyerZoneWidth;

  PanelButton({
    this.size,
    this.icon,
    this.verse,
    @required this.onTap,
    this.iconSizeFactor,
    this.blackAndWhite,
    this.isAuthorButton = false,
    @required this.flyerZoneWidth,
  });

  @override
  Widget build(BuildContext context) {

    double _iconSizeFactor = iconSizeFactor == null ? 0.6 : iconSizeFactor;
    bool _blackAndWhite = blackAndWhite == null ? false : blackAndWhite;

    double _buttonSize = size - Ratioz.appBarPadding * 2;

    BorderRadius _authorCorners =
    isAuthorButton == true ?
    Borderers.superLogoShape(context: context, zeroCornerEnIsRight: false, corner: Ratioz.xxflyerAuthorPicCorner * flyerZoneWidth) :
    Borderers.superBorderAll(context,  Ratioz.appBarButtonCorner);
    ;

    return Container(
      width: size,
      height: size * 1.7,
      margin: EdgeInsets.symmetric(vertical: Ratioz.appBarPadding),
      decoration: BoxDecoration(
        color: Colorz.White80,
        borderRadius: Borderers.superBorderAll(context, Ratioz.appBarButtonCorner),
      ),
      child: Column(
        children: <Widget>[

          DreamBox(
            height: _buttonSize,
            width: _buttonSize,
            color: Colorz.White255,
            verseWeight: VerseWeight.thin,
            verseScaleFactor: 0.8,
            verseColor: Colorz.Black255,
            icon: icon,
            iconColor: Colorz.Black255,
            iconSizeFactor: _iconSizeFactor,
            margins: 5,
            blackAndWhite: _blackAndWhite,
            onTap: onTap,
            corners: _authorCorners,
            iconRounded: false,
          ),

          Container(
            width: _buttonSize,
            child: SuperVerse(
              verse: verse,
              color: Colorz.Black255,
              size: 1,
              maxLines: 2,
            ),
          ),

        ],
      ),
    );
  }
}
