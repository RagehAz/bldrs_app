import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/j_flyer/z_components/a_structure/e_flyer_box.dart';
import 'package:bldrs/b_views/j_flyer/z_components/b_parts/b_footer/b_footer_box.dart';
import 'package:bldrs/b_views/z_components/images/super_image.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs/f_helpers/drafters/numeric.dart';
import 'package:bldrs/f_helpers/theme/colorz.dart';
import 'package:flutter/material.dart';

class FooterButton extends StatelessWidget {
  /// --------------------------------------------------------------------------
  const FooterButton({
    @required this.flyerBoxWidth,
    @required this.icon,
    @required this.onTap,
    @required this.phid,
    @required this.isOn,
    @required this.canTap,
    @required this.count,
    Key key,
  }) : super(key: key);
  /// --------------------------------------------------------------------------
  final String icon;
  final double flyerBoxWidth;
  final Function onTap;
  final String phid;
  final bool isOn;
  final bool canTap;
  final int count;
  // --------------------
  static double buttonMargin({
    @required double flyerBoxWidth,
  }) {
    return flyerBoxWidth * 0.01;
  }
  // --------------------
  static double buttonRadius({
    @required BuildContext context,
    @required double flyerBoxWidth,
  }) {
    final double _flyerBottomCorners = FooterBox.boxCornersValue(flyerBoxWidth);
    final double _footerBTMargins = buttonMargin(
      flyerBoxWidth: flyerBoxWidth,
    );
    return _flyerBottomCorners - _footerBTMargins;
  }
  // --------------------
  static double buttonSize({
    @required BuildContext context,
    @required double flyerBoxWidth,
  }) {
    return 2 * buttonRadius(
      context: context,
      flyerBoxWidth: flyerBoxWidth,
    );
  }
  // --------------------
  static Color buttonColor({
    @required bool buttonIsOn,
  }) {
    return buttonIsOn ? Colorz.yellow255 : Colorz.black255;
  }
  // --------------------
  static Verse generateButtonVerse({
    @required BuildContext context,
    @required String phid,
    @required int count,
    @required bool isOn,
  }){

    Verse _output = Verse(
      text: phid,
      translate: true,
    );

    final int _count = count ?? 0;
    if (_count >= 1000){
      _output = Verse(
        text: Numeric.formatNumToCounterCaliber(context, _count),
        translate: false,
      );
    }

    if (isOn == true){
      _output = Verse(
        text: phid,
        translate: true,
        casing: Casing.upperCase,
      );
    }

    // blog('generateButtonText : $_output : _count : $_count');

    return _output;
  }
  // --------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _buttonSize = buttonSize(
      context: context,
      flyerBoxWidth: flyerBoxWidth,
    );
    // --------------------
    if (icon == null){
      return SizedBox(
        width: _buttonSize,
        height: _buttonSize,
      );
    }
    // --------------------
    else {
      // --------------------
      final double _saveBTRadius = buttonRadius(
        context: context,
        flyerBoxWidth: flyerBoxWidth,
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
                  verse: generateButtonVerse(
                    context: context,
                    phid: phid,
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
    // --------------------
  }
/// --------------------------------------------------------------------------
}
