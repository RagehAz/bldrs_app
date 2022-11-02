import 'package:bldrs/b_views/j_flyer/z_components/x_helpers/x_flyer_color.dart';
import 'package:bldrs/b_views/j_flyer/z_components/x_helpers/x_flyer_dim.dart';
import 'package:bldrs/b_views/j_flyer/z_components/x_helpers/x_flyer_verse.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/images/super_image/a_super_image.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
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
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _buttonSize = FlyerDim.footerButtonSize(
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
      final Color _iconAndVerseColor = isOn ? Colorz.black255 : Colorz.white255;
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
              corners: FlyerDim.footerButtonRadius(
                context: context,
                flyerBoxWidth: flyerBoxWidth,
              ),
              color: FlyerColors.footerButtonColor(buttonIsOn: isOn),
              onTap: canTap == true ? onTap : null,
              childAlignment: Alignment.topCenter,
              splashColor: isOn ? Colorz.black255 : Colorz.yellow255,
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
            if (FlyerDim.isTinyMode(context, flyerBoxWidth) == false)
              Positioned(
                bottom: flyerBoxWidth * 0.01,
                child: SuperVerse(
                  verse: FlyerVerses.generateFooterButtonVerse(
                    context: context,
                    phid: phid,
                    count: count,
                    isOn: isOn,
                  ),
                  size: 1,
                  scaleFactor: FlyerDim.flyerFactorByFlyerWidth(context, flyerBoxWidth),
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
