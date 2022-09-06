import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/flyer/a_flyer_structure/e_flyer_box.dart';
import 'package:bldrs/b_views/z_components/flyer/b_flyer_parts/b_footer/b_footer_box.dart';
import 'package:bldrs/b_views/z_components/images/super_image.dart';
import 'package:bldrs/b_views/z_components/sizing/expander.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse.dart';
import 'package:bldrs/f_helpers/drafters/numeric.dart';
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
    @required this.canTap,
    @required this.count,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final String icon;
  final double flyerBoxWidth;
  final Function onTap;
  final String verse;
  final bool isOn;
  final bool canTap;
  final int count;
  // --------------------
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
  // --------------------
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
  // --------------------
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
  // --------------------
  static Color buttonColor({
    @required bool buttonIsOn,
  }) {
    const Color _onColor = Colorz.yellow255;
    const Color _offColor = Colorz.black255;

    final Color _color = buttonIsOn ? _onColor : _offColor;

    return _color;
  }
  // --------------------
  static String generateButtonText({
    @required BuildContext context,
    @required String verse,
    @required int count,
    @required bool isOn,
  }){

    String _output = verse;

    final int _count = count ?? 0;
    if (_count >= 1000){
      _output = Numeric.formatNumToCounterCaliber(context, _count);
    }

    if (isOn == true){
      _output = _output.toUpperCase();
    }

    blog('generateButtonText : $_output : _count : $_count');

    return _output;
  }
  // --------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _saveBTRadius = buttonRadius(
      context: context,
      flyerBoxWidth: flyerBoxWidth,
      tinyMode: !canTap,
    );
    // --------------------
    final double _buttonSize = buttonSize(
      context: context,
      flyerBoxWidth: flyerBoxWidth,
      tinyMode: !canTap,
    );
    // --------------------
    final Color _iconAndVerseColor = isOn ? Colorz.black255 : Colorz.white255;
    final Color _splashColor = isOn ? Colorz.black255 : Colorz.yellow255;
    // --------------------
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
            onTap: canTap == true ? onTap : null,
            childAlignment: Alignment.topCenter,
            splashColor: _splashColor,
            bubble: false,
            subChild: SizedBox(
              width: _buttonSize * 0.8,
              height: _buttonSize * 0.9,
              // color: Colorz.BloodTest,
              child: SuperImage(
                width: _buttonSize * 0.8,
                height: _buttonSize * 0.9,
                pic: icon,
                iconColor: _iconAndVerseColor,
                scale: 0.5,
              ),
            ),
          ),

          /// verse
          if (FlyerBox.isTinyMode(context, flyerBoxWidth) == false)
            Positioned(
              bottom: flyerBoxWidth * 0.01,
              child: SuperVerse(
                verse: generateButtonText(
                  context: context,
                  verse: verse,
                  count: count,
                  isOn: isOn,
                ),
                size: 1,
                scaleFactor: FlyerBox.sizeFactorByWidth(context, flyerBoxWidth),
                color: _iconAndVerseColor,
                weight: isOn == true ? VerseWeight.black : VerseWeight.bold,
                italic: isOn,
              ),
            ),

        ],
      ),
    );
    // --------------------
  }
/// --------------------------------------------------------------------------
}
