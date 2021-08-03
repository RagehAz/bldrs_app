import 'package:bldrs/controllers/drafters/imagers.dart';
import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/views/widgets/buttons/dream_box/dream_box.dart';
import 'package:bldrs/views/widgets/flyer/parts/pages_parts/slides_page_parts/footer.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';

class FooterButton extends StatelessWidget {
  final String icon;
  final double flyerZoneWidth;
  final Function onTap;
  final String verse;
  final double size;
  final bool inActiveMode;

  /// needed for ankh button value
  final bool isOn;

  const FooterButton({
    @required this.icon,
    @required this.flyerZoneWidth,
    @required this.onTap,
    @required this.verse,
    /// initializing size value overrides all values and suppresses margins
    this.size,
    this.inActiveMode = false,

    this.isOn = false,
    Key key
  });

  @override
  Widget build(BuildContext context) {

    double _footerBTMargins = size != null ? 0 : FlyerFooter.buttonMargin(context: context, flyerZoneWidth: flyerZoneWidth, buttonIsOn: isOn);
    double _saveBTRadius = size != null ? size/2 : FlyerFooter.buttonRadius(context: context, flyerZoneWidth: flyerZoneWidth, buttonIsOn: isOn);
    double _buttonSize = size != null ? size : FlyerFooter.buttonSize(context: context, flyerZoneWidth: flyerZoneWidth, buttonIsOn: isOn);
    bool _tinyMode = Scale.superFlyerTinyMode(context, flyerZoneWidth);

    return Container(
      width: _buttonSize,
      height: _buttonSize,
      margin: EdgeInsets.all(_footerBTMargins),
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[

          DreamBox(
            icon: _tinyMode ? icon : null,
            iconSizeFactor: 0.5,
            width: _buttonSize,
            height: _buttonSize,
            corners: _saveBTRadius,
            color: FlyerFooter.buttonColor(buttonIsOn: isOn),
            onTap: inActiveMode == true ? null : onTap,
            childAlignment: Alignment.topCenter,
            inActiveMode: inActiveMode,
            bubble: true,
            subChild:
            _tinyMode ? null :
            Container(
              width: _buttonSize * 0.8,
              height: _buttonSize * 0.9,
              // color: Colorz.BloodTest,
              child: Imagers.superImageWidget(
                icon,
                iconColor: DreamBox.getIconColor(inActiveMode: inActiveMode),
                scale: 0.7,
              ),
            ),
          ),

          /// verse
          if (!_tinyMode)
          Positioned(
            bottom: flyerZoneWidth * 0.01,
            child: SuperVerse(
              verse: verse,
              size: 1,
              weight: VerseWeight.bold,
              italic: false,
              scaleFactor: Scale.superFlyerSizeFactorByWidth(context, flyerZoneWidth),
              color: DreamBox.getIconColor(inActiveMode: inActiveMode, colorOverride: Colorz.White125),
            ),
          ),

        ],
      ),
    );
  }
}
