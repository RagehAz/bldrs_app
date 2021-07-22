import 'package:bldrs/controllers/drafters/imagers.dart';
import 'package:bldrs/controllers/drafters/scalers.dart';
import 'package:bldrs/controllers/theme/colorz.dart';
import 'package:bldrs/views/widgets/buttons/dream_box.dart';
import 'package:bldrs/views/widgets/flyer/parts/slides_parts/footer.dart';
import 'package:bldrs/views/widgets/textings/super_verse.dart';
import 'package:flutter/material.dart';

class FooterButton extends StatelessWidget {
  final String icon;
  final double flyerZoneWidth;
  final bool isOn;
  final Function onTap;
  final String verse;
  final double size;

  const FooterButton({
    @required this.icon,
    @required this.flyerZoneWidth,
    @required this.isOn,
    @required this.onTap,
    @required this.verse,
    /// initializing size value overrides all values and suppresses margins
    this.size,

    Key key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    double _footerBTMargins = size != null ? 0 : FlyerFooter.buttonMargin(context: context, flyerZoneWidth: flyerZoneWidth, buttonIsOn: isOn);
    double _saveBTRadius = size != null ? size/2 : FlyerFooter.buttonRadius(context: context, flyerZoneWidth: flyerZoneWidth, buttonIsOn: isOn);
    double _buttonSize = size != null ? size : FlyerFooter.buttonSize(context: context, flyerZoneWidth: flyerZoneWidth, buttonIsOn: isOn);
    bool _microMode = Scale.superFlyerMicroMode(context, flyerZoneWidth);

    return Container(
      width: _buttonSize,
      height: _buttonSize,
      margin: EdgeInsets.all(_footerBTMargins),
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[

          DreamBox(
            icon: _microMode ? icon : null,
            iconSizeFactor: 0.5,
            width: _buttonSize,
            height: _buttonSize,
            corners: _saveBTRadius,
            color: FlyerFooter.buttonColor(buttonIsOn: isOn),
            onTap: (){onTap();},
            childAlignment: Alignment.topCenter,
            subChild:
            _microMode ? null :
            Container(
              width: _buttonSize * 0.8,
              height: _buttonSize * 0.9,
              // color: Colorz.BloodTest,
              child: Imagers.superImageWidget(
                icon,
                scale: 0.7,
              ),
            ),
          ),

          /// verse
          if (!_microMode)
          Positioned(
            bottom: flyerZoneWidth * 0.01,
            child: SuperVerse(
              verse: verse,
              size: 1,
              weight: VerseWeight.bold,
              italic: false,
              scaleFactor: Scale.superFlyerSizeFactorByWidth(context, flyerZoneWidth),
              color: Colorz.White125,
            ),
          ),

        ],
      ),
    );
  }
}
