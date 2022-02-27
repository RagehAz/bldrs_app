import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/widgets/specific/flyer/parts/pages_parts/slides_page_parts/footer.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';

class PanelButton extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const PanelButton({
    @required this.onTap,
    @required this.flyerBoxWidth,
    // this.size,
    this.icon,
    this.verse,
    this.verseColor = Colorz.white255,
    this.iconSizeFactor = 0.6,
    this.blackAndWhite,
    this.isAuthorButton = false,
    this.color = Colorz.white80,
    Key key,
  }) : super(key: key);

  /// --------------------------------------------------------------------------
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

  /// --------------------------------------------------------------------------
  static Widget panelDot({double panelButtonWidth}) {
    final double _dotSize = panelButtonWidth * 0.15;

    return DreamBox(
      height: _dotSize,
      width: _dotSize,
      color: Colorz.white50,
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

    final double _height = OldFlyerFooter.buttonSize(
        buttonIsOn: false, flyerBoxWidth: flyerBoxWidth, context: context);

    final double _margin = OldFlyerFooter.buttonMargin(
        context: context, buttonIsOn: false, flyerBoxWidth: flyerBoxWidth);
    final EdgeInsets _margins = EdgeInsets.symmetric(vertical: _margin);

    return DreamBox(
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
      onTap: onTap,
    );
  }
}
