import 'package:bldrs/b_views/j_flyer/z_components/x_helpers/x_flyer_color.dart';
import 'package:bldrs/b_views/j_flyer/z_components/x_helpers/x_flyer_dim.dart';
import 'package:bldrs/b_views/j_flyer/z_components/x_helpers/x_flyer_verse.dart';
import 'package:bldrs/b_views/z_components/buttons/dream_box/dream_box.dart';
import 'package:bldrs/b_views/z_components/texting/super_verse/super_verse.dart';
import 'package:bldrs_theme/bldrs_theme.dart';
import 'package:flutter/material.dart';
import 'package:scale/scale.dart';
import 'package:websafe_svg/websafe_svg.dart';

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
    this.color,
    this.isLoading = false,
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
  final Color color;
  final bool isLoading;
  // --------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    final double _buttonSize = FlyerDim.footerButtonSize(
      context: context,
      flyerBoxWidth: flyerBoxWidth,
    );
    // --------------------
    if (icon == null && color == null){
      return SizedBox(
        width: _buttonSize,
        height: _buttonSize,
      );
    }
    else if (icon == null && color != null){
      return Container(
        width: _buttonSize,
        height: _buttonSize,
         decoration: BoxDecoration(
           color: Colorz.black255,
           borderRadius: Borderers.superCorners(
               context: context,
               corners: _buttonSize * 0.5,
           ),
         )
      );
    }
    // --------------------
    else {
      // --------------------
      final Color _iconAndVerseColor = isOn ? Colorz.black255 : Colorz.white255;

      final bool _isTinyMode = FlyerDim.isTinyMode(
        flyerBoxWidth: flyerBoxWidth,
        gridWidth: Scale.screenWidth(context),
        gridHeight: Scale.screenHeight(context),
      );

      // --------------------
      return SizedBox(
        key: const ValueKey<String>('Footer_button'),
        width: _buttonSize,
        height: _buttonSize,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[

            /// ICON
            BldrsBox(
              iconSizeFactor: 0.4,
              width: _buttonSize,
              height: _buttonSize,
              corners: FlyerDim.footerButtonRadius(
                context: context,
                flyerBoxWidth: flyerBoxWidth,
              ),
              color: color ?? FlyerColors.footerButtonColor(buttonIsOn: isOn),
              onTap: canTap == true ? onTap : null,
              childAlignment: Alignment.topCenter,
              splashColor: isOn ? Colorz.black255 : Colorz.yellow255,
              bubble: false,
              loading: isLoading,
              subChild: SizedBox(
                width: _buttonSize * 0.8,
                height: _buttonSize * 0.9,
                child: Transform.scale(
                  scale: 0.5,
                  child: WebsafeSvg.asset(
                    icon,
                      color: _iconAndVerseColor,
                      // package: Iconz.bldrsTheme,
                      // fit: BoxFit.fitWidth,
                      width: _buttonSize * 0.8,
                      height: _buttonSize * 0.9 ,
                    // alignment: Alignment.center,
                    ),
                ),
              ),
            ),

            /// VERSE
            if (_isTinyMode == false)
              Positioned(
                bottom: flyerBoxWidth * 0.01,
                child: BldrsText(
                  verse: FlyerVerses.generateFooterButtonVerse(
                    context: context,
                    phid: phid,
                    count: count,
                    isOn: isOn,
                  ),
                  size: 1,
                  scaleFactor: flyerBoxWidth * 0.003,
                  color: _iconAndVerseColor.withOpacity(0.4),
                  weight: isOn == true ? VerseWeight.black : VerseWeight.thin,
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
