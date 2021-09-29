import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/views/widgets/general/buttons/dream_box/dream_box.dart';
import 'package:bldrs/views/widgets/specific/flyer/parts/pages_parts/slides_page_parts/footer.dart';
import 'package:flutter/material.dart';

class PanelButton extends StatelessWidget {
  // final double size;
  final String icon;
  final String verse;
  final Color verseColor;
  final Function onTap;
  final double iconSizeFactor;
  final bool blackAndWhite;
  final bool isAuthorButton;
  final double flyerBoxWidth;
  final Color color;

  PanelButton({
    // this.size,
    this.icon,
    this.verse,
    this.verseColor = Colorz.White255,
    @required this.onTap,
    this.iconSizeFactor = 0.6,
    this.blackAndWhite,
    this.isAuthorButton = false,
    @required this.flyerBoxWidth,
    this.color = Colorz.White80,
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
    // Borderers.superLogoShape(context: context, zeroCornerEnIsRight: false, corner: Ratioz.xxflyerAuthorPicCorner * flyerBoxWidth) :
    // Borderers.superBorderAll(context,  Ratioz.appBarButtonCorner);
    // ;

    double _height = FlyerFooter.buttonSize(
      buttonIsOn: false,
      flyerBoxWidth: flyerBoxWidth,
      context: context
    );

    double _margin = FlyerFooter.buttonMargin(context: context, buttonIsOn: false, flyerBoxWidth: flyerBoxWidth);
    EdgeInsets _margins = EdgeInsets.symmetric(vertical: _margin);

    return
      DreamBox(
        width: _height / 1.4,
        height: _height,
        margins: _margins,
        color: color,
        icon: icon,
        iconSizeFactor: iconSizeFactor,
        iconColor: verseColor,
        underLine: verse,
        underLineShadowIsOn: false,
        underLineColor: verseColor,
        // verseScaleFactor: 1.2,
        // corners: Borderers.superLogoShape(context: context, zeroCornerEnIsRight: false, corner: Ratioz.xxflyerAuthorPicCorner * flyerBoxWidth),
        bubble: true,
        onTap: onTap,
      );

  }
}




