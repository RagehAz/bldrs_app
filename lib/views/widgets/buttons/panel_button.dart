import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/controllers/theme/ratioz.dart';
import 'package:bldrs/views/widgets/buttons/dream_box.dart';
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
    this.iconSizeFactor = 0.6,
    this.blackAndWhite,
    this.isAuthorButton = false,
    @required this.flyerZoneWidth,
  });

  static Widget panelDot({double panelButtonWidth}){

    double _dotSize = panelButtonWidth * 0.15;

    return
        DreamBox(
          height: _dotSize,
          width: _dotSize,
          color: Colorz.White50,
          corners: _dotSize * 0.5,
          margins: _dotSize * 0.5,
        );
  }

  @override
  Widget build(BuildContext context) {

    // BorderRadius _authorCorners =
    // isAuthorButton == true ?
    // Borderers.superLogoShape(context: context, zeroCornerEnIsRight: false, corner: Ratioz.xxflyerAuthorPicCorner * flyerZoneWidth) :
    // Borderers.superBorderAll(context,  Ratioz.appBarButtonCorner);
    // ;

    return
      DreamBox(
        width: size,
        height: size * 1.35,
        margins: EdgeInsets.symmetric(vertical: Ratioz.appBarPadding),
        color:  Colorz.White80,
        icon: icon,
        iconSizeFactor: iconSizeFactor,
        underLine: verse,
        underLineShadowIsOn: false,
        underLineColor: Colorz.White255,
        // verseScaleFactor: 1.2,
        // corners: Borderers.superLogoShape(context: context, zeroCornerEnIsRight: false, corner: Ratioz.xxflyerAuthorPicCorner * flyerZoneWidth),
        bubble: true,
        onTap: onTap,
      );

  }
}




