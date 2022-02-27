import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/images/unfinished_super_image.dart';
import 'package:bldrs/b_views/z_components/texting/unfinished_super_verse.dart';
import 'package:bldrs/b_views/widgets/specific/flyer/parts/old_flyer_zone_box.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/b_footer/b_footer_box.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';

class FooterButton extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const FooterButton({
    @required this.flyerBoxWidth,
    @required this.icon,
    @required this.onTap,
    @required this.verse,
    @required this.isOn,
    @required this.tinyMode,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final String icon;
  final double flyerBoxWidth;
  final Function onTap;
  final String verse;
  final bool isOn;
  final bool tinyMode;
  /// --------------------------------------------------------------------------
  static double buttonMargin({
    @required BuildContext context,
    @required double flyerBoxWidth,
    @required bool tinyMode,
  }) {

    final double _footerBTMargins = (tinyMode == true) ? flyerBoxWidth * 0.01
        :
    flyerBoxWidth * 0.025;

    return _footerBTMargins;
  }
// -----------------------------------------------------------------------------
  static double buttonRadius({
    @required BuildContext context,
    @required double flyerBoxWidth,
    @required bool tinyMode,
  }) {
    final double _flyerBottomCorners = FooterBox.boxCornersValue(flyerBoxWidth);
    final double _footerBTMargins = buttonMargin(
      context: context,
      flyerBoxWidth: flyerBoxWidth,
      tinyMode: tinyMode,
    );

    final double _footerBTRadius = _flyerBottomCorners - _footerBTMargins;
    return _footerBTRadius;
  }
// -----------------------------------------------------------------------------
  static double buttonSize({
    @required BuildContext context,
    @required double flyerBoxWidth,
    @required bool tinyMode,
  }) {
    final double _footerBTRadius = buttonRadius(
      context: context,
      flyerBoxWidth: flyerBoxWidth,
      tinyMode: tinyMode,
    );

    return _footerBTRadius * 2;
  }
// -----------------------------------------------------------------------------
  static Color buttonColor({@required bool buttonIsOn}) {
    const Color _onColor = Colorz.yellow255;
    const Color _offColor = Colorz.black255;

    final Color _color = buttonIsOn ? _onColor : _offColor;

    return _color;
  }
// -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    final double _saveBTRadius = buttonRadius(
      context: context,
      flyerBoxWidth: flyerBoxWidth,
      tinyMode: tinyMode,
    );

    final double _buttonSize = buttonSize(
      context: context,
      flyerBoxWidth: flyerBoxWidth,
      tinyMode: tinyMode,
    );

    final Color _iconAndVerseColor = isOn ? Colorz.black255 : Colorz.white255;
    final Color _splashColor = isOn ? Colorz.black255 : Colorz.yellow255;

    return SizedBox(
      key: const ValueKey<String>('Footer_button'),
      width: _buttonSize,
      height: _buttonSize,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[

          DreamBox(
            iconSizeFactor: 0.4,
            width: _buttonSize,
            height: _buttonSize,
            corners: _saveBTRadius,
            color: FooterButton.buttonColor(buttonIsOn: isOn),
            onTap: tinyMode == true ? null : onTap,
            childAlignment: Alignment.topCenter,
            splashColor: _splashColor,
            bubble: false,
            subChild: SizedBox(
              width: _buttonSize * 0.8,
              height: _buttonSize * 0.9,
              // color: Colorz.BloodTest,
              child: SuperImage(
                pic: icon,
                iconColor: _iconAndVerseColor,
                scale: 0.5,
              ),
            ),
          ),

          /// verse
          if (tinyMode == false)
            Positioned(
              bottom: flyerBoxWidth * 0.01,
              child: SuperVerse(
                verse: isOn == true ? verse.toUpperCase() : verse,
                size: 1,
                scaleFactor: OldFlyerBox.sizeFactorByWidth(context, flyerBoxWidth),
                color: _iconAndVerseColor,
                weight: isOn == true ? VerseWeight.black : VerseWeight.bold,
                italic: isOn,
              ),
            ),

        ],
      ),
    );
  }
}
